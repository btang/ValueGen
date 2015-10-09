module ValueGen.Parsing.ImportParser where

import Text.Parsec
import Text.Parsec.String

import ValueGen.Model.Import

-- %import library=SomeLibrary component=SomeComponent
importParser :: Parser Import
importParser = do
  string "%import"
  spaces
  string "library="
  library <- many letter
  spaces
  string "component="
  component <- many1 (noneOf "\n")
  newline
  return (Import {library = library, component = component})
