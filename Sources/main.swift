import Foundation

let filePath: String = "ComicNeue-Regular.ttf"
let fileIO: FileIO = FileIO()
let DATA: Data = try fileIO.getRawData(filePath)
let fontHeader: FontHeader = FontHeader(rawData: DATA)

print("Tables: \(fontHeader.getNumTables())")

for i: UInt16 in 0..<fontHeader.getNumTables() {
    let tag: UInt32 = fontHeader.getTag(id: Int(i))
    let offset: UInt32 = fontHeader.getOffset(id: Int(i))
    
    print("Tag: \(FileIO().convertUInt32ToASCII(value: tag)) Location: \(offset)")
}
