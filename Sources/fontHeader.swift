import Foundation

/*
Font Block 1:
uint32 	scaler type 	A tag to indicate the OFA scaler to be used to rasterize this font; see the note on the scaler type below for more information.
uint16 	numTables 	    number of tables
uint16 	searchRange 	(maximum power of 2 <= numTables) * 16
uint16 	entrySelector 	log2(maximum power of 2 <= numTables)
uint16 	rangeShift 	    numTables * 16 - searchRange
*/

class FontHeader {
    var scalerType: UInt32
    var numTables: UInt16
    var searchRange: UInt16
    var entrySelector: UInt16
    var rangeShift: UInt16

    func getScalerType() -> UInt32 { return self.scalerType }
    func getNumTables() -> UInt16 { return self.numTables }
    func getSearchRange() -> UInt16 { return self.searchRange }
    func getEntrySelector() -> UInt16 { return self.entrySelector }
    func getRangeShift() -> UInt16 { return self.rangeShift }

    init(rawData: Data) {
        self.scalerType = rawData.subdata(in: 0..<4).withUnsafeBytes { $0.load(as: UInt32.self) }.bigEndian
        self.numTables = rawData.subdata(in: 4..<6).withUnsafeBytes { $0.load(as: UInt16.self) }.bigEndian
        self.searchRange = rawData.subdata(in: 6..<8).withUnsafeBytes { $0.load(as: UInt16.self) }.bigEndian
        self.entrySelector = rawData.subdata(in: 8..<10).withUnsafeBytes { $0.load(as: UInt16.self) }.bigEndian
        self.rangeShift = rawData.subdata(in: 10..<12).withUnsafeBytes { $0.load(as: UInt16.self) }.bigEndian
    }
}
