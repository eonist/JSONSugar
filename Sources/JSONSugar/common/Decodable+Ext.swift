import Foundation
/**
 * Decodable
 */
extension Decodable {
   /**
    * Dictionary -> Struct
    * - Parameter dict: The dictionary to decode
    * - Throws: An error if the decoding fails
    * - Remark: This method uses the JSONDecoder to decode the dictionary to the specified type Self.
    * - Example: let test = try Test(dict: ["a": "1", "b": "2"])
    */
   public init(dict: [String: Any]) throws {
      // Create a JSONDecoder instance
      let decoder = JSONDecoder()
      // Decode the dictionary to the specified type using the JSONDecoder
      self = try decoder.decode(Self.self, from: JSONSerialization.data(withJSONObject: dict))
   }
}