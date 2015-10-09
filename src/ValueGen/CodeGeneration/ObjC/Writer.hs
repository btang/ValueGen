module ValueGen.CodeGeneration.ObjC.Writer where

import Data.List

import System.IO

import Text.Printf

import ValueGen.Model.ValueObject

import ValueGen.CodeGeneration.ObjC.Header.HeaderGenerator
import ValueGen.CodeGeneration.ObjC.Implementation.ImplementationGenerator

writeObjCFiles :: ValueObject -> IO ()
writeObjCFiles valueObject = do
  writeFile (_headerFilename valueObject) (_headerContent valueObject)
  writeFile (_implementationFilename valueObject) (_implementationContent valueObject)

_headerFilename :: ValueObject -> String
_headerFilename valueObject = printf "%s.h" (valueObjectName valueObject)

_headerContent :: ValueObject -> String
_headerContent valueObject = (intercalate "\n" (generateHeader valueObject))

_implementationFilename :: ValueObject -> String
_implementationFilename valueObject = printf "%s.m" (valueObjectName valueObject)

_implementationContent :: ValueObject -> String
_implementationContent valueObject = (intercalate "\n" (generateImplementation valueObject))
