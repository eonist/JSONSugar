import UIKit
/**
 * - Fixme: ⚠️️ Move this into a Unit test
 */
class MainVC: UIViewController {
    // Two JSON strings for testing purposes
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
    let jsonStr2: String = """
        {
            "regions" : [
                {"language":"English", "artist":"Beyonce", "album":"Lemonade"},
                {"language":"Portuguese", "artist":"Enrique Iglesias", "album":"Escape"},
                {"language":"Spanish", "artist":"Shakira", "album":"Magia"}
            ]
        }
        """
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Call two test functions
        test1()
        test2()
    }
}
/**
 * Data structure for a whale, conforming to the Decodable protocol
 */
struct Whale: Decodable {
    /**
     * Nested data structure for whale information, conforming to the Decodable protocol
     */
    struct WhaleInfo: Decodable {
        let size: String
        let color: String
    }
    let name: String
    let whaleType: String
    let whaleInfo: WhaleInfo
}
/**
 * Data structure for featured data, conforming to the Codable protocol
 * Contains an array of regions, each with a language, artist, and album
 * ## Examples:
 * let region1: Region = .init(language: "English", artist:"Beyonce", album:"Lemonade"))
 * let region2: Region = .init(language: "Spanish", artist:"Shakira", album:"Magia"))
 * let featured: FeaturedData = .init(regions: [region1,region2])
 */
struct FeaturedData: Codable {
    /**
     * Nested data structure for a region, conforming to the Codable protocol
     * Contains a language, artist, and album
     */
    struct Region: Codable {
        let language: String
        let artist: String
        let album: String
    }
    let regions: [Region]
}
/**
 * tests
 */
extension MainVC {
    /**
     * Testing parsing simple json
     */
    func test1() {
        // Convert the json string to data
        guard let jsonData = jsonStr.data(using: .utf8) else { fatalError("unable to convert string to data") }
        // Decode the data into a Whale object
        guard let whale: Whale = try? decode(data: jsonData) else { fatalError("unable to decode whale") }
        // Print out some properties of the Whale object
        Swift.print("whale.name:  \(whale.name)") // The Whale
        Swift.print("whale.whaleType:  \(whale.whaleType)") // Blue Whale
        Swift.print("whale.whaleInfo.size:  \(whale.whaleInfo.size)") //  22
        Swift.print("whale.whaleInfo.color:  \(whale.whaleInfo.color)") // blue
    }
    /**
     * Testing parsing json array
     */
    func test2() {
        // Convert the json string to data
        guard let jsonData = jsonStr2.data(using: .utf8) else { fatalError("unable to convert string to data") }
        do {
            // Decode the data into a FeaturedData object
            guard let featuredData: FeaturedData = try decode(data: jsonData) else { fatalError("unable to decode whale") }
            // Print out the album property of each Region object in the FeaturedData object's regions array
            featuredData.regions.forEach {
                Swift.print("$0.album:  \($0.album)")// Lemonade, Escape, Magia
            }
        } catch let jsonErr {
            print("Error serializing json", jsonErr)
        }
    }
}
