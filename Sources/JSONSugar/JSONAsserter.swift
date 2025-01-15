import Foundation
/**
 * JSON asserter
 */
public final class JSONAsserter {
   /**
    * Asserts if a a json is a dictionary
    * - Description: This method checks if the provided JSON object is a dictionary. It uses the `JSONParser.dict` method to attempt to cast the JSON object to a dictionary type and returns a Boolean indicating whether the cast was successful.
    * - Parameter json: json dict isntance
    */
   @available(*, deprecated, renamed: "isDictionary")
   static func isDict(_ json: Any?) -> Bool {
      JSONParser.dict(json) != nil
   }
   /**
    * Asserts if a a json is an Array
    * - Description: This method checks if the provided JSON object is an array.
    * - Parameter json: json array instance
    */
   @available(*, deprecated, renamed: "isArray")
   static func isArr(_ json: Any?) -> Bool {
      JSONParser.arr(json) != nil
   }
   /**
    * Asserts if a a json is an array of dictioaries
    * - Description: This method checks if the provided JSON object is an array of dictionaries. It uses the `JSONParser.dictArr` method to attempt to cast the JSON object to an array of dictionaries type and returns a Boolean indicating whether the cast was successful.
    * - Parameter json: json dict array instance
    */
   @available(*, deprecated, renamed: "isDictionaryArray")
   static func isDictArr(_ json: Any?) -> Bool {
      JSONParser.dictArr(json) != nil
   }
   /**
    * Asserts if a json is a string
    * - Description: This method checks if the provided JSON object is a string. It uses the `JSONParser.str` method to attempt to cast the JSON object to a string type and returns a Boolean indicating whether the cast was successful.
    * - Parameter json: json string
    */
   @available(*, deprecated, renamed: "isString")
   static func isStr(_ json: Any?) -> Bool {
      JSONParser.str(json) != nil
   }
   /**
    * Asserts if a json is an int
    * - Description: This method checks if the provided JSON object is an integer. It uses the `JSONParser.int` method to attempt to cast the JSON object to an integer type and returns a Boolean indicating whether the cast was successful.
    * - Parameter json: json int
    */
   @available(*, deprecated, renamed: "isInteger")
   static func isInt(_ json: Any?) -> Bool {
      JSONParser.int(json) != nil
   }
}
// fixme: add doc
extension JSONAsserter {
   
   /**
    * Checks if the provided JSON object is a dictionary.
    *
    * - Parameter json: The JSON object to check.
    * - Returns: `true` if the JSON object is a dictionary; otherwise, `false`.
    */
   static func isDictionary(_ json: Any?) -> Bool {
       return json as? [String: Any] != nil
   }

   /**
    * Checks if the provided JSON object is an array.
    *
    * - Parameter json: The JSON object to check.
    * - Returns: `true` if the JSON object is an array; otherwise, `false`.
    */
   static func isArray(_ json: Any?) -> Bool {
       return json as? [Any] != nil
   }

   /**
    * Checks if the provided JSON object is an array of dictionaries.
    *
    * - Parameter json: The JSON object to check.
    * - Returns: `true` if the JSON object is an array of dictionaries; otherwise, `false`.
    */
   static func isDictionaryArray(_ json: Any?) -> Bool {
       if let _ = json as? [[String: Any]] {
           return true
       }
       return false
   }

   /**
    * Checks if the provided JSON object is a string.
    *
    * - Parameter json: The JSON object to check.
    * - Returns: `true` if the JSON object is a string; otherwise, `false`.
    */
   static func isString(_ json: Any?) -> Bool {
       return json as? String != nil
   }

   /**
    * Checks if the provided JSON object is an integer.
    *
    * - Parameter json: The JSON object to check.
    * - Returns: `true` if the JSON object is an integer; otherwise, `false`.
    */
   static func isInteger(_ json: Any?) -> Bool {
       return json as? Int != nil
   }
}
