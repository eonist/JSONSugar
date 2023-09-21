import Foundation

public final class JSONUtils {
    /**
     * Describer
     * - Description: Traverses the json hierarchy and describes it
     */
    public static func describe(_ json: Any? ) {
        // Check if the JSON object is a string
        if let str = JSONParser.str(json) {
            Swift.print("Str: \(str)")
        // Check if the JSON object is an integer
        } else if let int = JSONParser.int(json) {
            Swift.print("Int: \(int)")
        // Check if the JSON object is a dictionary
        } else if let dict = JSONParser.dict(json) {
            Swift.print("Dict.count: " + "\(dict.count)")
            // Loop through each key-value pair in the dictionary
            dict.forEach { key, value in
                Swift.print("key: \(key)")
                // Recursively call the describe function on each value in the dictionary
                describe(value)
            }
        // Check if the JSON object is an array
        } else if let arr = JSONParser.arr(json){
            Swift.print("Arr.count: " + "\(arr.count)")
            // Loop through each element in the array
            arr.forEach { describe($0) }
        // If the JSON object is of any other type, print a warning message
        } else {
            Swift.print("⚠️️ Type not supported: \(type(of: json)) type \(String(describing: JSONType.type(json)))")
        }
    }
    /**
     * Convert data to JSON
     * - Remark: This work even if type isn't known. So more robust in some cases
     * - Fixme: ⚠️️ add more doc regardign `.mutableContainers`
     * - Parameter data: data
     */
    public static func data2JSON(data: Data) throws -> Any {
        try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    /**
     * Convert from JSON to data
     * - Remark `.encode()` should do the same
     * - Remark: This work even if type isn't known. So more robust in some cases
     * - Parameter json: json instnace
     */
    public static func json2Data(json: Any) throws -> Data {
        try JSONSerialization.data(withJSONObject: json, options: /*JSONSerialization.WritingOptions*/.prettyPrinted)
    }
}

// deprecated
extension JSONUtils {
    // Deprecated ⚠️️
    /**
     * A utility class for working with JSON data
     * - Note: This class is deprecated and should not be used
     */
    @available(*, deprecated, message: "This class is deprecated and should not be used")
    public class JSONUtils {
        /**
         * Converts the given data to a JSON object
         * - Parameter data: The data to convert
         * - Returns: The resulting JSON object
         * - Note: This method is deprecated and should not be used. Use `data2JSON` instead.
         */
        @available(*, deprecated, renamed: "data2JSON")
         public static func dataToJSON(data: Data) -> Any? {
            do {
               // Convert the data to a JSON object
               return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            } catch let myJSONError {
               // Print the error message if an error occurs
               print(myJSONError)
               return nil
            }
         }
        /**
         * Converts the given JSON object to data
         * - Parameter json: The JSON object to convert
         * - Returns: The resulting data
         * - Note: This method is deprecated and should not be used. Use `json2Data` instead.
         */
        @available(*, deprecated, renamed: "json2Data")
        public static func jsonToData(json: Any) -> Data? {
            do {
                return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch let myJSONError {
                print(myJSONError)
                return nil
            }
        }
    }
}