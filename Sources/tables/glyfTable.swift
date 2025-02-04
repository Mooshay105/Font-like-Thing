import Foundation

class glyfTable {
    struct Glyf {
        var numberOfContours: Int16
        var xMin: Int16
        var yMin: Int16
        var xMax: Int16
        var yMax: Int16
        var endPtsOfContours: [UInt16]
        var instructionLength: UInt16
        var instructions: [UInt8]
        var flags: [UInt8]
        var xCoordinates: [Int]
        var yCoordinates: [Int]
    }

    var glyfs: [Glyf]

    func getGlyfs() -> [Glyf] { return self.glyfs }

    init(rawData: Data) {
        let fontHeader: FontHeader = FontHeader(rawData: rawData)
        let locaTable: locaTable = locaTable(rawData: rawData)
        let maxpTable: maxpTable = maxpTable(rawData: rawData)
        let fileIO: FileIO = FileIO()
        let glyfTableOffset: UInt32 = fontHeader.findTableOffset(forTag: "glyf")
        let numberOfGlyphs: UInt16 = maxpTable.getNumGlyphs()
        self.glyfs = []

        for i: UInt16 in 0..<numberOfGlyphs {
            var endPtsOfContoursEndPos: UInt32 = 0
            var instructionEndPos: UInt32 = 0
            var flagsEndPos: UInt32 = 0
            var xCoordinatesEndPos: UInt32 = 0
            var yCoordinatesEndPos: UInt32 = 0
            let glyphOffset: UInt32 = locaTable.getOffsetLong(id: Int(i))
            let numberOfContours: Int16 = fileIO.getInt16(rawData: rawData, at: glyfTableOffset + glyphOffset)
            if numberOfContours <= 0 {
                print("Thats A Compound glyph, We Do Not Support That Yet!")
                continue
            }
            let xMin: Int16 = fileIO.getInt16(rawData: rawData, at: glyfTableOffset + glyphOffset + 2)
            let yMin: Int16 = fileIO.getInt16(rawData: rawData, at: glyfTableOffset + glyphOffset + 4)
            let xMax: Int16 = fileIO.getInt16(rawData: rawData, at: glyfTableOffset + glyphOffset + 6)
            let yMax: Int16 = fileIO.getInt16(rawData: rawData, at: glyfTableOffset + glyphOffset + 8)
            var endPtsOfContours: [UInt16] = []
            for j: Int16 in 0..<numberOfContours {
                endPtsOfContours.append(fileIO.getUInt16(rawData: rawData, at: glyfTableOffset + glyphOffset + 10 + UInt32(j)*2))
                endPtsOfContoursEndPos = glyfTableOffset + glyphOffset + 10 + UInt32(j)*2
            }
            let instructionLength: UInt16 = fileIO.getUInt16(rawData: rawData, at: endPtsOfContoursEndPos)
            var instructions: [UInt8] = []
            for j: Int16 in 0..<Int16(instructionLength) {
                instructions.append(fileIO.getUInt8(rawData: rawData, at: endPtsOfContoursEndPos + 2 + UInt32(j)*2))
                instructionEndPos = endPtsOfContoursEndPos + 2 + UInt32(j)*2
            }
            let flags: [UInt8] = []
            flagsEndPos = endPtsOfContoursEndPos
            let xCoordinates: [Int] = []
            xCoordinatesEndPos = endPtsOfContoursEndPos
            let yCoordinates: [Int] = []
            yCoordinatesEndPos = endPtsOfContoursEndPos

            self.glyfs.append(Glyf(
                numberOfContours: numberOfContours,
                xMin: xMin,
                yMin: yMin,
                xMax: xMax,
                yMax: yMax,
                endPtsOfContours: endPtsOfContours,
                instructionLength: instructionLength,
                instructions: instructions,
                flags: flags,
                xCoordinates: xCoordinates,
                yCoordinates: yCoordinates
            ))
        }
    }
}