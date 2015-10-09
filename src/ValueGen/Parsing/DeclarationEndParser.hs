module ValueGen.Parsing.DeclarationEndParser where

import Text.Parsec
import Text.Parsec.String

import ValueGen.Model.DeclarationEnd

-- }
declarationEndParser :: Parser DeclarationEnd
declarationEndParser = do
  char '}'
  newline
  return DeclarationEnd
