module ValueGen.CodeGeneration.ObjC.Implementation.ExtensionImplementationGenerator where

import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectExtension

import ValueGen.CodeGeneration.ObjC.Implementation.CodingExtensionImplementationGenerator
import ValueGen.CodeGeneration.ObjC.Implementation.CopyingExtensionImplementationGenerator

generateExtensionImplementation :: ValueObject -> ValueObjectExtension -> [String]
generateExtensionImplementation valueObject valueObjectExtension =
  case valueObjectExtension of
    Copying -> generateCopyingExtensionImplementation valueObject
    Coding -> generateCodingExtensionImplementation valueObject
    _ -> []
