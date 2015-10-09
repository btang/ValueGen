module ValueGen.CodeGeneration.ObjC.Implementation.HashImplementationGenerator where

import Data.List

import Text.Printf

import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectComponent

import ValueGen.Utils.PropertyUtils
import ValueGen.Utils.ValueObjectComponentFilters

generateHashImplementation :: ValueObject -> [String]
generateHashImplementation valueObject = 
  concat [
    ["- (NSUInteger)hash {"],
    _generateReturn valueObject,
    ["}"]
  ]

_generateReturn :: ValueObject -> [String]
_generateReturn valueObject = [
  printf "  return %s;" 
    (concat 
      (intersperse " ^ " 
        (map 
          _generatePropertyHash 
          (filterOutComments (valueObjectComponents valueObject)))))
  ]

_generatePropertyHash :: ValueObjectComponent -> String
_generatePropertyHash valueObjectComponent =
  case valueObjectComponent of
    PrimitivePropertyComponent primitivePropertyComponent -> 
      printf "self.%s" (propertyName valueObjectComponent)
    ObjectPropertyComponent objectPropertyComponent -> 
      printf "self.%s.hash" (propertyName valueObjectComponent)
    _ -> ""
