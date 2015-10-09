module ValueGen.CodeGeneration.ObjC.Implementation.IsEqualImplementationGenerator where

import Data.List

import Text.Printf

import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectComponent

import ValueGen.Utils.PropertyUtils
import ValueGen.Utils.ValueObjectComponentFilters

generateIsEqualImplementation :: ValueObject -> [String]
generateIsEqualImplementation valueObject = 
  concat [
    ["- (BOOL)isEqual:(id)obj {"],
    [printf "  if(![obj isKindOfClass:[%s class]]) {" (valueObjectName valueObject)],
    ["    return NO;"],
    ["  }"],
    [""],
    _generateOtherVariable valueObject,
    [""],
    _generatePropertyEqualityChecks valueObject,
    [""],
    _generateReturn valueObject,
    ["}"]
  ]

_generateOtherVariable :: ValueObject -> [String]
_generateOtherVariable valueObject = 
  [
    printf "  %s *other = (%s *)obj;" 
    (valueObjectName valueObject) 
    (valueObjectName valueObject)
  ]

_generatePropertyEqualityChecks :: ValueObject -> [String]
_generatePropertyEqualityChecks valueObject = 
  map 
    _generatePropertyEqualityCheck 
    (filterOutComments (valueObjectComponents valueObject))

_generatePropertyEqualityCheck :: ValueObjectComponent -> String
_generatePropertyEqualityCheck valueObjectComponent =
  case valueObjectComponent of
    PrimitivePropertyComponent primitivePropertyComponent -> 
      printf "  BOOL %s = %s;" 
        (_isEqualVariableForComponent valueObjectComponent)
        (_generateDirectEqualityCheck valueObjectComponent)
    ObjectPropertyComponent objectPropertyComponent -> 
      printf "  BOOL %s = %s || %s;" 
        (_isEqualVariableForComponent valueObjectComponent)
        (_generateDirectEqualityCheck valueObjectComponent) 
        (_generateObjectEqualityCheck valueObjectComponent)
    _ -> ""

_generateDirectEqualityCheck :: ValueObjectComponent -> String
_generateDirectEqualityCheck valueObjectComponent =
  printf "self.%s == other.%s" 
    (propertyName valueObjectComponent)
    (propertyName valueObjectComponent)

_generateObjectEqualityCheck :: ValueObjectComponent -> String
_generateObjectEqualityCheck valueObjectComponent =
  case valueObjectComponent of
    PrimitivePropertyComponent primitivePropertyComponent -> ""
    ObjectPropertyComponent objectPropertyComponent ->
      printf "[self.%s isEqual:other.%s]"
        (objectPropertyName objectPropertyComponent)
        (objectPropertyName objectPropertyComponent)
    _ -> ""

_generateReturn :: ValueObject -> [String]
_generateReturn valueObject = [
  printf "  return %s;" 
    (concat 
      (intersperse " && " 
        (map 
          _isEqualVariableForComponent 
          (filterOutComments (valueObjectComponents valueObject)))))
  ]

_isEqualVariableForComponent :: ValueObjectComponent -> String
_isEqualVariableForComponent valueObjectComponent =
  case valueObjectComponent of
    PrimitivePropertyComponent primitivePropertyComponent -> printf "%sIsEqual" (primitivePropertyName primitivePropertyComponent)
    ObjectPropertyComponent objectPropertyComponent -> printf "%sIsEqual" (objectPropertyName objectPropertyComponent)
    _ -> ""
