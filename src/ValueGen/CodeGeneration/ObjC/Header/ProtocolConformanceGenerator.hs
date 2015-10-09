module ValueGen.CodeGeneration.ObjC.Header.ProtocolConformanceGenerator where

import Data.List

import Text.Printf

import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectExtension

import ValueGen.CodeGeneration.ObjC.Header.ValueObjectExtensionToProtocolMap

generateProtocolConformance :: ValueObject -> String
generateProtocolConformance valueObject =
  case (valueObjectExtensions valueObject) of
    (x:xs) -> printf "<%s>" (_generateProtocolConformanceForExtensions (x:xs))
    [] -> ""

_generateProtocolConformanceForExtensions :: [ValueObjectExtension] -> String
_generateProtocolConformanceForExtensions valueObjectExtensions = 
  concat (
    intersperse ", " 
      (map protocolForValueObjectExtension valueObjectExtensions)
  )
