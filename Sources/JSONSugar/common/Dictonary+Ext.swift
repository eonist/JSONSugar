import Foundation

extension Dictionary {
   /**
    * Convert dictionary to json data
    */
   public func getData() throws -> Data {
      try JSONSerialization.data(withJSONObject: self)
   }
}
// deprecated ⚠️️ 
extension Dictionary {
   @available(*, deprecated, renamed: "getData")
   public var data: Data? {
      try? getData()
   }
}
