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

    Takes in a hex string and returns the decimal value of the hex string.
    In: String
    Out: Int
    
    */
    func hexToDecimal(hex: String) -> Int {
        return Int(hex, radix: 16) ?? 0
    }
    /*

    Takes in a decimal and returns the hex string representation of the value.
    In: Int
    Out: String
    
    */
    func decimalToHex(decimal: Int) -> String {
        return String(format: "%02x", decimal)
    }
    /*

    Takes in rawData and a loaction and returns the UInt8 at the location.
    In, rawData: Data
    In, location: UInt32
    Out: UInt8

    */
    func getUInt8(rawData: Data, at location: UInt32) -> UInt8 {
        return rawData.subdata(in: Int(location)..<Int(location) + 1).withUnsafeBytes { $0.load(as: UInt8.self) }.bigEndian
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

    Takes in rawData and a loaction and returns the UInt32 at the location.
    In, rawData: Data
    In, location: UInt32
    Out: UInt32

    */
    func getUInt32(rawData: Data, at location: UInt32) -> UInt32 {
        return rawData.subdata(in: Int(location)..<Int(location) + 4).withUnsafeBytes { $0.load(as: UInt32.self) }.bigEndian
    }
    /*

    Takes in rawData and a loaction and returns the Int64 at the location.
    In, rawData: Data
    In, location: UInt32
    Out: UInt64

    */
    func getUInt64(rawData: Data, at location: UInt32) -> UInt64 {
        return rawData.subdata(in: Int(location)..<Int(location) + 8).withUnsafeBytes { $0.load(as: UInt64.self) }.bigEndian
    }
    /*

    Takes in rawData and a loaction and returns the Int8 at the location.
    In, rawData: Data
    In, location: UInt32    
    Out: Int8
    
    */
    func getInt8(rawData: Data, at location: UInt32) -> Int8 {
        return rawData.subdata(in: Int(location)..<Int(location) + 1).withUnsafeBytes { $0.load(as: Int8.self) }.bigEndian
    }
    /*

    Takes in rawData and a loaction and returns the Int16 at the location.
    In, rawData: Data
    In, location: UInt32
    Out: Int16

    */
    func getInt16(rawData: Data, at location: UInt32) -> Int16 {
        return rawData.subdata(in: Int(location)..<Int(location) + 2).withUnsafeBytes { $0.load(as: Int16.self) }.bigEndian
    }
    /*

    Takes in rawData and a loaction and returns the Int32 at the location.
    In, rawData: Data
    In, location: UInt32
    Out: Int32

    */
    func getInt32(rawData: Data, at location: UInt32) -> Int32 {
        return rawData.subdata(in: Int(location)..<Int(location) + 4).withUnsafeBytes { $0.load(as: Int32.self) }.bigEndian
    }
    /*

    Takes in rawData and a loaction and returns the Int64 at the location.
    In, rawData: Data
    In, location: UInt32
    Out: Int64

    */
    func getInt64(rawData: Data, at location: UInt32) -> Int64 {
        return rawData.subdata(in: Int(location)..<Int(location) + 8).withUnsafeBytes { $0.load(as: Int64.self) }.bigEndian
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
    /*

    Takes in a UInt16 and returns an array of bits.
    In, value: UInt16
    Out: [Bool] or [Int]

    */
    func bitsToArray(value: UInt16) -> [Bool] {
        var bitsArray: [Bool] = []
        for i: Int in (0..<16).reversed() {
            bitsArray.append((value >> i) & 1 == 1)
        }
        return bitsArray
    }

    func bitsToArray(value: UInt16) -> [Int] {
        var bitsArray: [Int] = [Int](repeating: 0, count: 16)

        for i: Int in (0..<16).reversed() {
            bitsArray[i] = Int((value >> (15 - i)) & 1)
        }

        return bitsArray
    }
}