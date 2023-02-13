import Foundation

public class JSONUtils {
   /**
    * Describer
    * - Description: Traverses the json hierarchy and describes it
    */
   public static func describe(_ json: Any?) {
      if let str = JSONParser.str(json) {
         Swift.print("Str: \(str)")
      } else if let int = JSONParser.int(json) {
         Swift.print("Int: \(int)")
      } else if let dict = JSONParser.dict(json) {
         Swift.print("Dict.count: " + "\(dict.count)")
         dict.forEach { key, value in
            Swift.print("key: \(key)")
            describe(value)
         }
      } else if let arr = JSONParser.arr(json) {
         Swift.print("Arr.count: " + "\(arr.count)")
         arr.forEach { describe($0) }
      } else {
         Swift.print("⚠️️ Type not supported: \(type(of: json)) type \(String(describing: JSONType.type(json)))")
      }
   }
   /**
    * Convert data to JSON
    * - Note: `.decode()` should do the same
    * - Remark: This work even if type isn't known. So more robust in some cases
    * - Parameter data: data
    */
   public static func dataToJSON(data: Data) -> Any? {
      do {
         return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
      } catch let myJSONError {
         print(myJSONError)
      }
      return nil
   }
   /**
    * Convert from JSON to data
    * - Remark `.encode()` should do the same
    * - Remark: This work even if type isn't known. So more robust in some cases
    * - Parameter json: json instnace
    */
   public static func jsonToData(json: Any) -> Data? {
      do {
         return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
      } catch let myJSONError {
         print(myJSONError)
      }
      return nil
   }
}
