import Foundation

class maxpTable {
    // Version is not accessible.
    var numGlyphs: UInt16
    var maxPoints: UInt16
    var maxContours: UInt16
    var maxCompositePoints: UInt16
    var maxCompositeContours: UInt16
    var maxZones: UInt16
    var maxTwilightPoints: UInt16
    var maxStorage: UInt16
    var maxFunctionDefs: UInt16
    var maxInstructionDefs: UInt16
    var maxStackElements: UInt16
    var maxSizeOfInstructions: UInt16
    var maxComponentElements: UInt16
    var maxComponentDepth: UInt16

    var maxpTableOffset: UInt32

    func getNumGlyphs() -> UInt16 { return self.numGlyphs }
    func getMaxPoints() -> UInt16 { return self.maxPoints }
    func getMaxContours() -> UInt16 { return self.maxContours }
    func getMaxCompositePoints() -> UInt16 { return self.maxCompositePoints }
    func getMaxCompositeContours() -> UInt16 { return self.maxCompositeContours }
    func getMaxZones() -> UInt16 { return self.maxZones }
    func getMaxTwilightPoints() -> UInt16 { return self.maxTwilightPoints }
    func getMaxStorage() -> UInt16 { return self.maxStorage }
    func getMaxFunctionDefs() -> UInt16 { return self.maxFunctionDefs }
    func getMaxInstructionDefs() -> UInt16 { return self.maxInstructionDefs }
    func getMaxStackElements() -> UInt16 { return self.maxStackElements }
    func getMaxSizeOfInstructions() -> UInt16 { return self.maxSizeOfInstructions }
    func getMaxComponentElements() -> UInt16 { return self.maxComponentElements }
    func getMaxComponentDepth() -> UInt16 { return self.maxComponentDepth }

    init(rawData: Data) {
        let FontHeader: FontHeader = FontHeader(rawData: rawData)
        maxpTableOffset = FontHeader.findTableOffset(forTag: "maxp")
        let fileIO: FileIO = FileIO()

        self.numGlyphs = fileIO.getUInt16(rawData: rawData, at: maxpTableOffset + 4) // 04 - 06
        self.maxPoints = fileIO.getUInt16(rawData: rawData, at: maxpTableOffset + 6) // 06 - 08
        self.maxContours = fileIO.getUInt16(rawData: rawData, at: maxpTableOffset + 8) // 08 - 10
        self.maxCompositePoints = fileIO.getUInt16(rawData: rawData, at: maxpTableOffset + 10) // 10 - 12
        self.maxCompositeContours = fileIO.getUInt16(rawData: rawData, at: maxpTableOffset + 12) // 12 - 14
        self.maxZones = fileIO.getUInt16(rawData: rawData, at: maxpTableOffset + 14) // 14 - 16 
        self.maxTwilightPoints = fileIO.getUInt16(rawData: rawData, at: maxpTableOffset + 16) // 16 - 18
        self.maxStorage = fileIO.getUInt16(rawData: rawData, at: maxpTableOffset + 18) // 18 - 20
        self.maxFunctionDefs = fileIO.getUInt16(rawData: rawData, at: maxpTableOffset + 20) // 20 - 22
        self.maxInstructionDefs = fileIO.getUInt16(rawData: rawData, at: maxpTableOffset + 22) // 22 - 24
        self.maxStackElements = fileIO.getUInt16(rawData: rawData, at: maxpTableOffset + 24) // 24 - 26
        self.maxSizeOfInstructions = fileIO.getUInt16(rawData: rawData, at: maxpTableOffset + 26) // 26 - 28
        self.maxComponentElements = fileIO.getUInt16(rawData: rawData, at: maxpTableOffset + 28) // 28 - 30
        self.maxComponentDepth = fileIO.getUInt16(rawData: rawData, at: maxpTableOffset + 30) // 30 - 32
    }
}