import Foundation

extension Dictionary {
   /**
    * - Fixme: ⚠️️ add doc
    */
   public var data: Data? {
      try? JSONSerialization.data(withJSONObject: self)
   }
}
