import Foundation
/**
 * Global generic decode method for Decodable
 * - Description: This function is a global generic decode method for Decodable types. It takes JSON data as input and decodes it into the specified Decodable type.
 * - Remark: You can also use `data.decode()`
 * ## Examples:
 * let jsonStr: String = "["a","b","c"]"
 * guard let jsonData = jsonStr.data(using: .utf8) else { fatalError("unable to convert string to data") }
 * guard let strings: [String] = try? decode(data: jsonData) else { fatalError("unable to decode jsonData") }
 * - Parameter data: json-dict-data
 * - Throws: Decoder error
 * - Returns: Class instance
 */
public func decode<T: Decodable>(data: Data) throws -> T {
   let decoder = JSONDecoder() // Create a JSONDecoder instance
   return try decoder.decode( // Attempt to decode the JSON data
      T.self, // Specify the type to decode the JSON data to
      from: data // The JSON data to decode
   ) // End of the decoding process
}
/**
 * Encodable Extension
 */
extension Encodable {
   /**
    * Encode class instance as json-dict-data
    * - Description: This method encodes an instance of an Encodable type into JSON data. It uses the JSONEncoder to perform the encoding.
    * - Remark: This method is useful for converting an object into a JSON data representation.
    * - Throws: An error if the encoding process fails.
    * - Returns: The JSON data representation of the object.
    */
   public func encode() throws -> Data {
      let encoder: JSONEncoder = .init()
      // if #available(macOS 10.13, *), #available(iOS 11.0, *) { // - Fixme: ⚠️️ fix this later by upgrading package etc
         // Assigning an array of output formatting options to the encoder's outputFormatting property
         encoder.outputFormatting = [
            .sortedKeys, // This line sets the output formatting to sort the keys in the encoded JSON
            .prettyPrinted // This line sets the output formatting to pretty print the encoded JSON
         ]
      // } else {
      //    // Fallback on earlier versions
      //    encoder.outputFormatting = .prettyPrinted
      // }
      return try encoder.encode(self)
   }
}
