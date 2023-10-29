import Foundation
/**
 * Protocol for decoding container transformers
 */
public protocol DecodingContainerTransformer {
   associatedtype DecodingInput
   associatedtype DecodingOutput
   func decode(input: DecodingInput) throws -> DecodingOutput
}
/**
 * Extension for KeyedDecodingContainer to add decoding methods with transformers
 */
extension KeyedDecodingContainer {
   /**
    * Decode a value with a transformer
    * - Parameters:
    *   - key: The key to decode
    *   - transformer: The transformer to use for decoding
    * - Returns: The decoded value
    * - Throws: An error if the decoding fails
    */
   public func decode<Transformer: DecodingContainerTransformer>(key: Key, transformer: Transformer) throws -> Transformer.DecodingOutput where Transformer.DecodingInput: Decodable {
      // Decode the value with the specified key to the input type of the transformer
      let input: Transformer.DecodingInput = try decode(Transformer.DecodingInput.self, forKey: key)
      // Use the transformer to decode the input value to the output type
      return try transformer.decode(input: input)
   }
   /**
    * Decode an optional value with a transformer
    * - Parameters:
    *   - key: The key to decode
    *   - transformer: The transformer to use for decoding
    * - Returns: The decoded optional value, or nil if the value is not present
    * - Throws: An error if the decoding fails
    */
   public func decodeIfPresent<Transformer: DecodingContainerTransformer>(key: Key, transformer: Transformer) throws -> Transformer.DecodingOutput? where Transformer.DecodingInput: Decodable {
      // Decode the optional value with the specified key to the input type of the transformer
      if let input: Transformer.DecodingInput = try decodeIfPresent(Transformer.DecodingInput.self, forKey: key) {
         // Use the transformer to decode the input value to the output type
         return try transformer.decode(input: input)
      } else {
         return nil
      }
   }
}
