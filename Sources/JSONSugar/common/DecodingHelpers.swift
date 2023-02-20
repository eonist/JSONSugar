import Foundation
/**
 * Makes the code more reusable / modular
 */
public protocol DecodingContainerTransformer {
   associatedtype DecodingInput
   associatedtype DecodingOutput
   func decode(input: DecodingInput) throws -> DecodingOutput
}
/**
 * Makes the code more reusable/modular
 */
extension KeyedDecodingContainer {
   /**
    * Ability to decode more complex json structures?
    * - Parameters:
    *   - key: - Fixme: ⚠️️ add doc
    *   - transformer: - Fixme: ⚠️️ add doc
    * - Returns: - Fixme: ⚠️️ add doc
    */
   public func decode<Transformer: DecodingContainerTransformer>(key: Key, transformer: Transformer) throws -> Transformer.DecodingOutput where Transformer.DecodingInput: Decodable {
      try transformer.decode(input: try decode(Transformer.DecodingInput.self, forKey: key))
   }
   /**
    * For optional?
    * - Parameters:
    *   - key: - Fixme: ⚠️️ add doc
    *   - transformer: - Fixme: ⚠️️ add doc
    * - Returns: - Fixme: ⚠️️ add doc
    */
   public func decodeIfPresent<Transformer: DecodingContainerTransformer>(key: Key, transformer: Transformer) throws -> Transformer.DecodingOutput? where Transformer.DecodingInput: Decodable {
      try decodeIfPresent(Transformer.DecodingInput.self, forKey: key).map(transformer.decode)
   }
}
