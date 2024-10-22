import Foundation

class cmapTable {
    var version: UInt16
    var numTables: UInt16
    var platformID: [UInt16]
    var platformSpecificID: [UInt16]
    var offset: [UInt32]

    // NOTE: The unicodeIndex is the table index of the unicode table.
    var numberOfUnicodeTables: UInt16
    var unicodeIndex: [UInt16]
    var cmapTableOffset: UInt32

    func getVersion() -> UInt16 { return self.version }
    func getNumTables() -> UInt16 { return self.numTables }
    func getPlatformID(id i: Int) -> UInt16 { return self.platformID[i] }
    func getPlatformSpecificID(id i: Int) -> UInt16 { return self.platformSpecificID[i] }
    func getOffset(id i: Int) -> UInt32 { return self.offset[i] }
    func getUnicodeIndex(id i: Int) -> UInt16 { return self.unicodeIndex[i] }

    init(rawData: Data) {
        let FontHeader: FontHeader = FontHeader(rawData: rawData)
        cmapTableOffset = FontHeader.findTableOffset(forTag: "cmap")
        let fileIO: FileIO = FileIO()
        self.version = fileIO.getUInt16(rawData: rawData, at: cmapTableOffset)
        self.numTables = fileIO.getUInt16(rawData: rawData, at: cmapTableOffset + 2)
        self.platformID = []
        self.platformSpecificID = []
        self.offset = []
        self.unicodeIndex = []
        self.numberOfUnicodeTables = 0
        for i: UInt16 in 0..<self.numTables {
            let platformID: UInt16 = fileIO.getUInt16(rawData: rawData, at: UInt32(cmapTableOffset + 4 + UInt32(i) * 8))
            let platformSpecificID: UInt16 = fileIO.getUInt16(rawData: rawData, at: UInt32(cmapTableOffset + 6 + UInt32(i) * 8))
            let offset: UInt32 = fileIO.getUInt32(rawData: rawData, at: UInt32(cmapTableOffset + 8 + UInt32(i) * 8))
            self.platformID.append(platformID)
            self.platformSpecificID.append(platformSpecificID)
            if i == 0 { self.offset.append(0) }
            self.offset.append(offset)
            if platformID == 0 { self.unicodeIndex.append(UInt16(i+1)) }
            self.numberOfUnicodeTables = UInt16(self.unicodeIndex.count)
        }
    }
}
