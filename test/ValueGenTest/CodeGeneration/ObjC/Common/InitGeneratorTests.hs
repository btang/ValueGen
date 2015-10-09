module ValueGenTest.CodeGeneration.ObjC.Common.InitGeneratorTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import ValueGen.CodeGeneration.ObjC.Common.InitGenerator

import ValueGen.Model.Comment
import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectComponent

import ValueGenTest.Utils.ValueObjectTemplates

tests = testGroup "InitGenerator tests" [
  testGenerateInterfaceDeclarationForValueObjectWithOneObjectProperty,
  testGenerateInterfaceDeclarationForValueObjectWithOnePrimitiveProperty,
  testGenerateInterfaceDeclarationForValueObjectWithMixedProperties
  ]

testGenerateInterfaceDeclarationForValueObjectWithOneObjectProperty = testCase "Test generating init for a value object with one object property" (do
  assertEqual "Init should be equal" 
    "- (instancetype)initWithSomeString:(NSString *)someString"
    (generateInit valueObjectWithOneObjectProperty)
  )

testGenerateInterfaceDeclarationForValueObjectWithOnePrimitiveProperty = testCase "Test generating init for a value object with one primitive property" (do
  assertEqual "Init should be equal" 
    "- (instancetype)initWithSomeInt:(NSInteger)someInt"
    (generateInit valueObjectWithOnePrimitiveProperty)
  )

testGenerateInterfaceDeclarationForValueObjectWithMixedProperties = testCase "Test generating init for a value object with mixed properties" (do
  assertEqual "Init should be equal" 
    "- (instancetype)initWithSomeString:(NSString *)someString someInt:(NSInteger)someInt"
    (generateInit valueObjectWithMixedProperties)
  )


