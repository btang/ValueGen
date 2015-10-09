module ValueGenTest.CodeGeneration.ObjC.Header.PrimitivePropertyDeclarationGeneratorTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import ValueGen.CodeGeneration.ObjC.Header.PrimitivePropertyDeclarationGenerator

import ValueGen.Model.PrimitiveProperty

tests = testGroup "PrimitivePropertyDeclarationGeneratorTests tests" [
  testGeneratePrimitivePropertyDeclaration
  ]

testGeneratePrimitivePropertyDeclaration = testCase "Test generating a standard primitive property" (do
  assertEqual "Primitive property should be equal" 
    "@property (nonatomic, readonly, assign) NSUInteger someInt;"
    (generatePrimitivePropertyDeclaration (PrimitiveProperty {primitiveType = "NSUInteger", name = "someInt"}))
  )
