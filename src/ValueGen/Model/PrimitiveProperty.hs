module ValueGen.Model.PrimitiveProperty where

data PrimitiveProperty = PrimitiveProperty {
  primitiveType :: String,
  name :: String
} deriving (Show, Eq)

primitivePropertyType (PrimitiveProperty primitiveType name) = primitiveType

primitivePropertyName (PrimitiveProperty primitiveType name) = name
