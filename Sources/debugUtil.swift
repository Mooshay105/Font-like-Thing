import Foundation

class debug {
    func debug() throws {
        // let filePath: String = "ComicNeue-Regular.ttf"
        let filePath: String = "JetBrainsMono-Bold.ttf"
        let fileIO: FileIO = FileIO()
        let DATA: Data = try fileIO.getRawData(filePath: filePath)
        let fontHeader: FontHeader = FontHeader(rawData: DATA)
        let cmapTable: cmapTable = cmapTable(rawData: DATA)
        let headTable: HeadTable = HeadTable(rawData: DATA)
        let maxpTable: maxpTable = maxpTable(rawData: DATA)
        let hheaTable: hheaTable = hheaTable(rawData: DATA)
        
        // Header Stuff

        for i: UInt16 in 0..<fontHeader.getNumTables() {
            let tag: UInt32 = fontHeader.getTag(id: Int(i))
            let offset: UInt32 = fontHeader.getOffset(id: Int(i))
    
            print("\u{001B}[0;32m✔\u{001B}[0;37m  Tag: \(FileIO().convertUInt32ToASCII(value: tag)) Offset: \(offset)")
        }

        print("\u{001B}[0;32m✔\u{001B}[0;37m  Number Of Tables: \(fontHeader.getNumTables())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  'glyf' Table Location: \( fontHeader.findTableOffset(forTag: "glyf"))")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  End of Header Location: \(fontHeader.getEndOfHeaderLocation())")

        // CMap Table Stuff

        print("\u{001B}[0;32m✔\u{001B}[0;37m  cmap Table Version: \(cmapTable.getVersion())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  cmap Table Number Of Tables: \(cmapTable.getNumTables())")
        for i: UInt16 in 0..<cmapTable.getNumTables() {
            if cmapTable.getPlatformID(id: Int(i)) == 0 {
                print("\u{001B}[0;32m✔\u{001B}[0;37m  ID: \(i+1)")
                print("\u{001B}[0;32m✔\u{001B}[0;37m  cmap Table Platform ID: \(cmapTable.getPlatformID(id: Int(i)))")
                print("\u{001B}[0;32m✔\u{001B}[0;37m  cmap Table Platform Specific ID: \(cmapTable.getPlatformSpecificID(id: Int(i)))")
                print("\u{001B}[0;32m✔\u{001B}[0;37m  cmap Table Offset: \(cmapTable.getOffset(id: Int(i)))")
            } else {
                print("\u{001B}[0;32m✔\u{001B}[0;37m  ID \(i+1) is not a unicode table.")
            }
        }
        for i: UInt16 in 0..<cmapTable.numberOfUnicodeTables {
            print("\u{001B}[0;32m✔\u{001B}[0;37m  cmap Table Unicode Index: \(cmapTable.getUnicodeIndex(id: Int(i)))")
            print("\u{001B}[0;32m✔\u{001B}[0;37m  cmap Table Unicode Offset: \(cmapTable.getOffset(id: Int(cmapTable.getUnicodeIndex(id: Int(i)))))")
        }
        print("   cmap Table Unicode To Glyph Index: \(cmapTable.unicodeToGlyphIndex(unicode: 0x0042))")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  Magic Number: 0x\(fileIO.decimalToHex(decimal: Int(headTable.getMagicNumber())))")
        let intFlags: [Int] = fileIO.bitsToArray(value: headTable.getFlags())
        let boolFlags: [Bool] = fileIO.bitsToArray(value: headTable.getFlags())
        print("\u{001B}[0;32m✔\u{001B}[0;37m  Bool Flags: \(boolFlags)")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  Int Flags: \(intFlags)")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  Units Per Em: \(headTable.getUnitsPerEm())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  Created: \(headTable.getCreated())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  Modified: \(headTable.getModified())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  XMin: \(headTable.getXMin())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  YMin: \(headTable.getYMin())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  XMax: \(headTable.getXMax())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  YMax: \(headTable.getYMax())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  Mac Style: \(headTable.getMacStyle())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  Lowest Rec PPEM: \(headTable.getLowestRecPPEM())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  Font Direction Hint: \(headTable.getFontDirectionHint())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  Index To Loc Format: \(headTable.getIndexToLocFormat())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  Glyph Data Format: \(headTable.getGlyphDataFormat())")

        // hhea Table Stuff
        print("\u{001B}[0;32m✔\u{001B}[0;37m  hhea Table Ascent: \(hheaTable.getAscent())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  hhea Table Descent: \(hheaTable.getDescent())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  hhea Table Line Gap: \(hheaTable.getLineGap())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  hhea Table Advance Width Max: \(hheaTable.getAdvanceWidthMax())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  hhea Table Min Left Side Bearing: \(hheaTable.getMinLeftSideBearing())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  hhea Table Min Right Side Bearing: \(hheaTable.getMinRightSideBearing())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  hhea Table XMax Extent: \(hheaTable.getXMaxExtent())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  hhea Table Caret Slope Rise: \(hheaTable.getCaretSlopeRise())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  hhea Table Caret Slope Run: \(hheaTable.getCaretSlopeRun())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  hhea Table Caret Offset: \(hheaTable.getCaretOffset())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  hhea Table Metric Data Format: \(hheaTable.getMetricDataFormat())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  hhea Table Number Of HMetrics: \(hheaTable.getNumberOfHMetrics())")

        // maxp Table Stuff
        print("\u{001B}[0;32m✔\u{001B}[0;37m  maxp Table Num Glyphs: \(maxpTable.getNumGlyphs())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m   maxp Table Max Points: \(maxpTable.getMaxPoints())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m   maxp Table Max Contours: \(maxpTable.getMaxContours())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m   maxp Table Max Composite Points: \(maxpTable.getMaxCompositePoints())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m   maxp Table Max Composite Contours: \(maxpTable.getMaxCompositeContours())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m   maxp Table Max Zones: \(maxpTable.getMaxZones())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m   maxp Table Max Twilight Points: \(maxpTable.getMaxTwilightPoints())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m   maxp Table Max Storage: \(maxpTable.getMaxStorage())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m   maxp Table Max Function Defs: \(maxpTable.getMaxFunctionDefs())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m   maxp Table Max Instruction Defs: \(maxpTable.getMaxInstructionDefs())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m   maxp Table Max Stack Elements: \(maxpTable.getMaxStackElements())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m   maxp Table Max Size Of Instructions: \(maxpTable.getMaxSizeOfInstructions())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m   maxp Table Max Component Elements: \(maxpTable.getMaxComponentElements())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m   maxp Table Max Component Depth: \(maxpTable.getMaxComponentDepth())")
    }
}