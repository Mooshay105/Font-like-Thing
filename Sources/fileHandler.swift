import Foundation

class FileHandler {
    func getRawData(_ filePath: String) throws -> Data {
        let fileURL: URL = URL(fileURLWithPath: filePath)
        let rawData: Data = try Data(contentsOf: fileURL)
        return rawData
    }
}