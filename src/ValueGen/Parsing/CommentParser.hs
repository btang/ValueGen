module ValueGen.Parsing.CommentParser where

import Text.Parsec
import Text.Parsec.String

import ValueGen.Model.Comment
import ValueGen.Model.ValueObjectComponent

-- # some comment
commentParser :: Parser ValueObjectComponent
commentParser = do
  spaces
  char '#'
  commentText <- many1 (noneOf "\n")
  newline
  return (CommentComponent Comment {text = commentText})
