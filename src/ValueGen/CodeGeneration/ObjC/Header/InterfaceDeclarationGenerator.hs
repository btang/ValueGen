module ValueGen.CodeGeneration.ObjC.Header.InterfaceDeclarationGenerator where

import Data.List

import Text.Printf

import ValueGen.CodeGeneration.ObjC.Common.CommentGenerator
import ValueGen.CodeGeneration.ObjC.Common.InitGenerator
import ValueGen.CodeGeneration.ObjC.Header.ObjectPropertyDeclarationGenerator
import ValueGen.CodeGeneration.ObjC.Header.PrimitivePropertyDeclarationGenerator
import ValueGen.CodeGeneration.ObjC.Header.ProtocolConformanceGenerator

import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectComponent

generateInterfaceDeclaration :: ValueObject -> [String]
generateInterfaceDeclaration valueObject = 
  concat (
    intersperse [""] 
      [
        _interfaceStartStrings valueObject, 
        _valueObjectComponentStrings valueObject, 
        _initStrings valueObject, 
        _interfaceEndStrings
      ]
  )

_interfaceStartStrings :: ValueObject -> [String]
_interfaceStartStrings valueObject = 
  [
    printf "@interface %s : NSObject%s" 
      (valueObjectName valueObject) 
      (_prependSpaceIfStringIsNotEmpty (generateProtocolConformance valueObject))
  ]

_prependSpaceIfStringIsNotEmpty :: String -> String
_prependSpaceIfStringIsNotEmpty string =
  case string of
    "" -> ""
    s -> printf " %s" string

_valueObjectComponentStrings :: ValueObject -> [String]
_valueObjectComponentStrings valueObject = 
  map 
    _forwardValueObjectComponentGenerator 
    (valueObjectComponents valueObject)

_initStrings :: ValueObject -> [String]
_initStrings valueObject = [concat [(generateInit valueObject), ";"]]

_interfaceEndStrings :: [String]
_interfaceEndStrings = ["@end"]

_forwardValueObjectComponentGenerator :: ValueObjectComponent -> String
_forwardValueObjectComponentGenerator valueObjectComponent =
  case valueObjectComponent of
    CommentComponent commentComponent -> generateComment commentComponent
    ObjectPropertyComponent objectPropertyComponent -> generateObjectPropertyDeclaration (objectPropertyComponentValue valueObjectComponent)
    PrimitivePropertyComponent primitivePropertyComponent -> generatePrimitivePropertyDeclaration (primitivePropertyComponentValue valueObjectComponent)
