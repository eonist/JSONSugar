import Foundation
/**
 * Global generic decode method for Decodable
 * - Remark: You can also use data.decode()
 * ## Examples:
 * let jsonStr: String = "["a","b","c"]"
 * guard let jsonData = jsonStr.data(using: .utf8) else { fatalError("unable to convert string to data") }
 * guard let strings: [String] = try? decode(data: jsonData) else { fatalError("unable to decode jsonData") }
 * - Parameter data: json-dict-data
 * - Throws: Decoder error
 * - Returns: Class instance
 */
public func decode<T: Decodable>(data: Data) throws -> T {
   let decoder = JSONDecoder()
   return try decoder.decode(T.self, from: data)
}
/**
 * Encodable Extension
 */
extension Encodable {
   /**
    * Encode class instance as json-dict-data
    * - Fixme: ⚠️️ add more doc
    */
   public func encode() throws -> Data {
      let encoder: JSONEncoder = .init()
      // if #available(macOS 10.13, *), #available(iOS 11.0, *) { // - Fixme: ⚠️️ fix this later by upgrading package etc
         encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
      // } else {
      //    // Fallback on earlier versions
      //    encoder.outputFormatting = .prettyPrinted
      // }
      return try encoder.encode(self)
   }
}
