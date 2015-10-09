module ValueGen.Model.ValueObject where

import ValueGen.Model.Comment
import ValueGen.Model.Import
import ValueGen.Model.ValueObjectComponent
import ValueGen.Model.ValueObjectExtension

data ValueObject = ValueObject {
  name :: String,
  extensions :: [ValueObjectExtension],
  imports :: [Import],
  comments :: [Comment],  
  components :: [ValueObjectComponent]
} deriving (Show, Eq)

valueObjectName (ValueObject name extensions imports comments components) = name

valueObjectExtensions (ValueObject name extensions imports comments components) = extensions

valueObjectComments (ValueObject name extensions imports comments components) = comments

valueObjectImports (ValueObject name extensions imports comments components) = imports

valueObjectComponents (ValueObject name extensions imports comments components) = components
