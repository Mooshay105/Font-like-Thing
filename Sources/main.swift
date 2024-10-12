import Foundation

let filePath: String = "ComicNeue-Regular.ttf"
let fileHandler: FileHandler = FileHandler()
let fontHeader: FontHeader = FontHeader(rawData: try fileHandler.getRawData(filePath))

print("Tables: \(fontHeader.getNumTables())")
