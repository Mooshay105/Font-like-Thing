import Foundation

/*
    Expected Tables:
     - 'cmap' 	character to glyph mapping
     - 'glyf' 	glyph data
     - 'head' 	font header
     - 'hhea' 	horizontal header
     - 'hmtx' 	horizontal metrics
     - 'loca' 	index to location
     - 'maxp' 	maximum profile
     - 'name' 	naming
     - 'post' 	PostScript
    
    Optional Tables:
     - 'cvt ' 	control value
     - 'fpgm' 	font program
     - 'hdmx' 	horizontal device metrics
     - 'kern' 	kerning
     - 'OS/2' 	OS/2
     - 'prep' 	control value program
    
    Block 1:
    uint32 	scaler type 	A tag to indicate the OFA scaler to be used to rasterize this font; see the note on the scaler type below for more information.
    uint16 	numTables 	    number of tables
    uint16 	searchRange 	(maximum power of 2 <= numTables) * 16
    uint16 	entrySelector 	log2(maximum power of 2 <= numTables)
    uint16 	rangeShift 	    numTables * 16 - searchRange

    Block 2:
    uint32 	tag 	        4-byte identifier (e.g. "name")
    uint32 	checkSum 	    checksum for this table (to detect corruption)
    uint32 	offset 	        offset from beginning of sfnt (byte offset from beginning of file)
    uint32 	length 	        length of this table in byte (actual length not padded length) (e.g. 12 for "name" table)
*/

class FontHeader {
    var scalerType: UInt32
    var numTables: UInt16
    var searchRange: UInt16
    var entrySelector: UInt16
    var rangeShift: UInt16
    var tag: [UInt32]
    var checkSum: [UInt32]
    var offset: [UInt32]
    var length: [UInt32]
    var glyfOffset: UInt32
    var endOfHeaderLocation: UInt32

    func getScalerType() -> UInt32 { return self.scalerType }
    func getNumTables() -> UInt16 { return self.numTables }
    func getSearchRange() -> UInt16 { return self.searchRange }
    func getEntrySelector() -> UInt16 { return self.entrySelector }
    func getRangeShift() -> UInt16 { return self.rangeShift }
    func getTag(id i: Int) -> UInt32 { return self.tag[i] }
    func getCheckSum(id i: Int) -> UInt32 { return self.checkSum[i] }
    func getOffset(id i: Int) -> UInt32 { return self.offset[i] }
    func getLength(id i: Int) -> UInt32 { return self.length[i] }
    // WARN: May Return `0` if `Glyf Offset` is not found.
    func getGlyfOffset() -> UInt32 { return self.glyfOffset }
    func getEndOfHeaderLocation() -> UInt32 { return self.endOfHeaderLocation }

    init(rawData: Data) {
        self.scalerType = rawData.subdata(in: 0..<4).withUnsafeBytes { $0.load(as: UInt32.self) }.bigEndian
        self.numTables = rawData.subdata(in: 4..<6).withUnsafeBytes { $0.load(as: UInt16.self) }.bigEndian
        self.searchRange = rawData.subdata(in: 6..<8).withUnsafeBytes { $0.load(as: UInt16.self) }.bigEndian
        self.entrySelector = rawData.subdata(in: 8..<10).withUnsafeBytes { $0.load(as: UInt16.self) }.bigEndian
        self.rangeShift = rawData.subdata(in: 10..<12).withUnsafeBytes { $0.load(as: UInt16.self) }.bigEndian
        self.tag = []
        self.checkSum = []
        self.offset = []
        self.length = []
        self.glyfOffset = 0
        // NOTE: The `End Of Header Location` will allways be set and if it is not there are bigger issues, we just need to set it to make the compiler happy.
        self.endOfHeaderLocation = 0
        // Get the table data.
        for i: UInt16 in 0..<self.numTables {
            let tagIndex: Int = 12 + Int(i) * 16
            self.tag.append(rawData.subdata(in: tagIndex..<tagIndex + 4).withUnsafeBytes { $0.load(as: UInt32.self) }.bigEndian)
            self.checkSum.append(rawData.subdata(in: tagIndex + 4..<tagIndex + 8).withUnsafeBytes { $0.load(as: UInt32.self) }.bigEndian)
            self.offset.append(rawData.subdata(in: tagIndex + 8..<tagIndex + 12).withUnsafeBytes { $0.load(as: UInt32.self) }.bigEndian)
            self.length.append(rawData.subdata(in: tagIndex + 12..<tagIndex + 16).withUnsafeBytes { $0.load(as: UInt32.self) }.bigEndian)

            // Only run on last iteration.
            if i == self.numTables - 1 {
                self.endOfHeaderLocation = UInt32(tagIndex + 16)
            }
        }
        // Get the `Glyf Offset`.
        for i: UInt16 in 0..<self.numTables {
            if self.tag[Int(i)] == 0x676C7966 {
                self.glyfOffset = self.offset[Int(i)]
            }
        }
    }
}
