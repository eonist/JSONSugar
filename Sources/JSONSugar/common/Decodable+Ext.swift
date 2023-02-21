import Foundation
/**
 * Decodable
 */
extension Decodable {
   /**
    * Dictonary -> Struct
    * ## Examples:
    * let test = Test(dict: ["a": "1", "b": "2"])
    * - Parameter dict: JSON dict
    */
   public init(dict: [String: Any]) throws {
      self = try JSONDecoder().decode(Self.self, from: JSONSerialization.data(withJSONObject: dict))
   }
}
