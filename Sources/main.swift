import Foundation

// Assuming FontHeader is already defined and implemented.
let filePath: String = "ComicNeue-Regular.ttf"
let fileHandler: FileHandler = FileHandler()
let DATA: Data = try fileHandler.getRawData(filePath)
let fontHeader: FontHeader = FontHeader(rawData: DATA)

print("Tables: \(fontHeader.getNumTables())")

for i: UInt16 in 0..<fontHeader.getNumTables() {
    let tag: UInt32 = fontHeader.getTag(id: Int(i))
    let offset: UInt32 = fontHeader.getOffset(id: Int(i))
    
    print("Tag: \(convertToASCII(value: tag)) Location: \(offset)")
}

// Function to convert UInt16 to ASCII string
func convertToASCII(value: UInt32) -> String {
    let bytes: [UnsafeRawBufferPointer.Element] = withUnsafeBytes(of: value.bigEndian, Array.init)
    return String(bytes: bytes, encoding: .ascii) ?? ""
}
