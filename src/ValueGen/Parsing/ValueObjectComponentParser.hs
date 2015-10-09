module ValueGen.Parsing.ValueObjectComponentParser where

import Text.Parsec
import Text.Parsec.String

import ValueGen.Model.ValueObjectComponent

import ValueGen.Parsing.CommentParser
import ValueGen.Parsing.ObjectPropertyParser
import ValueGen.Parsing.PrimitivePropertyParser

valueObjectComponentParser :: Parser ValueObjectComponent
valueObjectComponentParser = do
  valueObjectComponent <- 
    try commentParser 
    <|> try objectPropertyParser 
    <|> try primitivePropertyParser
  return valueObjectComponent