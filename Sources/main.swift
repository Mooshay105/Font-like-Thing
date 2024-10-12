import Foundation

let filePath: String = "ComicNeue-Regular.ttf"

func getRawDara(filePath: String) throws -> Data {
    let fileURL: URL = URL(fileURLWithPath: filePath)
    let rawData: Data = try Data(contentsOf: fileURL)
    return rawData
}

func getHexString(rawData: Data) -> String {
    return rawData.map { String(format: "%02x", $0) }.joined(separator: " ")
}

print(getHexString(rawData: try getRawDara(filePath: filePath)))