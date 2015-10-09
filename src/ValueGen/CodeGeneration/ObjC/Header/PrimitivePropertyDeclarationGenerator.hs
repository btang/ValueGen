module ValueGen.CodeGeneration.ObjC.Header.PrimitivePropertyDeclarationGenerator where

import Text.Printf

import ValueGen.Model.PrimitiveProperty

generatePrimitivePropertyDeclaration :: PrimitiveProperty -> String
generatePrimitivePropertyDeclaration primitiveProperty =
  printf "@property (nonatomic, readonly, assign) %s %s;" 
    (primitivePropertyType primitiveProperty) 
    (primitivePropertyName primitiveProperty)
