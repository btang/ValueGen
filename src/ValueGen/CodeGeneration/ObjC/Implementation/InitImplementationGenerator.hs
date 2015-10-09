module ValueGen.CodeGeneration.ObjC.Implementation.InitImplementationGenerator where

import Data.List

import Text.Printf

import ValueGen.CodeGeneration.ObjC.Common.InitGenerator

import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectComponent

import ValueGen.Utils.PropertyUtils
import ValueGen.Utils.StringUtils 
import ValueGen.Utils.ValueObjectComponentFilters

generateInitImplementation :: ValueObject -> [String]
generateInitImplementation valueObject = 
  concat [
    _generateInitDefinitionStart valueObject,
    ["  self = [super init];"],
    ["  if (self) {"],
    (map (\x -> (indent x 2)) (_generatePropertyAssignments valueObject)),
    ["  }"],
    ["  return self;"],
    ["}"]
  ]

_generateInitDefinitionStart :: ValueObject -> [String]
_generateInitDefinitionStart valueObject = [concat [generateInit valueObject, " {"]]

_generatePropertyAssignments :: ValueObject -> [String]
_generatePropertyAssignments valueObject = 
  map 
    _generatePropertyAssignment 
    (filterOutComments (valueObjectComponents valueObject))

_generatePropertyAssignment :: ValueObjectComponent -> String
_generatePropertyAssignment valueObjectComponent =
  case valueObjectComponent of
    CommentComponent commentComponent -> []
    ObjectPropertyComponent objectPropertyComponent -> 
      printf "%s = [%s copy];" 
        (underscoredPropertyName valueObjectComponent)
        (propertyName valueObjectComponent)
    PrimitivePropertyComponent primitivePropertyComponent -> 
      printf "%s = %s;" 
        (underscoredPropertyName valueObjectComponent)
        (propertyName valueObjectComponent)
