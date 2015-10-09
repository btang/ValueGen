module ValueGen.Model.Property where

import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty

data Property = Primitive PrimitiveProperty | Object ObjectProperty deriving(Show)

primitivePropertyValue (Primitive primitiveProperty) = primitiveProperty

objectPropertyValue (Object objectProperty) = objectProperty
