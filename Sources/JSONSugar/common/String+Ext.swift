import Foundation
/**
 * String
 */
extension String {
   /**
    * Decode json-dict-data
    * ## Examples:
    * let strings: [String]? = try ? "["a","b","c"]".decode()
    */
   public func decode<T: Decodable>(encoding: String.Encoding = .utf8) throws -> T {
      let decoder = JSONDecoder()
      guard let data: Data = self.data(using: encoding) else { throw NSError(domain: "unable to convert string to data", code: 0) }
      return try decoder.decode(T.self, from: data)
   }
}
