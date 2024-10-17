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

    /*

    Takes in rawData and a loaction and returns the UInt16 at the location.
    In, rawData: Data
    In, location: UInt32
    Out: UInt16

    */

    func getUInt16(rawData: Data, at location: UInt32) -> UInt16 {
        return rawData.subdata(in: Int(location)..<Int(location) + 2).withUnsafeBytes { $0.load(as: UInt16.self) }.bigEndian
    }

    /*

    CREDIT: https://github.com/SebLague/Text-Rendering/blob/main/Assets/Scripts/SebText/Loader/FontParser.cs#L549
    Takes in a UInt8 and returns `1` if the bit at the index is set.
    In, flag: UInt8
    In, bitIndex: Int
    Out: Bool

    */

    func isFlagBitSet(flag: UInt8, bitIndex: Int) -> Bool {
        return ((flag >> bitIndex) & 1) == 1;
    }
}