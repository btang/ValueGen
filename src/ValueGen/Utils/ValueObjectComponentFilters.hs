module ValueGen.Utils.ValueObjectComponentFilters where

import ValueGen.Model.ValueObjectComponent

filterOutComments :: [ValueObjectComponent] -> [ValueObjectComponent]
filterOutComments valueObjectComponents = filter _isNotComment valueObjectComponents

_isNotComment :: ValueObjectComponent -> Bool
_isNotComment valueObjectComponent =
  case valueObjectComponent of
    CommentComponent commentComponent -> False
    ObjectPropertyComponent objectPropertyComponent -> True
    PrimitivePropertyComponent primitivePropertyComponent -> True
