import Foundation

extension Dictionary {
   /**
    * Convert dictionary to json data
    */
   public var data: Data? {
      try? JSONSerialization.data(withJSONObject: self)
   }
}
