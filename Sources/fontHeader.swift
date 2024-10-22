import Foundation

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
    func getEndOfHeaderLocation() -> UInt32 { return self.endOfHeaderLocation }

    func findTableOffset(forTag tableTag: String) -> UInt32 {
        var tagValue: UInt32 = 0
        for character: String.UTF8View.Element in tableTag.utf8 {
            tagValue = (tagValue << 8) | UInt32(character)
        }
        for i: UInt16 in 0..<self.numTables {
            if self.tag[Int(i)] == tagValue {
                return self.offset[Int(i)]
            }
        }
        return 0
    }

    init(rawData: Data) {
        let fileIO: FileIO = FileIO()
        self.scalerType = fileIO.getUInt32(rawData: rawData, at: 0)
        self.numTables = fileIO.getUInt16(rawData: rawData, at: 4)
        self.searchRange = fileIO.getUInt16(rawData: rawData, at: 6)
        self.entrySelector = fileIO.getUInt16(rawData: rawData, at: 8)
        self.rangeShift = fileIO.getUInt16(rawData: rawData, at: 10)
        self.tag = []
        self.checkSum = []
        self.offset = []
        self.length = []
        self.endOfHeaderLocation = 0
        // Get the table data.
        for i: UInt16 in 0..<self.numTables {
            let tagIndex: Int = 12 + Int(i) * 16
            self.tag.append(fileIO.getUInt32(rawData: rawData, at: UInt32(tagIndex)))
            self.checkSum.append(fileIO.getUInt32(rawData: rawData, at: UInt32(tagIndex + 4)))
            self.offset.append(fileIO.getUInt32(rawData: rawData, at: UInt32(tagIndex + 8)))
            self.length.append(fileIO.getUInt32(rawData: rawData, at: UInt32(tagIndex + 12)))
            self.endOfHeaderLocation = UInt32(tagIndex + 16)
        }
    }
}
