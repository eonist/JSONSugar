import Foundation

/**
 * An enumeration that represents the different types of JSON objects that can be encountered
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