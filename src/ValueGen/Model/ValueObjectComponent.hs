module ValueGen.Model.ValueObjectComponent where

import ValueGen.Model.Comment
import ValueGen.Model.DeclarationEnd
import ValueGen.Model.DeclarationStart
import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty

data ValueObjectComponent = 
  CommentComponent Comment |
  PrimitivePropertyComponent PrimitiveProperty |
  ObjectPropertyComponent ObjectProperty 
  deriving(Show, Eq)

commentComponentValue (CommentComponent comment) = comment

primitivePropertyComponentValue (PrimitivePropertyComponent primitiveProperty) = primitiveProperty

objectPropertyComponentValue (ObjectPropertyComponent objectProperty) = objectProperty
