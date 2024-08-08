import Foundation
/**
 * Decodable
 */
extension Decodable {
   /**
    * Dictionary -> Struct
    * - Description: This initializer allows you to create an instance of a Decodable type from a dictionary.
    * - Parameter dict: The dictionary to decode
    * - Throws: An error if the decoding fails
    * - Remark: This method uses the JSONDecoder to decode the dictionary to the specified type Self.
    * ## Examples:
    * let test = try Test(dict: ["a": "1", "b": "2"])
    */
   public init(dict: [String: Any]) throws {
      // Create a JSONDecoder instance
      let decoder: JSONDecoder = .init()
      // Decode the dictionary to the specified type using the JSONDecoder
      self = try decoder.decode( // This line is using the decoder to decode the JSON data into the type of 'self'
         Self.self, // This line is specifying the type to decode the JSON data to
         from: JSONSerialization.data(withJSONObject: dict) // This line is decoding the dictionary into JSON data and assigning it to self
      )
   }
}
