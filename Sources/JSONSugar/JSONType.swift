import Foundation
/**
 * An enumeration that represents the different types of JSON objects that can be encountered
 * - Description: Represents the type of a JSON element, which can be an array, integer, dictionary, array of dictionaries, or string. This enumeration is used to categorize JSON elements for parsing and type-checking within the application.
 * - Fixme: ⚠️️ add more doc, where is this used etc?
 */
public enum JSONType {
   case arr // An array
   case int // An integer
   case dict // A dictionary
   case dictArr /* An array of dictionaries */ // - Fixme: ⚠️️ rename to arrDict
   case str // A string
}
extension JSONType {
   /**
    * Determines the type of the given JSON object
    * - Description: This method determines the type of a given JSON object. It checks if the JSON object is a string, integer, dictionary, array of dictionaries, or an array, and returns the corresponding JSONType. If the JSON object is not of any of these types, it returns nil.
    * - Parameter json: The JSON object to determine the type of
    * - Returns: The type of the JSON object
    */
   public static func type(_ json: Any?) -> JSONType? {
      switch true {
      case JSONAsserter.isStr(json): return .str // If the JSON object is a String, return .str
      case JSONAsserter.isInt(json): return .int // If the JSON object is an Int, return .int
      case JSONAsserter.isDict(json): return .dict // If the JSON object is a Dictionary, return .dict
      case JSONAsserter.isDictArr(json): return .dictArr // If the JSON object is an array of dictionaries, return .dictArr
      case JSONAsserter.isArr(json): return .arr // If the JSON object is an array, return .arr
      default:
         Swift.print("Type not supported: \(Swift.type(of: json))") // If the JSON object is not supported, print an error message
         return nil
      }
   }
}
