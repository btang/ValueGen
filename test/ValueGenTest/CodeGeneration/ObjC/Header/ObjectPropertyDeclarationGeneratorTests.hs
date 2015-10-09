module ValueGenTest.CodeGeneration.ObjC.Header.ObjectPropertyDeclarationGeneratorTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import ValueGen.CodeGeneration.ObjC.Header.ObjectPropertyDeclarationGenerator

import ValueGen.Model.ObjectProperty

tests = testGroup "ObjectPropertyDeclarationGenerator tests" [
  testGenerateObjectPropertyDeclaration
  ]

testGenerateObjectPropertyDeclaration = testCase "Test generating a standard object property" (do
  assertEqual "Object property should be equal" 
    "@property (nonatomic, readonly, strong) NSString *myString;"
    (generateObjectPropertyDeclaration (ObjectProperty {objectType = "NSString", name = "myString"}))
  )
