import Foundation

class debug {
    func debug() throws {
        // let filePath: String = "ComicNeue-Bold.ttf"
        // let filePath: String = "ComicNeue-BoldItalic.ttf"
        // let filePath: String = "ComicNeue-Italic.ttf"
        // let filePath: String = "ComicNeue-Light.ttf"
        // let filePath: String = "ComicNeue-LightItalic.ttf"
        // let filePath: String = "ComicNeue-Regular.ttf"
        let filePath: String = "JetBrainsMono-Bold.ttf"
        let fileIO: FileIO = FileIO()
        let DATA: Data = try fileIO.getRawData(filePath: filePath)
        let fontHeader: FontHeader = FontHeader(rawData: DATA)
        let cmapTable: cmapTable = cmapTable(rawData: DATA)
        let headTable: headTable = headTable(rawData: DATA)
        let maxpTable: maxpTable = maxpTable(rawData: DATA)
        let hheaTable: hheaTable = hheaTable(rawData: DATA)
        let postTable: postTable = postTable(rawData: DATA)
        let locaTable: locaTable = locaTable(rawData: DATA)

        print("\u{001B}[0;32m✔\u{001B}[0;37m  Font: \(filePath)")

        // Header Stuff
        for i: UInt16 in 0..<fontHeader.getNumTables() {
            let tag: UInt32 = fontHeader.getTag(id: Int(i))
            let offset: UInt32 = fontHeader.getOffset(id: Int(i))
    
            print("\u{001B}[0;32m✔\u{001B}[0;37m  Tag: \(FileIO().convertUInt32ToASCII(value: tag)) Offset: \(offset)")
        }

        print("\u{001B}[0;32m✔\u{001B}[0;37m  Number Of Tables: \(fontHeader.getNumTables())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  'glyf' Table Location: \( fontHeader.findTableOffset(forTag: "glyf"))")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  End of Header Location: \(fontHeader.getEndOfHeaderLocation())")

        // cmap Table Stuff
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
        print("\u{001B}[0;31m✗\u{001B}[0;37m  cmap Table Unicode To Glyph Index: \(cmapTable.unicodeToGlyphIndex(unicode: 0x0042))")

        // head Table Stuff
        print("\u{001B}[0;32m✔\u{001B}[0;37m  head Table Magic Number: 0x\(fileIO.decimalToHex(decimal: Int(headTable.getMagicNumber())))")
        let intFlags: [Int] = fileIO.bitsToArray(value: headTable.getFlags())
        let boolFlags: [Bool] = fileIO.bitsToArray(value: headTable.getFlags())
        print("\u{001B}[0;32m✔\u{001B}[0;37m  head Table Bool Flags: \(boolFlags)")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  head Table Int Flags: \(intFlags)")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  head Table Units Per Em: \(headTable.getUnitsPerEm())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  head Table Created: \(headTable.getCreated())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  head Table Modified: \(headTable.getModified())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  head Table XMin: \(headTable.getXMin())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  head Table YMin: \(headTable.getYMin())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  head Table XMax: \(headTable.getXMax())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  head Table YMax: \(headTable.getYMax())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  head Table Mac Style: \(headTable.getMacStyle())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  head Table Lowest Rec PPEM: \(headTable.getLowestRecPPEM())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  head Table Font Direction Hint: \(headTable.getFontDirectionHint())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  head Table Index To Loc Format: \(headTable.getIndexToLocFormat())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  head Table Glyph Data Format: \(headTable.getGlyphDataFormat())")

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
        print("\u{001B}[0;32m✔\u{001B}[0;37m  maxp Table Max Points: \(maxpTable.getMaxPoints())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  maxp Table Max Contours: \(maxpTable.getMaxContours())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  maxp Table Max Composite Points: \(maxpTable.getMaxCompositePoints())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  maxp Table Max Composite Contours: \(maxpTable.getMaxCompositeContours())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  maxp Table Max Zones: \(maxpTable.getMaxZones())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  maxp Table Max Twilight Points: \(maxpTable.getMaxTwilightPoints())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  maxp Table Max Storage: \(maxpTable.getMaxStorage())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  maxp Table Max Function Defs: \(maxpTable.getMaxFunctionDefs())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  maxp Table Max Instruction Defs: \(maxpTable.getMaxInstructionDefs())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  maxp Table Max Stack Elements: \(maxpTable.getMaxStackElements())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  maxp Table Max Size Of Instructions: \(maxpTable.getMaxSizeOfInstructions())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  maxp Table Max Component Elements: \(maxpTable.getMaxComponentElements())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  maxp Table Max Component Depth: \(maxpTable.getMaxComponentDepth())")

        // Post Table Stuff
        print("\u{001B}[0;32m✔\u{001B}[0;37m  post Table Format: \(postTable.getFormat())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  post Table Italic Angle: \(postTable.getItalicAngle())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  post Table Underline Position: \(postTable.getUnderlinePosition())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  post Table Underline Thickness: \(postTable.getUnderlineThickness())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  post Table Is Fixed Pitch: \(postTable.getIsFixedPitch())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  post Table Min Mem Type 42: \(postTable.getMinMemType42())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  post Table Max Mem Type 42: \(postTable.getMaxMemType42())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  post Table Min Mem Type 1: \(postTable.getMinMemType1())")
        print("\u{001B}[0;32m✔\u{001B}[0;37m  post Table Max Mem Type 1: \(postTable.getMaxMemType1())")

        // Loca Table Stuff
        print("\u{001B}[0;33m✔\u{001B}[0;37m  loca Table Index To Loc Format: \(locaTable.indexToLocFormat)")
        if headTable.getIndexToLocFormat() == 0 {
            for i: UInt16 in 0..<maxpTable.getNumGlyphs() {
                print("\u{001B}[0;32m✔\u{001B}[0;37m  loca Table Offset: \(locaTable.getOffsetShort(id: Int(i)))")
            }
        } else {
            for i: UInt16 in 0..<maxpTable.getNumGlyphs() {
                print("\u{001B}[0;32m✔\u{001B}[0;37m  loca Table Offset: \(locaTable.getOffsetLong(id: Int(i)))")
            }
        }
    }
}