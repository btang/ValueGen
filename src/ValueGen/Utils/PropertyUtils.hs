module ValueGen.Utils.PropertyUtils where

import Text.Printf

import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObjectComponent

propertyName :: ValueObjectComponent -> String
propertyName valueObjectComponent =
  case valueObjectComponent of
    PrimitivePropertyComponent primitivePropertyComponent -> primitivePropertyName primitivePropertyComponent
    ObjectPropertyComponent objectPropertyComponent -> objectPropertyName objectPropertyComponent
    _ -> ""

underscoredPropertyName :: ValueObjectComponent -> String
underscoredPropertyName valueObjectComponent = printf "_%s" (propertyName valueObjectComponent)
