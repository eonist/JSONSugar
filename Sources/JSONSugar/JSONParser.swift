import Foundation
/**
 * A utility class for parsing JSON data
 * - Important. ⚠️️ See String+Extension `"".json` for json serilization from string and data
 */
public final class JSONParser {
   /**
    * Returns an array of any type if the json is of type array
    * - Description: The arr method takes a JSON object as input and returns an array of any type if the JSON object is of type array, otherwise it returns nil.
    * - Parameter json: The JSON object to parse
    * - Returns: An array of any type if the json is of type array, otherwise nil
    */
   public static func arr(_ json: Any?) -> [Any]? {
      json as? [Any]
   }
   /**
    * Returns a dictionary of type [String: Any] if the json is of type dictionary
    * - Description: The dict method takes a JSON object as input and returns a dictionary of type [String: Any] if the JSON object is of type dictionary, otherwise it returns nil. This method is not generic and should be replaced with a generic implementation.
    * - Parameter json: The JSON object to parse
    * - Returns: A dictionary of type [String: Any] if the json is of type dictionary, otherwise nil
    * - Note: This method is not generic and should be replaced with a generic implementation
    * ## Examples:
    * JSONParser.dict("{\"title\":\"doctor\"}".json)["title"] //Output: doctor
    * - Fixme: ⚠️️ Use generics on this. See DictParser etc
    */
   public static func dict(_ json: Any?) -> [String: Any]? {
      json as? [String: Any]
   }
   /**
    * Returns an integer if the json is of type integer
    * - Description: The int method takes a JSON object as input and returns an integer if the JSON object is of type integer, otherwise it returns nil.
    * - Parameter json: The JSON object to parse
    * - Returns: An integer if the json is of type integer, otherwise nil
    */
   public static func int(_ json: Any?) -> Int? {
      json as? Int
   }
   /**
    * Returns a string if the json is of type string
    * - Description: The str method takes a JSON object as input and returns a string if the JSON object is of type string, otherwise it returns nil.
    * - Parameter json: The JSON object to parse
    * - Returns: A string if the json is of type string, otherwise nil
    */
   public static func str(_ json: Any?) -> String? {
      json as? String
   }
   /**
    * Returns an array of dictionaries if the json is of type array of dictionaries
    * - Description: The dictArr method takes a JSON object as input and returns an array of dictionaries if the JSON object is of type array of dictionaries, otherwise it returns nil.
    * - Parameter json: The JSON object to parse
    * - Returns: An array of dictionaries if the json is of type array of dictionaries, otherwise nil
    * ## Examples:
    * JSONParser.dictArr(JSONParser.json("[{\"title\": \"doctor\"}]"))?.forEach { print("\(JSONParser.dict($0)?["title"])") } //doctor
    */
   public static func dictArr(_ json: Any?) -> [[String: Any]]? {
      json as? [[String: Any]]
   }
   /**
    * Converts a JSON string to a JSON object
    * - Description: The json method takes a JSON string as input and returns the corresponding JSON object, or nil if the string is not a valid JSON string.
    * - Parameter str: The JSON string to convert
    * - Returns: The resulting JSON object, or nil if the string is not a valid JSON string
    * ## Examples:
    * "{\"title\": \"doctor\"}".json // Output: a JSON object
    * - Parameter str: json string
    */
   public static func json(_ str: String) -> Any? {
      // Convert the string to data
      guard let data: Data = str.data( // Attempt to convert the string to Data using UTF-8 encoding without lossy conversion
         using: String.Encoding.utf8, // Specify UTF-8 as the string encoding
         allowLossyConversion: false // Do not allow lossy conversion
      ) // End of guard statement
      else { 
         return nil 
      }
      // Convert the data to a JSON object
      if let json: Any = try? JSONSerialization.jsonObject( // Attempt to deserialize the JSON data into a JSON object
         with: data, // The data to deserialize
         options: [] // No options specified for deserialization
      ) {
         return json
      } else {
         // Print an error message if the conversion fails
         Swift.print("⚠️️ JSON is format wrongly: \(str)")
         return nil
      }
   }
   /**
    * Converts a dictionary to a JSON string
    * - Description: The str(dict:) method takes a dictionary as input and returns the corresponding JSON string, or nil if the dictionary cannot be converted to a JSON string. The opposite of this method is JSONSerialization.jsonObject(with:options:), which can be used to convert a JSON string back to a dictionary. If the dictionary contains keys of type Int, recursion or reflection should be used instead.
    * - Parameter dict: The dictionary to convert
    * - Returns: The resulting JSON string, or nil if the dictionary cannot be converted to a JSON string
    * - Remark: The opposite of this method is: `let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])`. If `decoded` is of type `[String:String]`, then the JSON string can be converted back to a dictionary.
    * - Remark: If the dictionary contains keys of type `Int`, recursion or reflection should be used instead.
    * ## Examples:
    * JSONParser.str(dict: ["2": "B", "1": "A", "3": ["1": true]])
    */
   public static func str<Key, Value>(dict: [Key: Value]) -> String? {
      do {
         // Convert the dictionary to JSON data
         let jsonData: Data = try JSONSerialization.data( // Attempt to serialize the dictionary into JSON data
            withJSONObject: dict, // The dictionary object to serialize
            options: .prettyPrinted // JSON output formatting option for pretty-printed string
         ) // End of serialization attempt
         // Convert the JSON data to a string
         return NSString(
            data: jsonData, // Create an NSString from the JSON data
            encoding: String.Encoding.utf8.rawValue // Use UTF-8 encoding for the string conversion
         ) as String? // Cast the NSString to a native Swift String, may return nil if conversion fails
      } catch {
         // Print the error message if an error occurs
         Swift.print(error.localizedDescription)
         return nil
      }
   }
   /**
    * Converts an array of dictionaries to a JSON string
    * - Description: The str(dictArr:) method takes an array of dictionaries as input and returns the corresponding JSON string, or nil if the array of dictionaries cannot be converted to a JSON string. This method is similar to str(dict:), but is used for an array of dictionaries instead of a single dictionary. The parameter name should be renamed to arrDict.
    * - Parameter dictArr: The array of dictionaries to convert
    * - Returns: The resulting JSON string, or nil if the array of dictionaries cannot be converted to a JSON string
    * - Remark: This method is similar to `str(dict:)`, but is used for an array of dictionaries instead of a single dictionary.
    * - Remark: The parameter name should be renamed to `arrDict`.
    * - Example: `JSONParser.str(dictArr: [["name": "John", "age": 30], ["name": "Jane", "age": 25]])`
    * - Fixme: ⚠️️ rename param to arrDict?
    */
   public static func str<Key, Value>(dictArr: [[Key: Value]]) -> String? {
      do {
         // Convert the array of dictionaries to JSON data
         let jsonData: Data = try JSONSerialization.data( // Attempt to serialize the array of dictionaries into JSON data
            withJSONObject: dictArr, // The array of dictionaries object to serialize
            options: .prettyPrinted // JSON output formatting option for pretty-printed string
         ) // End of serialization attempt
         // Convert the JSON data to a string
         return NSString( // Create an NSString from the JSON data
            data: jsonData, // The JSON data to be converted to string
            encoding: String.Encoding.utf8.rawValue // Specify UTF-8 as the string encoding
         ) as String? // Cast the NSString to a native Swift String, may return nil if conversion fails
      } catch {
         // Print the error message if an error occurs
         Swift.print(error.localizedDescription)
         return nil
      }
   }
}
