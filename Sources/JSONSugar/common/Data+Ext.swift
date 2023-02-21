import Foundation
/**
 * Data
 */
extension Data {
   /**
    * Decode json-dict-data
    * ## Examples:
    * let strings: [String]? = try ? "["a","b","c"]".data(using: .utf8)?.decode()
    */
   public func decode<T: Decodable>() throws -> T {
      let decoder = JSONDecoder()
      return try decoder.decode(T.self, from: self)
   }
}
