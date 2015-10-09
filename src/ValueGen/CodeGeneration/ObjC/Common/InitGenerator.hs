module ValueGen.CodeGeneration.ObjC.Common.InitGenerator where

import Data.Char

import Text.Printf

import ValueGen.Model.Comment
import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectComponent

import ValueGen.Utils.ValueObjectComponentFilters

generateInit :: ValueObject -> String
generateInit valueObject = 
  concat [
    _generateInitWithFirstParameter valueObject,
    _generateParametersFromProperties (tail (filterOutComments (valueObjectComponents valueObject)))
  ]

_generateInitWithFirstParameter :: ValueObject -> String
_generateInitWithFirstParameter valueObject = 
  printf "- (instancetype)initWith%s" 
    (_generateFirstParameter (_firstProperty valueObject))

_generateFirstParameter :: ValueObjectComponent -> String
_generateFirstParameter valueObjectComponent =
  case valueObjectComponent of
    CommentComponent commentComponent -> ""
    ObjectPropertyComponent objectPropertyComponent -> 
      _generateParameter 
        (_capitalize (objectPropertyName objectPropertyComponent)) 
        (printf "%s *" (objectPropertyType objectPropertyComponent)) 
        (objectPropertyName objectPropertyComponent)
    PrimitivePropertyComponent primitivePropertyComponent -> 
      _generateParameter 
        (_capitalize (primitivePropertyName primitivePropertyComponent)) 
        (primitivePropertyType primitivePropertyComponent) 
        (primitivePropertyName primitivePropertyComponent)

_firstProperty :: ValueObject -> ValueObjectComponent
_firstProperty valueObject = (head (filterOutComments (valueObjectComponents valueObject)))

_generateParametersFromProperties :: [ValueObjectComponent] -> String
_generateParametersFromProperties (head:tail) = 
  concat [
    " ", 
    (_generateParameterFromProperty head), 
    (_generateParametersFromProperties tail)
  ]
_generateParametersFromProperties [] = ""

_generateParameterFromProperty :: ValueObjectComponent -> String
_generateParameterFromProperty valueObjectComponent =
  case valueObjectComponent of
    CommentComponent commentComponent -> ""
    ObjectPropertyComponent objectPropertyComponent -> 
      _generateParameter 
        (objectPropertyName objectPropertyComponent) 
        (printf "%s *" (objectPropertyType objectPropertyComponent)) 
        (objectPropertyName objectPropertyComponent)
    PrimitivePropertyComponent primitivePropertyComponent -> 
      _generateParameter 
        (primitivePropertyName primitivePropertyComponent) 
        (primitivePropertyType primitivePropertyComponent) 
        (primitivePropertyName primitivePropertyComponent)

_generateParameter :: String -> String -> String -> String
_generateParameter parameterName typeString argumentName =
  printf "%s:(%s)%s" 
    parameterName 
    typeString 
    argumentName

_capitalize :: String -> String
_capitalize (head:tail) = Data.Char.toUpper head : tail
_capitalize [] = []