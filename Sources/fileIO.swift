import Foundation

class FileIO {
    /*

    Takes in a file path and returns the raw data of the file.
    In: String
    Out: Data

    */
    func getRawData(_ filePath: String) throws -> Data {
        let fileURL: URL = URL(fileURLWithPath: filePath)
        let rawData: Data = try Data(contentsOf: fileURL)
        return rawData
    }
    /*

    Takes in a UInt32 and returns the ASCII string representation of the value.
    In: UInt32
    Out: String

    */
    func convertUInt32ToASCII(value: UInt32) -> String {
        let bytes: [UnsafeRawBufferPointer.Element] = withUnsafeBytes(of: value.bigEndian, Array.init)
        return String(bytes: bytes, encoding: .ascii) ?? ""
    }
    /*

    Takes in a UInt16 and returns the ASCII string representation of the value.
    In: UInt16
    Out: String

    */
    func convertUInt16ToASCII(value: UInt16) -> String {
        let bytes: [UnsafeRawBufferPointer.Element] = withUnsafeBytes(of: value.bigEndian, Array.init)
        return String(bytes: bytes, encoding: .ascii) ?? ""
    }
}