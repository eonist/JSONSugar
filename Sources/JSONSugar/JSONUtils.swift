import Foundation

public final class JSONUtils {
    /**
     * Describer
     * - Description: Traverses a JSON hierarchy and describes it
     * - Fixme: ⚠️️ add an example in the comments
     */
    public static func describe(_ json: Any? ) {
        // Check if the JSON object is a string
        if let str: String = JSONParser.str(json) {
            Swift.print("Str: \(str)")
        // Check if the JSON object is an integer
        } else if let int: Int = JSONParser.int(json) {
            Swift.print("Int: \(int)")
        // Check if the JSON object is a dictionary
        } else if let dict: [String : Any] = JSONParser.dict(json) {
            Swift.print("Dict.count: " + "\(dict.count)")
            // Loop through each key-value pair in the dictionary
            dict.forEach { (key: String, value: Any) in
                Swift.print("key: \(key)")
                // Recursively call the describe function on each value in the dictionary
                describe(value)
            }
        // Check if the JSON object is an array
        } else if let arr: [Any] = JSONParser.arr(json) {
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
     * - Description: This method converts raw Data into a JSON object. It uses `JSONSerialization to attempt to deserialize the provided data into a JSON format. If successful, it returns the JSON object, which can be a dictionary, an array, or a primitive type. This method is useful when the structure of the JSON is not known in advance or when it is not necessary to convert the JSON into a specific Swift type.
     * - Remark: This work even if type isn't known. So more robust in some cases
     * - Note: The `.mutableContainers` option in `JSONSerialization` allows the resulting containers (i.e., dictionaries and arrays) to be mutable. This means that you can add, remove, or modify elements in the resulting collections. If you don't need to change the JSON object after it's created, you can use the default option, which is `.init()`, to create immutable containers.
     * - Parameter data: data
     * - Fixme: ⚠️️ maybe add mutable immutable param
     */
    public static func data2JSON(data: Data) throws -> Any {
        // Attempt to deserialize JSON data into a JSON object
        try JSONSerialization.jsonObject(
            // The data to deserialize
            with: data, 
            // Specify mutable containers as the reading option for the JSON data
            options: .mutableContainers
        )
    }
    /**
     * Convert from JSON to data
     * - Description: This method serializes a JSON object into Data format. It can handle any JSON object, including arrays, dictionaries, and primitive types. The serialization process includes formatting the JSON data in a pretty-printed manner, which makes the output more readable. This method is useful when you need to convert a JSON object into Data for storage or network transmission.
     * - Remark `.encode()` should do the same
     * - Remark: This work even if type isn't known. So more robust in some cases
     * - Parameter json: json instance
     */
    public static func json2Data(json: Any) throws -> Data {
        // Attempt to serialize a JSON object into data
        try JSONSerialization.data(
            // The JSON object to serialize
            withJSONObject: json, 
            // Specify pretty printed as the writing option for the JSON data
            options: /*JSONSerialization.WritingOptions*/.prettyPrinted
        )
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
