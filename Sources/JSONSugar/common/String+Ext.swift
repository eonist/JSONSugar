import Foundation
/**
 * String
 */
extension String {
   /**
    * Decode JSON data to a specified type
    * - Description: This method extends the String class with a `decode<T: Decodable>()` function that converts a JSON string to a specified type T.
    * - Parameters:
    *   - T: The type to decode the JSON data to
    *   - encoding: The string encoding to use when converting the string to data. Default is `.utf8`.
    * - Returns: The decoded object of type T
    * - Throws: An error if the decoding fails
    * - Remark: This method uses the `JSONDecoder` to decode the JSON data to the specified type T.
    * - Example: let strings: [String]? = try ? "["a","b","c"]".decode()
    */
   public func decode<T: Decodable>(encoding: String.Encoding = .utf8) throws -> T {
      // Create a JSONDecoder instance
      let decoder: JSONDecoder = .init()
      // Convert the string to data using the specified encoding
      guard let data: Data = self.data(using: encoding) else { 
         throw NSError(domain: "unable to convert string to data", code: 0) 
      }
      // Decode the data to the specified type using the JSONDecoder
      return try decoder.decode(T.self, from: data)
   }
}
