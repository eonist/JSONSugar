import Foundation
/**
 * Encodable
 */
extension Encodable {
   /**
    * Struct -> Dictionary
    * - Returns: The dictionary representation of the struct
    * - Throws: An error if the conversion fails
    * - Remark: This method uses the JSONEncoder to encode the struct to JSON data, and then uses the JSONSerialization class to convert the JSON data to a dictionary.
    * - Example: struct Test { let a: String, b }; try Test(a: "1", b: "2").getDict() // ["a": "1", "b": "2"]
    */
   public func getDict() throws -> [String: Any] {
      // Encode the struct to JSON data using the JSONEncoder
      let data: Data = try JSONEncoder().encode(self)
      // Convert the JSON data to a dictionary using the JSONSerialization class
      let dict: [String: Any]? = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
      // Return the dictionary, or throw an error if the conversion fails
      guard let dict = dict else { throw NSError(domain: "Err, unable to serialize to dict", code: 0) }
      return dict
   }
}

// Deprecated ⚠️️
extension Encodable {
   /**
    * Deprecated computed property for getting a dictionary representation of the struct
    * - Remark: This extension is deprecated and has been renamed to `getDict()`.
    */
   @available(*, deprecated, renamed: "getDict")
   public var dict: [String: Any]? {
      // Call the `getDict()` method to get the dictionary representation of the struct
      try? getDict()
   }
}