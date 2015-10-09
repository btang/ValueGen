module ValueGen.Model.ObjectProperty where

data ObjectProperty = ObjectProperty {
  objectType :: String,
  name :: String
} deriving (Show, Eq)

objectPropertyType (ObjectProperty objectType name) = objectType

objectPropertyName (ObjectProperty objectType name) = name