import Foundation
/**
 * Data
 */
extension Data {
   /**
    * Decode json-dict-data
    * Description: The code extends the Data class with a method called decode<T: Decodable>() that decodes JSON data to a specified type T.
    * - Parameter T: The type to decode the data to
    * - Returns: The decoded object of type T
    * - Throws: An error if the decoding fails
    * - Remark: This method uses the JSONDecoder to decode the data to the specified type T.
    * ## Examples:
    * let strings: [String]? = try ? "["a","b","c"]".data(using: .utf8)?.decode()
    */
   public func decode<T: Decodable>() throws -> T {
      let decoder: JSONDecoder = .init() // Initializes a new instance of JSONDecoder
      // Decode the data to the specified type using the JSONDecoder
      return try decoder.decode(T.self, from: self)
   }
}
