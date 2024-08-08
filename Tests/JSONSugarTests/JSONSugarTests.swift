import XCTest
@testable import JSONSugar

final class JSONSugarTests: XCTestCase {

    /**
     * Test the all tests
     * - Description: This is a collection of all the test cases for the JSONSugar package. It includes tests for decoding, getting data, converting string to dictionary, converting JSON string to JSON object, converting JSON object to dictionary, and converting JSON object to an array of dictionaries.
     */
    static var allTests = [
        // basics
        ("testDecode", testDecode),
        ("testGetData", testGetData),
        ("testStrDict", testStrDict),
        ("testJson", testJson),
        ("testDict", testDict),
        ("testDictArr", testDictArr),
        // advance
        ("testDecodeStringArray", testDecodeStringArray),
        ("testStructToDict", testStructToDict),
        ("testInitWithDictionary", testInitWithDictionary),
        ("testDecodeStringArrayWithDecodeFunction", testDecodeStringArrayWithDecodeFunction),
        ("testJSONParserDict", testJSONParserDict),
        ("testJSONParserDictArr", testJSONParserDictArr)
    ]
}
// basics
extension JSONSugarTests {
     /**
     * Test the decode function
     * - Description: This test case verifies the functionality of the decode function. It creates a JSON string, converts it to Data, and then uses the decode function to convert the Data into a User object. The test asserts that the User object is not nil and that its properties match the expected values.
     */
    func testDecode() {
        let jsonString = "{\"name\":\"John\", \"age\":30, \"city\":\"New York\"}"
        let jsonData = jsonString.data(using: .utf8)!
        let user: [String: Any]? = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        XCTAssertNotNil(user)
        XCTAssertEqual(user?["name"] as? String, "John")
        XCTAssertEqual(user?["age"] as? Int, 30)
        XCTAssertEqual(user?["city"] as? String, "New York")
    }
    /**
     * Test the getData function
     * - Description: This test case verifies the functionality of the getData function. It creates a dictionary and then uses the getData function to convert the dictionary into Data. The test asserts that the resulting Data is not nil.
     */
    func testGetData() {
        let dict: [String: Any] = ["name": "John", "age": 30, "city": "New York"]
        do {
            let data = try dict.getData()
            XCTAssertNotNil(data)
        } catch {
            XCTFail("Error getting data from dictionary: \(error)")
        }
    }
    /**
     * Test the strDict function
     * - Description: This test case verifies the functionality of the strDict function. It creates a dictionary and then uses the strDict function to convert the dictionary into a JSON string. The test asserts that the resulting JSON string is not nil and contains the expected values.
     */
    func testStrDict() {
        let dict: [String: Any] = ["name": "John", "age": 30, "city": "New York"]
        let jsonString = JSONParser.str(dict: dict)
        XCTAssertNotNil(jsonString)
        XCTAssertTrue(jsonString?.contains("John") ?? false)
        XCTAssertTrue(jsonString?.contains("30") ?? false)
        XCTAssertTrue(jsonString?.contains("New York") ?? false)
    }
    /**
     * Test the json function
     * - Description: This test case verifies the functionality of the json function. It creates a JSON string and then uses the json function to convert the string into a JSON object. The test asserts that the JSON object is not nil and that it contains the expected values for keys "name", "age", and "city".
     */
    func testJson() {
        let jsonString = "{\"name\":\"John\", \"age\":30, \"city\":\"New York\"}"
        let json = JSONParser.json(jsonString)
        XCTAssertNotNil(json)
        if let dict = json as? [String: Any] {
            XCTAssertEqual(dict["name"] as? String, "John")
            XCTAssertEqual(dict["age"] as? Int, 30)
            XCTAssertEqual(dict["city"] as? String, "New York")
        } else {
            XCTFail("JSON is not a dictionary")
        }
    }
    /**
     * Test the dict function
     * - Description: This test case verifies the functionality of the dict function. It creates a JSON string, converts it to a JSON object using the json function, and then uses the dict function to convert the JSON object into a dictionary. The test asserts that the dictionary is not nil and that its key-value pairs match the expected values.
     */
    func testDict() {
        let jsonString = "{\"name\":\"John\", \"age\":30, \"city\":\"New York\"}"
        let json = JSONParser.json(jsonString)
        let dict = JSONParser.dict(json)
        XCTAssertNotNil(dict)
        XCTAssertEqual(dict?["name"] as? String, "John")
        XCTAssertEqual(dict?["age"] as? Int, 30)
        XCTAssertEqual(dict?["city"] as? String, "New York")
    }
    /**
     * Test the dictArr function
     * - Description: This test case verifies the functionality of the dictArr function. It creates a JSON string representing an array of dictionaries and then uses the dictArr function to convert the JSON string into an array of dictionaries. The test asserts that the resulting array is not nil, has the correct count, and contains the expected values.
     */
    func testDictArr() {
        let jsonString = "[{\"name\":\"John\", \"age\":30, \"city\":\"New York\"}, {\"name\":\"Jane\", \"age\":25, \"city\":\"Los Angeles\"}]"
        let json = JSONParser.json(jsonString)
        let dictArr = JSONParser.dictArr(json)
        XCTAssertNotNil(dictArr)
        XCTAssertEqual(dictArr?.count, 2)
        XCTAssertEqual(dictArr?[0]["name"] as? String, "John")
        XCTAssertEqual(dictArr?[0]["age"] as? Int, 30)
        XCTAssertEqual(dictArr?[0]["city"] as? String, "New York")
        XCTAssertEqual(dictArr?[1]["name"] as? String, "Jane")
        XCTAssertEqual(dictArr?[1]["age"] as? Int, 25)
        XCTAssertEqual(dictArr?[1]["city"] as? String, "Los Angeles")
    }
}
// extra tests
extension JSONSugarTests {
    /**
     * Test the decode function
     * - Description: This test case verifies the functionality of the decode function. It creates a JSON string, converts it to Data, and then uses the decode function to convert the Data into a User object. The test asserts that the User object is not nil and that its properties match the expected values.
     */
    func testDecodeStringArray() throws {
        let jsonString = "[\"a\",\"b\",\"c\"]"
        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("Unable to convert string to Data")
            return
        }
        guard let strings = try? JSONDecoder().decode([String].self, from: jsonData) else {
            XCTFail("Unable to decode jsonData into [String]")
            return
        }
        XCTAssertEqual(strings, ["a", "b", "c"], "Decoded array does not match expected values")
    }
    /** 
     * Test the asDictionary function
     * - Description: This test case verifies the functionality of the asDictionary function. It creates a struct, converts it to a dictionary, and then uses the asDictionary function to convert the struct into a dictionary. The test asserts that the resulting dictionary is not nil and that its key-value pairs match the expected values.
     */
    func testStructToDict() throws {
        struct TestStruct: Codable {
            let a: String
            let b: String
        }
        let testStruct = TestStruct(a: "1", b: "2")
        let jsonData = try JSONEncoder().encode(testStruct)
        guard let dict = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] else {
            XCTFail("Unable to convert TestStruct to Dictionary")
            return
        }
        XCTAssertEqual(dict["a"] as? String, "1", "Property 'a' did not match expected value")
        XCTAssertEqual(dict["b"] as? String, "2", "Property 'b' did not match expected value")
    }
    /** 
     * Test the initWithDictionary function
     * - Description: This test case verifies the functionality of the initWithDictionary function. It creates a dictionary, converts it to a struct, and then uses the initWithDictionary function to convert the dictionary into a struct. The test asserts that the resulting struct is not nil and that its properties match the expected values.
     */
    func testInitWithDictionary() throws {
        let dict: [String: String] = ["a": "1", "b": "2"]
        struct Test { let a: String; let b: String }
        guard let a = dict["a"], let b = dict["b"] else {
            XCTFail("Unable to extract values from dictionary")
            return
        }
        let test = Test(a: a, b: b)
        XCTAssertNotNil(test, "Failed to initialize Test with dictionary")
        XCTAssertEqual(test.a, "1", "Property 'a' did not match expected value")
        XCTAssertEqual(test.b, "2", "Property 'b' did not match expected value")
    }
    /** 
     * Test the decode function
     * - Description: This test case verifies the functionality of the decode function. It creates a JSON string, converts it to Data, and then uses the decode function to convert the Data into a User object. The test asserts that the User object is not nil and that its properties match the expected values.
     */
    func testDecodeStringArrayWithDecodeFunction() throws {
        let jsonStr: String = "[\"a\",\"b\",\"c\"]"
        guard let jsonData = jsonStr.data(using: .utf8) else {
            XCTFail("Unable to convert string to Data")
            return
        }
        guard let strings: [String] = try? JSONDecoder().decode([String].self, from: jsonData) else {
            XCTFail("Unable to decode jsonData into [String]")
            return
        }
        XCTAssertEqual(strings, ["a", "b", "c"], "Decoded array does not match expected values")
    }
    /** 
     * Test the dict function
     * - Description: This test case verifies the functionality of the dict function. It creates a JSON string, converts it to a JSON object using the json function, and then uses the dict function to convert the JSON object into a dictionary. The test asserts that the resulting dictionary is not nil and that its key-value pairs match the expected values.
     */
    func testJSONParserDict() throws {
        let jsonString = "{\"title\":\"doctor\"}"
        guard let json = JSONParser.json(jsonString) else {
            XCTFail("Unable to convert jsonString to JSON")
            return
        }
        guard let dict = JSONParser.dict(json) else {
            XCTFail("Unable to convert JSON to Dictionary")
            return
        }
        XCTAssertEqual(dict["title"] as? String, "doctor", "The title should be 'doctor'")
    }  
    /** 
     * Test the dictArr function
     * - Description: This test case verifies the functionality of the dictArr function. It creates a JSON string representing an array of dictionaries and then uses the dictArr function to convert the JSON string into an array of dictionaries. The test asserts that the resulting array is not nil, has the correct count, and contains the expected values.
     */
    func testJSONParserDictArr() throws {
        let jsonString = "[{\"title\": \"doctor\"}]"
        guard let json = JSONParser.json(jsonString) else {
            XCTFail("Unable to convert jsonString to JSON")
            return
        }
        guard let dictArr = JSONParser.dictArr(json) else {
            XCTFail("Unable to convert JSON to Array of Dictionaries")
            return
        }
        dictArr.forEach { dict in
            XCTAssertEqual(dict["title"] as? String, "doctor", "The title should be 'doctor'")
        }
    }
    /** 
     * Test the json function
     * - Description: This test case verifies the functionality of the json function. It creates a JSON string, converts it to a JSON object using the json function, and then uses the json function to convert the JSON object into a JSON string. The test asserts that the resulting JSON string is not nil and contains the expected values.
     */
    func testJSONStringToJSONObject() throws {
        let jsonString = "{\"title\": \"doctor\"}"
        guard let json = JSONParser.json(jsonString) else {
            XCTFail("Unable to convert jsonString to JSON")
            return
        }
        XCTAssertNotNil(json, "The JSON object should not be nil")
        if let dict = json as? [String: Any] {
            XCTAssertEqual(dict["title"] as? String, "doctor", "The title should be 'doctor'")
        } else {
            XCTFail("JSON object is not a dictionary")
        }
    }
    /** 
     * Test the strDict function
     * - Description: This test case verifies the functionality of the strDict function. It creates a dictionary, converts it to a JSON string using the strDict function, and then uses the strDict function to convert the JSON string into a dictionary. The test asserts that the resulting dictionary is not nil and that its key-value pairs match the expected values.
     */
    func testJSONParserStrDict() throws {
        let dict: [String: Any] = ["2": "B", "1": "A", "3": ["1": true]]
        guard let jsonString = JSONParser.str(dict: dict) else {
            XCTFail("Unable to convert Dictionary to jsonString")
            return
        }
        XCTAssertNotNil(jsonString, "The JSON string should not be nil")
        let jsonData = jsonString.data(using: .utf8)!
        let convertedDict: [String: Any]? = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        XCTAssertEqual(convertedDict?["2"] as? String, "B")
        XCTAssertEqual(convertedDict?["1"] as? String, "A")
        let innerDict = convertedDict?["3"] as? [String: Bool]
        XCTAssertEqual(innerDict?["1"], true)
    }
    /** 
     * Test the strDictArr function
     * - Description: This test case verifies the functionality of the strDictArr function. It creates an array of dictionaries, converts it to a JSON string using the strDictArr function, and then uses the strDictArr function to convert the JSON string into an array of dictionaries. The test asserts that the resulting array is not nil, has the correct count, and contains the expected values.
     */
    func testJSONParserStrDictArr() throws {
        let dictArr: [[String: Any]] = [["name": "John", "age": 30], ["name": "Jane", "age": 25]]
        guard let jsonString = JSONParser.str(dictArr: dictArr) else {
            XCTFail("Unable to convert Array of Dictionaries to jsonString")
            return
        }
        XCTAssertNotNil(jsonString, "The JSON string should not be nil")
        let jsonData = jsonString.data(using: .utf8)!
        let convertedDictArr: [[String: Any]]? = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]]
        XCTAssertNotNil(convertedDictArr, "The converted array of dictionaries should not be nil")
        XCTAssertEqual(convertedDictArr?.count, 2, "The count of the array should be 2")
        XCTAssertEqual(convertedDictArr?[0]["name"] as? String, "John", "The name in the first dictionary should be 'John'")
        XCTAssertEqual(convertedDictArr?[0]["age"] as? Int, 30, "The age in the first dictionary should be 30")
        XCTAssertEqual(convertedDictArr?[1]["name"] as? String, "Jane", "The name in the second dictionary should be 'Jane'")
        XCTAssertEqual(convertedDictArr?[1]["age"] as? Int, 25, "The age in the second dictionary should be 25")
    }
}
