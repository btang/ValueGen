module ValueGen.Parsing.ObjectPropertyParser where

import Text.Parsec
import Text.Parsec.String

import ValueGen.Model.ObjectProperty
import ValueGen.Model.ValueObjectComponent

-- MyObject *foo
objectPropertyParser :: Parser ValueObjectComponent
objectPropertyParser = do
  spaces
  objectType <- many1 letter
  spaces
  char '*'
  name <- many1 (noneOf "\n ")
  newline
  return (ObjectPropertyComponent ObjectProperty {objectType = objectType, name = name})
