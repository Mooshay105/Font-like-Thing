import Foundation

let filePath: String = "ComicNeue-Regular.ttf"
let fileIO: FileIO = FileIO()
let DATA: Data = try fileIO.getRawData(filePath: filePath)
let fontHeader: FontHeader = FontHeader(rawData: DATA)

for i: UInt16 in 0..<fontHeader.getNumTables() {
    let tag: UInt32 = fontHeader.getTag(id: Int(i))
    let offset: UInt32 = fontHeader.getOffset(id: Int(i))
    
    print("Tag: \(FileIO().convertUInt32ToASCII(value: tag)) Offset: \(offset)")
}

print("Number Of Tables: \(fontHeader.getNumTables())")

do {
    print("'glyf' Table Location: \(try fontHeader.getGlyfOffset())")
} catch {
    print("Error: \(error)")
}

print("End of Header Location: \(fontHeader.getEndOfHeaderLocation())")

do {
    let glyfData: Data = try fileIO.getByte(data: DATA, at: fontHeader.getGlyfOffset())!
    print("glyf data: \(fileIO.getHexString(rawData: glyfData))")
} catch {
    print("Error: \(error)")
}