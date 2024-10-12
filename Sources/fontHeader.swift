import Foundation

/*
    Font Block 1:
    uint32 	scaler type 	A tag to indicate the OFA scaler to be used to rasterize this font; see the note on the scaler type below for more information.
    uint16 	numTables 	    number of tables
    uint16 	searchRange 	(maximum power of 2 <= numTables) * 16
    uint16 	entrySelector 	log2(maximum power of 2 <= numTables)
    uint16 	rangeShift 	    numTables * 16 - searchRange
    Font Block 2:
    uint32 	tag 	        4-byte identifier (e.g. "name")
    uint32 	checkSum 	    checksum for this table (to detect corruption)
    uint32 	offset 	        offset from beginning of sfnt (byte offset from beginning of file)
    uint32 	length 	        length of this table in byte (actual length not padded length) (e.g. 12 for "name" table)
*/

class FontHeader {
    // Block 1
    var scalerType: UInt32
    var numTables: UInt16
    var searchRange: UInt16
    var entrySelector: UInt16
    var rangeShift: UInt16
    // Block 2
    var tag: [UInt32]
    var checkSum: [UInt32]
    var offset: [UInt32]
    var length: [UInt32]

    // Block 1
    func getScalerType() -> UInt32 { return self.scalerType }
    func getNumTables() -> UInt16 { return self.numTables }
    func getSearchRange() -> UInt16 { return self.searchRange }
    func getEntrySelector() -> UInt16 { return self.entrySelector }
    func getRangeShift() -> UInt16 { return self.rangeShift }

    // Block 2
    func getTag(id i: Int) -> UInt32 { return self.tag[i] }
    func getCheckSum(id i: Int) -> UInt32 { return self.checkSum[i] }
    func getOffset(id i: Int) -> UInt32 { return self.offset[i] }
    func getLength(id i: Int) -> UInt32 { return self.length[i] }

    init(rawData: Data) {
        // Block 1
        self.scalerType = rawData.subdata(in: 0..<4).withUnsafeBytes { $0.load(as: UInt32.self) }.bigEndian
        self.numTables = rawData.subdata(in: 4..<6).withUnsafeBytes { $0.load(as: UInt16.self) }.bigEndian
        self.searchRange = rawData.subdata(in: 6..<8).withUnsafeBytes { $0.load(as: UInt16.self) }.bigEndian
        self.entrySelector = rawData.subdata(in: 8..<10).withUnsafeBytes { $0.load(as: UInt16.self) }.bigEndian
        self.rangeShift = rawData.subdata(in: 10..<12).withUnsafeBytes { $0.load(as: UInt16.self) }.bigEndian

        // Block 2
        self.tag = []
        self.checkSum = []
        self.offset = []
        self.length = []

        for i in 0..<self.numTables {
            let tagIndex = 12 + Int(i) * 16
            self.tag.append(rawData.subdata(in: tagIndex..<tagIndex + 4).withUnsafeBytes { $0.load(as: UInt32.self) }.bigEndian)
            self.checkSum.append(rawData.subdata(in: tagIndex + 4..<tagIndex + 8).withUnsafeBytes { $0.load(as: UInt32.self) }.bigEndian)
            self.offset.append(rawData.subdata(in: tagIndex + 8..<tagIndex + 12).withUnsafeBytes { $0.load(as: UInt32.self) }.bigEndian)
            self.length.append(rawData.subdata(in: tagIndex + 12..<tagIndex + 16).withUnsafeBytes { $0.load(as: UInt32.self) }.bigEndian)
        }
    }
}
