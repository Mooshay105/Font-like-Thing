import Foundation

class hmtxTable {
    var advanceWidths: [UInt16]
    var leftSideBearings: [Int16]
    
    var hmtxTableOffset: UInt32

    func getAdvanceWidth(forGlyph glyphIndex: Int) -> UInt16 { return glyphIndex < advanceWidths.count ? advanceWidths[glyphIndex] : advanceWidths.last ?? 0 }
    func getLeftSideBearing(forGlyph glyphIndex: Int) -> Int16 { return leftSideBearings[glyphIndex] }

    init(rawData: Data) {
        let FontHeader: FontHeader = FontHeader(rawData: rawData)
        let hheaTable: hheaTable = hheaTable(rawData: rawData)
        let maxpTable: maxpTable = maxpTable(rawData: rawData)
        hmtxTableOffset = FontHeader.findTableOffset(forTag: "hmtx")
        let fileIO: FileIO = FileIO()
        let numberOfHMetrics: UInt16 = hheaTable.getNumberOfHMetrics()
        let numGlyphs: UInt16 = maxpTable.getNumGlyphs()

        // Initialize arrays to store advanceWidth and leftSideBearing
        self.advanceWidths = [UInt16](repeating: 0, count: Int(numberOfHMetrics))
        self.leftSideBearings = [Int16](repeating: 0, count: Int(numGlyphs))

        // Read advanceWidth and leftSideBearing for the first `numberOfHMetrics` glyphs
        for i in 0..<Int(numberOfHMetrics) {
            let offset = hmtxTableOffset + UInt32(i * 4)
            self.advanceWidths[i] = fileIO.getUInt16(rawData: rawData, at: offset) // 2 bytes for advanceWidth
            self.leftSideBearings[i] = fileIO.getInt16(rawData: rawData, at: offset + 2) // 2 bytes for leftSideBearing
        }

        // For glyphs beyond `numberOfHMetrics`, only leftSideBearings are stored
        for i in Int(numberOfHMetrics)..<Int(numGlyphs) {
            let offset = hmtxTableOffset + UInt32(Int(numberOfHMetrics) * 4 + (i - Int(numberOfHMetrics)) * 2)
            self.leftSideBearings[i] = fileIO.getInt16(rawData: rawData, at: offset) // Only leftSideBearing
        }
    }
}