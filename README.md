[![Tests](https://github.com/eonist/JSONSugar/actions/workflows/Tests.yml/badge.svg)](https://github.com/eonist/JSONSugar/actions/workflows/Tests.yml)
[![codebeat badge](https://codebeat.co/badges/f48ea431-2d22-4c0f-89d0-9ca34821b601)](https://codebeat.co/projects/github-com-eonist-jsonsugar-master)

# JSONSugar

> JSON sugar for iOS and macOS

## Description: 
JSONSugar is a Swift package that provides a simple and convenient way to work with JSON data in iOS and macOS apps.

## Motivation
Working with JSON data in Swift can be cumbersome and error-prone. JSONSugar was created to provide a simple and intuitive API for working with JSON data, making it easier to read, write, and manipulate JSON data in Swift.

Installation
JSONSugar can be installed using Swift Package Manager. To install the package, add the following line to your Package.swift file: `.package(url: "https://github.com/eonist/JSONSugar.git", from: "1.0.0")`

### Usage
JSONSugar provides a number of methods for working with JSON data, including:

- decode<T: Decodable>(): Decodes JSON data to a specified type T.
- getData(): Converts a dictionary to JSON data.
- str(dict:): Converts a dictionary to a JSON string.
- json(_:): Converts a JSON string to a JSON object.
- dict(_:): Converts a JSON object to a dictionary.
- dictArr(_:): Converts a JSON object to an array of dictionaries.

### Examples: (One-liner )

```swift
let strings: [String]? = try? "["a","b","c"]".data(using: .utf8)?.decode()
let strings: [String]? = try? "["a","b","c"]".decode()
let strings: [String]? = try? FileParser.data(filePath: filePath)?.decode() else { fatalError("Err") }
```

### Example: (Basic)

```swift
import JsonSugar

let jsonStr: String = """
{
    "name": "The Whale",
    "whaleType": "Blue Whale",
    "whaleInfo": {
        "size":"22",
        "color":"blue"
    }
}
"""
/**
 * Data structure
 */
struct Whale: Decodable {
    struct WhaleInfo: Decodable {
        let size: String
        let color: String
    }
    let name: String
    let whaleType: String
    let whaleInfo: WhaleInfo
}

guard let jsonData = jsonStr.data(using: .utf8) else { fatalError("unable to convert string to data") }
guard let whale: Whale = try? decode(data: jsonData) else { fatalError("unable to decode whale") }

Swift.print("whale.name:  \(whale.name)") // The Whale
Swift.print("whale.whaleType:  \(whale.whaleType)") // Blue Whale
Swift.print("whale.whaleInfo.size:  \(whale.whaleInfo.size)") //  22
Swift.print("whale.whaleInfo.color:  \(whale.whaleInfo.color)") // blue

```

## Json-Array example:

```swift
import JsonSugar

let jsonStr = """
{
    "regions" : [
        {"language":"English", "artist":"Beyonce", "album":"Lemonade"},
        {"language":"Portuguese", "artist":"Enrique Iglesias", "album":"Escape"},
        {"language":"Spanish", "artist":"Shakira", "album":"Magia"}
    ]
}
"""
guard let jsonData = jsonStr.data(using: .utf8) else { fatalError("unable to convert string to data") }
do {
   guard let featuredData: FeaturedData = try decode(data: jsonData) else { fatalError("unable to decode json") }//From json to struct {
    featuredData.regions.forEach {
        Swift.print("$0.album:  \($0.album)")// Lemonade, Escape, Magia
    }
} catch let jsonErr {
    print("Error serializing json", jsonErr)
}
/**
 * Data structure
 * ## Examples:
 * let region1: Region = .init(language: English", artist:"Beyonce", album:"Lemonade"))
 * let region2: Region = .init(language: Spanish", artist:"Shakira", album:"Magia"))
 * let featured: Featured = .init(regions: [region1, region2])
 */
struct FeaturedData : Codable{
    struct Region : Codable {
        let language: String
        let artist: String
        let album: String
    }
    let regions: [Region]
}
```

### Simple array:
```swift
let jsonStr = """
[
    {"language":"English", "artist":"Beyonce", "album":"Lemonade"},
    {"language":"Portuguese", "artist":"Enrique Iglesias", "album":"Escape"},
    {"language":"Spanish", "artist":"Shakira", "album":"Magia"}
]
"""
guard let jsonData = jsonStr.data(using: .utf8) else { fatalError("unable to convert string to data") }
do {
   guard let regions: [Region] = try decode(data: jsonData) else { fatalError("unable to decode json") }//From json to struct {
    regions.forEach {
        Swift.print("$0.album:  \($0.album)")// Lemonade, Escape, Magia
    }
} catch let jsonErr {
    print("Error serializing json", jsonErr)
}
struct Region : Codable {
    let language: String
    let artist: String
    let album: String
}
```

### Dict Example
```swift
guard let jsonStr: String = JSONParser.str(dict: ["2": "B", "1": "A", "3": ["1": true]]) else { Swift.print("err Dict -> json-str"); return }
guard let json = JSONParser.json(jsonStr) else { Swift.print("err json-str -> json"); return }
guard let dict: [String: Any] = JSONParser.dict(json) else { Swift.print("err json -> Dict"); return }// Output: doctor
let val = dict["1"]
Swift.print("val:  \(val)") // A
```

### Dictionary Array example:
```swift
let dictA: [String: Any] = ["3": ["1": true]]
let dictB: [String: Any] = ["2": "B", "1": "A"]
guard let jsonStr: String = JSONParser.str(dictArr: [dictA, dictB]) else { Swift.print("err Dict -> json-str"); return }
Swift.print("jsonStr:  \(jsonStr)")
guard let json = JSONParser.json(jsonStr) else { Swift.print("err json-str -> json"); return }
guard let dictArr = JSONParser.dictArr(json) else { Swift.print("err json -> dictArr"); return }// Output: doctor
Swift.print("arr.count:  \(dictArr.count)") //
let val = dictArr[1]["1"]
Swift.print("val:  \(val)") // A
```
### Struct and dictionary:

```swift
struct Job: Codable, Equatable {
   let number: Int
   let name: String
   let client: String
}
let job: Job = .init(number: 1234, name: "Awards Ceremony", client: "ACME Productions")
let dict: [String: Any] = job.dict ?? [:]
let clone = try? Job(dict: dict)
print("\(job == clone ? "✅" : "🚫")") // ✅
```

### Todo:
- Add basic example ✅
- Add github actions ✅
- Add unit tests 👈👈👈
- Add transformer example
