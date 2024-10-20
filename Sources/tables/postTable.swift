import Foundation

class postTable {
    var formatInt32: Int32
    var format: Double
    var italicAngleInt32: Int32
    var italicAngle: Double
    var underlinePosition: Int16
    var underlineThickness: Int16
    var isFixedPitch: UInt32
    var minMemType42: UInt32
    var maxMemType42: UInt32
    var minMemType1: UInt32
    var maxMemType1: UInt32

    var postTableOffset: UInt32

    func getFormatInt32() -> Int32 { return self.formatInt32 }
    func getFormat() -> Double { return self.format }
    func getItalicAngleInt32() -> Int32 { return self.italicAngleInt32 }
    func getItalicAngle() -> Double { return self.italicAngle }
    func getUnderlinePosition() -> Int16 { return self.underlinePosition }
    func getUnderlineThickness() -> Int16 { return self.underlineThickness }
    func getIsFixedPitch() -> UInt32 { return self.isFixedPitch }
    func getMinMemType42() -> UInt32 { return self.minMemType42 }
    func getMaxMemType42() -> UInt32 { return self.maxMemType42 }
    func getMinMemType1() -> UInt32 { return self.minMemType1 }
    func getMaxMemType1() -> UInt32 { return self.maxMemType1 }

    init(rawData: Data) {
        let FontHeader: FontHeader = FontHeader(rawData: rawData)
        postTableOffset = FontHeader.findTableOffset(forTag: "post")
        let fileIO: FileIO = FileIO()
        self.formatInt32 = fileIO.getInt32(rawData: rawData, at: postTableOffset) // 01 - 04
        self.format = Double(self.formatInt32) / 65536.0
        self.italicAngleInt32 = fileIO.getInt32(rawData: rawData, at: postTableOffset + 4) // 04 - 08
        self.italicAngle = abs(Double(self.italicAngleInt32) / 65536.0)
        self.underlinePosition = fileIO.getInt16(rawData: rawData, at: postTableOffset + 8) // 08 - 10
        self.underlineThickness = fileIO.getInt16(rawData: rawData, at: postTableOffset + 10) // 10 - 12
        self.isFixedPitch = fileIO.getUInt32(rawData: rawData, at: postTableOffset + 12) // 12 - 16
        self.minMemType42 = fileIO.getUInt32(rawData: rawData, at: postTableOffset + 16) // 16 - 20
        self.maxMemType42 = fileIO.getUInt32(rawData: rawData, at: postTableOffset + 20) // 20 - 24
        self.minMemType1 = fileIO.getUInt32(rawData: rawData, at: postTableOffset + 24) // 24 - 28
        self.maxMemType1 = fileIO.getUInt32(rawData: rawData, at: postTableOffset + 28) // 28 - 32
    }
}