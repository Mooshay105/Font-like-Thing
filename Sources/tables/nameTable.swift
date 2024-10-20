import Foundation

class nameTable {

    struct nameRecord {
        var platformID: UInt16
        var platformSpecificID: UInt16
        var languageID: UInt16
        var nameID: UInt16
        var length: UInt16
        var offset: UInt16
    }

    var format: UInt16
    var count: UInt16
    var stringOffset: UInt16
    var nameRecords: [nameRecord]

    var nameTableOffset: UInt32

    func getFormat() -> UInt16 { return self.format }
    func getCount() -> UInt16 { return self.count }
    func getStringOffset() -> UInt16 { return self.stringOffset }
    func getNameRecords() -> [nameRecord] { return self.nameRecords }

    init(rawData: Data) {
        let FontHeader: FontHeader = FontHeader(rawData: rawData)
        nameTableOffset = FontHeader.findTableOffset(forTag: "name")
        let fileIO: FileIO = FileIO()
        self.format = fileIO.getUInt16(rawData: rawData, at: nameTableOffset)
        self.count = fileIO.getUInt16(rawData: rawData, at: nameTableOffset + 2)
        self.stringOffset = fileIO.getUInt16(rawData: rawData, at: nameTableOffset + 4)
        self.nameRecords = []
        for i: UInt16 in 0..<self.count {
            let platformID: UInt16 = fileIO.getUInt16(rawData: rawData, at: UInt32(nameTableOffset + UInt32(6 + UInt32(i) * 12)))
            let platformSpecificID: UInt16 = fileIO.getUInt16(rawData: rawData, at: UInt32(nameTableOffset + UInt32(6 + UInt32(i) * 12 + 2)))
            let languageID: UInt16 = fileIO.getUInt16(rawData: rawData, at: UInt32(nameTableOffset + UInt32(6 + UInt32(i) * 12 + 4)))
            let nameID: UInt16 = fileIO.getUInt16(rawData: rawData, at: UInt32(nameTableOffset + UInt32(6 + UInt32(i) * 12 + 6)))
            let length: UInt16 = fileIO.getUInt16(rawData: rawData, at: UInt32(nameTableOffset + UInt32(6 + UInt32(i) * 12 + 8)))
            let offset: UInt16 = fileIO.getUInt16(rawData: rawData, at: UInt32(nameTableOffset + UInt32(6 + UInt32(i) * 12 + 10)))
            self.nameRecords.append(nameRecord(platformID: platformID, platformSpecificID: platformSpecificID, languageID: languageID, nameID: nameID, length: length, offset: offset))
        }
    }
}