import Foundation
/**
 * Encodable
 */
extension Encodable {
   /**
    * Struct -> Dictionary
    * ## Examples:
    * struct Test { let a: String, b }
    * Test(a: "1", b: "2").dict // ["a": "1", "b": "2"]
    */
   public func getDict() throws -> [String: Any] {
      let data: Data = try JSONEncoder().encode(self)
      // - Fixme: ⚠️️  Not sure how to convert try? to try
      let dict: [String: Any]? = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
      // Quick solution to return non-optional value
      guard let dict = dict else { throw NSError.init(domain: "Err, unable to serialize to dict", code: 0) }
      return dict
   }
}
// Deprecated ⚠️️
extension Encodable {
   @available(*, deprecated, renamed: "getDict")
   public var dict: [String: Any]? {
      try? getDict()
   }
}
