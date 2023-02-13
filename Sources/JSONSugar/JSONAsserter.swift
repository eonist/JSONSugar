import Foundation

public class JSONAsserter {
   /**
    * Asserts if a a json is a dictionary
    * - Parameter json: json dict isntance
    */
   static func isDict(_ json: Any?) -> Bool {
      JSONParser.dict(json) != nil
   }
   /**
    * Asserts if a a json is an Array
    * - Parameter json: json array instance
    */
   static func isArr(_ json: Any?) -> Bool {
      JSONParser.arr(json) != nil
   }
   /**
    * Asserts if a a json is an array of dictioaries
    * - Parameter json: json dict array instance
    */
   static func isDictArr(_ json: Any?) -> Bool {
      JSONParser.dictArr(json) != nil
   }
   /**
    * Asserts if a json is a string
    * - Parameter json: json string
    */
   static func isStr(_ json: Any?) -> Bool {
      JSONParser.str(json) != nil
   }
   /**
    * Asserts if a json is an int
    * - Parameter json: json int
    */
   static func isInt(_ json: Any?) -> Bool {
      JSONParser.int(json) != nil
   }
}
