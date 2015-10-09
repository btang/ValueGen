module ValueGen.Parsing.PrimitivePropertyParser where

import Text.Parsec
import Text.Parsec.String

import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObjectComponent

-- NSUInteger foo
primitivePropertyParser :: Parser ValueObjectComponent
primitivePropertyParser = do
  spaces
  primitiveType <- many1 letter
  spaces
  name <- many1 (noneOf "\n* ")
  newline
  return (PrimitivePropertyComponent PrimitiveProperty {primitiveType = primitiveType, name = name})
