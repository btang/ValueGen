module ValueGen.CodeGeneration.ObjC.Header.HeaderGenerator where

import Data.List

import Text.Printf

import ValueGen.CodeGeneration.ObjC.Common.CommentGenerator
import ValueGen.CodeGeneration.ObjC.Header.ImportGenerator
import ValueGen.CodeGeneration.ObjC.Header.InterfaceDeclarationGenerator

import ValueGen.Model.ValueObject

generateHeader :: ValueObject -> [String]
generateHeader valueObject = 
  concat [
    _generateHeaderInfo valueObject,
    [""],
    _generateObjectImports valueObject,
    _newlineIfImportsExist valueObject,
    _generateObjectComments valueObject,
    generateInterfaceDeclaration valueObject
  ]

_generateHeaderInfo :: ValueObject -> [String]
_generateHeaderInfo valueObject = 
  concat [
    ["//"],
    [(printf "// %s.h" (valueObjectName valueObject))],
    ["// Generated by ValueGen"],
    ["//"],
    [""],
    ["#import <Foundation/Foundation.h>"]
  ]

_generateObjectImports :: ValueObject -> [String]
_generateObjectImports valueObject = map generateImport (valueObjectImports valueObject)

_newlineIfImportsExist :: ValueObject -> [String]
_newlineIfImportsExist valueObject =
  case (valueObjectImports valueObject) of
    [] -> []
    (x:_) -> [""]

_generateObjectComments :: ValueObject -> [String]
_generateObjectComments valueObject = map generateComment (valueObjectComments valueObject)