module ValueGen.CodeGeneration.ObjC.Header.ObjectPropertyDeclarationGenerator where

import Text.Printf

import ValueGen.Model.ObjectProperty

generateObjectPropertyDeclaration :: ObjectProperty -> String
generateObjectPropertyDeclaration objectProperty =
  printf "@property (nonatomic, readonly, strong) %s *%s;" 
    (objectPropertyType objectProperty) 
    (objectPropertyName objectProperty)
