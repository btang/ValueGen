module ValueGen.Parsing.ValueObjectParser where

import Data.Either

import Text.Parsec
import Text.Parsec.String

import ValueGen.Model.Comment
import ValueGen.Model.DeclarationEnd
import ValueGen.Model.DeclarationStart
import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectComponent

import ValueGen.Parsing.CommentParser
import ValueGen.Parsing.DeclarationEndParser
import ValueGen.Parsing.DeclarationStartParser
import ValueGen.Parsing.ImportParser
import ValueGen.Parsing.ValueObjectComponentParser

valueObjectParser :: Parser ValueObject
valueObjectParser = do
  many newline
  imports <- many importParser
  many newline
  comments <- many commentParser
  declarationStart <- declarationStartParser
  components <- many1 valueObjectComponentParser
  declarationEndParser
  return ValueObject {
    ValueGen.Model.ValueObject.name = (declarationName declarationStart),
    ValueGen.Model.ValueObject.extensions = (declarationExtensions declarationStart),
    imports = imports,
    comments = _commentsFromValueObjectComponents comments,
    components = components
  }

_commentsFromValueObjectComponents :: [ValueObjectComponent] -> [Comment]
_commentsFromValueObjectComponents valueObjectComponents = map (\voc -> commentComponentValue voc) valueObjectComponents
