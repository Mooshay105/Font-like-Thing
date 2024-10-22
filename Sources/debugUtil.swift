import Foundation

class debug {
    func debug() throws {
        // let filePath: String = "ComicNeue-Italic.ttf"
        let filePath: String = "JetBrainsMono-Bold.ttf"
        let fileIO: FileIO = FileIO()
        let DATA: Data = try fileIO.getRawData(filePath: filePath)
        let fontHeader: FontHeader = FontHeader(rawData: DATA)
        // let cmapTable: cmapTable = cmapTable(rawData: DATA)
        // let glyfTable: glyfTable = glyfTable(rawData: DATA)
        // let headTable: headTable = headTable(rawData: DATA)
        // let hheaTable: hheaTable = hheaTable(rawData: DATA)
        // let hmtxTable: hmtxTable = hmtxTable(rawData: DATA)
        // let locaTable: locaTable = locaTable(rawData: DATA)
        // let maxpTable: maxpTable = maxpTable(rawData: DATA)
        // let nameTable: nameTable = nameTable(rawData: DATA)
        // let postTable: postTable = postTable(rawData: DATA)

        // Header Stuff
        for i: UInt16 in 0..<fontHeader.getNumTables() {
            let tag: UInt32 = fontHeader.getTag(id: Int(i))
            let offset: UInt32 = fontHeader.getOffset(id: Int(i))
    
            print("\u{001B}[0;32m✔\u{001B}[0;37m  Tag: \(FileIO().convertUInt32ToASCII(value: tag)) Offset: \(offset) Checksum: \(fontHeader.getCheckSum(id: Int(i))) Length: \(fontHeader.getLength(id: Int(i)))")
        }
        print("   Header Scaler Type: \(fontHeader.getScalerType())")
        print("   Header Num Tables: \(fontHeader.getNumTables())")
        print("   Header Search Range: \(fontHeader.getSearchRange())")
        print("   Header Entry Selector: \(fontHeader.getEntrySelector())")
        print("   Header Range Shift: \(fontHeader.getRangeShift())")
        print("   Header End Of Header Location: \(fontHeader.getEndOfHeaderLocation())")
    }
}