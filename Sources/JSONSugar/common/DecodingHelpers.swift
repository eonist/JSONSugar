import Foundation
/**
 * Protocol for decoding container transformers
 * - Description: This protocol defines a blueprint for transforming a decoding container. It requires a type for the input and output of the decoding process, and a method to perform the decoding.
 * - Note: This protocol is designed to be implemented by types that need to transform data during the decoding process. It provides a flexible mechanism to convert raw decoded data into a more suitable format or type, which can be particularly useful in scenarios where the data structure in the JSON does not directly map to the desired data structure in the application.
 */
public protocol DecodingContainerTransformer {
   associatedtype DecodingInput // Defines an associated type for the input of the decoding process
   associatedtype DecodingOutput // Defines an associated type for the output of the decoding process
   func decode(input: DecodingInput) throws -> DecodingOutput // Defines a method to decode the input into the output type
}
/**
 * Extension for KeyedDecodingContainer to add decoding methods with transformers
 * - Description: This extension adds methods to KeyedDecodingContainer that enable decoding values using transformers. The transformers allow for custom conversion of decoded values into desired output types. This is particularly useful when the raw decoded data needs to be transformed into a different format or type before use.
 */
extension KeyedDecodingContainer {
   /**
    * Decode a value with a transformer
    * - Description: This method allows you to decode a value with a transformer. It takes a key and a transformer as parameters. The key is used to decode the value from the container, and the transformer is used to transform the decoded value into the desired output type.
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
      if let input: Transformer.DecodingInput = try decodeIfPresent(
         Transformer.DecodingInput.self, // Specify the type of the input for the transformer
         forKey: key // Specify the key to decode the value from the container
      ) {
         // Use the transformer to decode the input value to the output type
         return try transformer.decode(input: input)
      } else {
         return nil
      }
   }
}
