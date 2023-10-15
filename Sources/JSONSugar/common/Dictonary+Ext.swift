import Foundation

/**
 * Extension for Dictionary to add a method for converting a dictionary to JSON data
 */
extension Dictionary {
   /**
    * Convert dictionary to JSON data
    * - Returns: The JSON data representation of the dictionary
    * - Throws: An error if the conversion fails
    */
   public func getData() throws -> Data {
      // Use the JSONSerialization class to convert the dictionary to JSON data
      try JSONSerialization.data(withJSONObject: self)
   }
}

/**
 * Deprecated extension for Dictionary to add a computed property for getting JSON data
 * - Remark: This extension is deprecated and has been renamed to `getData()`.
 */
extension Dictionary {
   @available(*, deprecated, renamed: "getData")
   public var data: Data? {
      // Call the `getData()` method to get the JSON data representation of the dictionary
      try? getData()
   }
}
