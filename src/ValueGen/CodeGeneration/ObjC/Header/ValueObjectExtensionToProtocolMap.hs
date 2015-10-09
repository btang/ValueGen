module ValueGen.CodeGeneration.ObjC.Header.ValueObjectExtensionToProtocolMap where

import ValueGen.Model.ValueObjectExtension

protocolForValueObjectExtension :: ValueObjectExtension -> String
protocolForValueObjectExtension valueObjectExtension =
  case valueObjectExtension of
    Copying -> "NSCopying"
    Coding -> "NSCoding"
    _ -> ""
