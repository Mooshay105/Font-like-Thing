import Foundation

let filePath: String = "ComicNeue-Regular.ttf"

func getRawData(filePath: String) throws -> Data {
    let fileURL: URL = URL(fileURLWithPath: filePath)
    let rawData: Data = try Data(contentsOf: fileURL)
    return rawData
}

func getHexString(rawData: Data) -> String {
    return rawData.map { String(format: "%02x", $0) }.joined(separator: " ")
}

/*
Font Block 1:
Not Needed uint32 	scaler type 	A tag to indicate the OFA scaler to be used to rasterize this font; see the note on the scaler type below for more information.
Needed     uint16 	numTables 	    number of tables
Not Needed uint16 	searchRange 	(maximum power of 2 <= numTables)*16
Not Needed uint16 	entrySelector 	log2(maximum power of 2 <= numTables)
Not Needed uint16 	rangeShift 	    numTables*16-searchRange
*/


// Get The Number of Tables And Convet It To Little Endian
let numTables: UInt16 = try getRawData(filePath: filePath).subdata(in: 4..<6).withUnsafeBytes { $0.load(as: UInt16.self) }.bigEndian

print("numTables: \(numTables)")