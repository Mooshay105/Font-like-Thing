import Foundation

class locaTable {
    var indexToLocFormat: Int16
    var offsetShort: [UInt16]
    var offsetLong: [UInt32]

    var locaTableOffset: UInt32

    func getOffsetShort(id i: Int) -> UInt16 { return self.offsetShort[i] }
    func getOffsetLong(id i: Int) -> UInt32 { return self.offsetLong[i] }

    init(rawData: Data) {
        let FontHeader: FontHeader = FontHeader(rawData: rawData)
        let headTable: headTable = headTable(rawData: rawData)
        let maxpTable: maxpTable = maxpTable(rawData: rawData)
        locaTableOffset = FontHeader.findTableOffset(forTag: "loca")
        let fileIO: FileIO = FileIO()

        self.indexToLocFormat = headTable.getIndexToLocFormat()
        self.offsetShort = []
        self.offsetLong = []
        for i: UInt16 in 0..<maxpTable.getNumGlyphs()+1 {
            self.offsetShort.append(fileIO.getUInt16(rawData: rawData, at: UInt32(locaTableOffset + UInt32(i) * 2)))
        }
        for i: UInt16 in 0..<maxpTable.getNumGlyphs()+1 {
            self.offsetLong.append(fileIO.getUInt32(rawData: rawData, at: UInt32(locaTableOffset + UInt32(i) * 4)))
        }         
    }

}