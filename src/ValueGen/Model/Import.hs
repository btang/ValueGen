module ValueGen.Model.Import where

data Import = Import {
  library :: String,
  component :: String
} deriving (Show, Eq)

importLibrary (Import library component) = library

importComponent (Import library component) = component
