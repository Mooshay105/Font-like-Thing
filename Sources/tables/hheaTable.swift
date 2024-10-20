import Foundation

class hheaTable {
    // Version is not accessible.
    var ascent: Int16
    var descent: Int16
    var lineGap: Int16
    var advanceWidthMax: UInt16
    var minLeftSideBearing: Int16
    var minRightSideBearing: Int16
    var xMaxExtent: Int16
    var caretSlopeRise: Int16
    var caretSlopeRun: Int16
    var caretOffset: Int16
    var metricDataFormat: Int16
    var numberOfHMetrics: UInt16

    var hheaTableOffset: UInt32

    func getAscent() -> Int16 { return self.ascent }
    func getDescent() -> Int16 { return self.descent }
    func getLineGap() -> Int16 { return self.lineGap }
    func getAdvanceWidthMax() -> UInt16 { return self.advanceWidthMax }
    func getMinLeftSideBearing() -> Int16 { return self.minLeftSideBearing }
    func getMinRightSideBearing() -> Int16 { return self.minRightSideBearing }
    func getXMaxExtent() -> Int16 { return self.xMaxExtent }
    func getCaretSlopeRise() -> Int16 { return self.caretSlopeRise }
    func getCaretSlopeRun() -> Int16 { return self.caretSlopeRun }
    func getCaretOffset() -> Int16 { return self.caretOffset }
    func getMetricDataFormat() -> Int16 { return self.metricDataFormat }
    func getNumberOfHMetrics() -> UInt16 { return self.numberOfHMetrics }

    init(rawData: Data) {
        let FontHeader: FontHeader = FontHeader(rawData: rawData)
        hheaTableOffset = FontHeader.findTableOffset(forTag: "hhea")
        let fileIO: FileIO = FileIO()

        self.ascent = fileIO.getInt16(rawData: rawData, at: hheaTableOffset + 4) // 04 - 06
        self.descent = fileIO.getInt16(rawData: rawData, at: hheaTableOffset + 6) // 06 - 08
        self.lineGap = fileIO.getInt16(rawData: rawData, at: hheaTableOffset + 8) // 08 - 10
        self.advanceWidthMax = fileIO.getUInt16(rawData: rawData, at: hheaTableOffset + 10) // 10 - 12
        self.minLeftSideBearing = fileIO.getInt16(rawData: rawData, at: hheaTableOffset + 12) // 12 - 14
        self.minRightSideBearing = fileIO.getInt16(rawData: rawData, at: hheaTableOffset + 14) // 14 - 16
        self.xMaxExtent = fileIO.getInt16(rawData: rawData, at: hheaTableOffset + 16) // 16 - 18
        self.caretSlopeRise = fileIO.getInt16(rawData: rawData, at: hheaTableOffset + 18) // 18 - 20
        self.caretSlopeRun = fileIO.getInt16(rawData: rawData, at: hheaTableOffset + 20) // 20 - 22
        self.caretOffset = fileIO.getInt16(rawData: rawData, at: hheaTableOffset + 22) // 22 - 24
        self.metricDataFormat = fileIO.getInt16(rawData: rawData, at: hheaTableOffset + 32) // 32 - 34
        self.numberOfHMetrics = fileIO.getUInt16(rawData: rawData, at: hheaTableOffset + 34) // 34 - 36
    }
}