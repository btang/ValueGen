module ValueGenTest.CodeGeneration.ObjC.Implementation.InitImplementationGeneratorTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import ValueGen.CodeGeneration.ObjC.Implementation.InitImplementationGenerator

import ValueGen.Model.Comment
import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectComponent

import ValueGenTest.Utils.ValueObjectTemplates

tests = testGroup "InitImplementationGenerator tests" [
  testGenerateInitImplementationForValueObjectWithOneObjectProperty,
  testGenerateInitImplementationForValueObjectWithOnePrimitiveProperty,
  testGenerateInitImplementationForValueObjectWithMixedProperties
  ]

expectedInitImplementationForValueObjectWithOneObjectProperty = [
  "- (instancetype)initWithSomeString:(NSString *)someString {",
  "  self = [super init];",
  "  if (self) {",
  "    _someString = [someString copy];",
  "  }",
  "  return self;",
  "}"
  ]

testGenerateInitImplementationForValueObjectWithOneObjectProperty = testCase "Test generating init implementation for a value object with one object property" (do
  assertEqual "Init implementations should be equal" 
    expectedInitImplementationForValueObjectWithOneObjectProperty
    (generateInitImplementation valueObjectWithOneObjectProperty)
  )

expectedInitImplementationForValueObjectWithOnePrimitiveProperty = [
  "- (instancetype)initWithSomeInt:(NSInteger)someInt {",
  "  self = [super init];",
  "  if (self) {",
  "    _someInt = someInt;",
  "  }",
  "  return self;",
  "}"
  ]

testGenerateInitImplementationForValueObjectWithOnePrimitiveProperty = testCase "Test generating init implementation for a value object with one primitive property" (do
  assertEqual "Init implementations should be equal" 
    expectedInitImplementationForValueObjectWithOnePrimitiveProperty
    (generateInitImplementation valueObjectWithOnePrimitiveProperty)
  )

expectedInitImplementationForValueObjectWithMixedProperties = [
  "- (instancetype)initWithSomeString:(NSString *)someString someInt:(NSInteger)someInt {",
  "  self = [super init];",
  "  if (self) {",
  "    _someString = [someString copy];",
  "    _someInt = someInt;",
  "  }",
  "  return self;",
  "}"
  ]

testGenerateInitImplementationForValueObjectWithMixedProperties = testCase "Test generating init implementation for a value object with mixed properties" (do
  assertEqual "Init implementations should be equal" 
    expectedInitImplementationForValueObjectWithMixedProperties
    (generateInitImplementation valueObjectWithMixedProperties)
  )
