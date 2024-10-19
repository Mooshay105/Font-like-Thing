import Foundation

class HeadTable {
    // version, fontRevision & checkSumAdjustment are not accessible.
    var magicNumber: UInt32
    var flags: UInt16
    var unitsPerEm: UInt16
    var created: Int64
    var modified: Int64
    var xMin: Int16
    var yMin: Int16
    var xMax: Int16
    var yMax: Int16
    var macStyle: UInt16
    var lowestRecPPEM: UInt16
    var fontDirectionHint: Int16
    var indexToLocFormat: Int16
    var glyphDataFormat: Int16

    var headTableOffset: UInt32

    func getMagicNumber() -> UInt32 { return self.magicNumber }
    func getFlags() -> UInt16 { return self.flags }
    func getUnitsPerEm() -> UInt16 { return self.unitsPerEm }
    func getCreated() -> Int64 { return self.created }
    func getModified() -> Int64 { return self.modified }
    func getXMin() -> Int16 { return self.xMin }
    func getYMin() -> Int16 { return self.yMin }
    func getXMax() -> Int16 { return self.xMax }
    func getYMax() -> Int16 { return self.yMax }
    func getMacStyle() -> UInt16 { return self.macStyle }
    func getLowestRecPPEM() -> UInt16 { return self.lowestRecPPEM }
    func getFontDirectionHint() -> Int16 { return self.fontDirectionHint }
    func getIndexToLocFormat() -> Int16 { return self.indexToLocFormat }
    func getGlyphDataFormat() -> Int16 { return self.glyphDataFormat }

    init(rawData: Data) {
        let FontHeader: FontHeader = FontHeader(rawData: rawData)
        headTableOffset = FontHeader.findTableOffset(forTag: "head")
        let fileIO: FileIO = FileIO()
        self.magicNumber = fileIO.getUInt32(rawData: rawData, at: headTableOffset + 12) // 12 - 16
        self.flags = fileIO.getUInt16(rawData: rawData, at: headTableOffset + 16) // 16 - 18
        self.unitsPerEm = fileIO.getUInt16(rawData: rawData, at: headTableOffset + 18) // 18 - 20
        self.created = fileIO.getInt64(rawData: rawData, at: headTableOffset + 20) // 20 - 28
        self.modified = fileIO.getInt64(rawData: rawData, at: headTableOffset + 28) // 28 - 36
        self.xMin = fileIO.getInt16(rawData: rawData, at: headTableOffset + 36) // 36 - 38
        self.yMin = fileIO.getInt16(rawData: rawData, at: headTableOffset + 38) // 38 - 40
        self.xMax = fileIO.getInt16(rawData: rawData, at: headTableOffset + 40) // 40 - 42
        self.yMax = fileIO.getInt16(rawData: rawData, at: headTableOffset + 42) // 42 - 44
        self.macStyle = fileIO.getUInt16(rawData: rawData, at: headTableOffset + 44) // 44 - 46
        self.lowestRecPPEM = fileIO.getUInt16(rawData: rawData, at: headTableOffset + 46) // 46 - 48
        self.fontDirectionHint = fileIO.getInt16(rawData: rawData, at: headTableOffset + 48) // 48 - 50
        self.indexToLocFormat = fileIO.getInt16(rawData: rawData, at: headTableOffset + 50) // 50 - 52
        self.glyphDataFormat = fileIO.getInt16(rawData: rawData, at: headTableOffset + 52) // 52 - 54
    }
}
