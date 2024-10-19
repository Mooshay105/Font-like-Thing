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
    }
}