import Foundation

extension Dictionary {
   public var data: Data? {
      try? JSONSerialization.data(withJSONObject: self)
   }
}
