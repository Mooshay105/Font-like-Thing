import Foundation

class FileIO {
    enum FileIOError: Error {
        case invalidLocation
    }

    /*

    Takes in a file path and returns the raw data of the file.
    In: String
    Out: Data

    */
    func getRawData(filePath: String) throws -> Data {
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

    /*

    Takes in data and a location and returns the byte at that location.
    In, data: Data
    In, location: UInt32
    Out: Data?

    WARN: Will throw `FileIOError.invalidLocation` if the location is out of bounds.

    */

    func getByte(data: Data, at location: UInt32) throws -> Data? {
        guard location < data.count else {
            throw FileIOError.invalidLocation
        }
    
        return Data([data[Int(location)]])
    }

    /*

    Takes in a Data object and returns the hex string representation of the data.
    In: Data
    Out: String

    */

    func getHexString(rawData: Data) -> String {
        return rawData.map { String(format: "%02x", $0) }.joined(separator: " ")
    }

}