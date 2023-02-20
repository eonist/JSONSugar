import Foundation

extension Encodable {
   /**
    * Struct -> Dictionary
    * ## Examples:
    * struct Test { let a: String, b }
    * Test(a: "1", b: "2").dict // ["a": "1", "b": "2"]
    */
   public var dict: [String: Any]? {
      guard let data = try? JSONEncoder().encode(self) else { return nil }
      return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
   }
}
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
