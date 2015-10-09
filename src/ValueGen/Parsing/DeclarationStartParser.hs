module ValueGen.Parsing.DeclarationStartParser where

import Data.List.Split

import Data.String.Utils

import Text.Parsec
import Text.Parsec.String

import ValueGen.Model.DeclarationStart
import ValueGen.Model.ValueObjectExtension

-- MyObject {
declarationStartParser :: Parser DeclarationStart
declarationStartParser = do
  spaces
  name <- many1 letter
  spaces
  extensions <- option [] _valueObjectExtensionParser
  spaces
  char '{'
  newline
  return DeclarationStart {name = name, extensions = extensions}

_valueObjectExtensionParser :: Parser [ValueObjectExtension]
_valueObjectExtensionParser = do
  char '('
  extensions <- many (noneOf ")")
  char ')'
  return (map _stringToValueObjectExtension (map strip (splitOn "," extensions)))

_stringToValueObjectExtension :: String -> ValueObjectExtension
_stringToValueObjectExtension string =
  case string of
    "Copying" -> Copying
    "Coding" -> Coding
    _ -> InvalidExtension