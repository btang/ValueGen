module ValueGen.Model.DeclarationStart where

import ValueGen.Model.ValueObjectExtension

data DeclarationStart = DeclarationStart {
  name :: String,
  extensions :: [ValueObjectExtension]
} deriving (Show, Eq)

declarationName (DeclarationStart name extensions) = name

declarationExtensions (DeclarationStart start extensions) = extensions
