module ValueGenTest.CodeGeneration.ObjC.Implementation.HashImplementationGeneratorTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import Text.Printf

import ValueGen.CodeGeneration.ObjC.Implementation.HashImplementationGenerator

import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectComponent

import ValueGenTest.Utils.ValueObjectTemplates

tests = testGroup "HashImplementationGenerator tests" [
  testGenerateHashImplementationForValueObjectWithOnePrimitiveProperty,
  testGenerateHashImplementationForValueObjectWithOneObjectProperty,
  testGenerateHashImplementationForValueObjectWithMixedProperties
  ]

expectedHashImplementationForValueObjectWithOnePrimitiveProperty = [
  "- (NSUInteger)hash {",
  "  return self.someInt;",
  "}"
  ]

testGenerateHashImplementationForValueObjectWithOnePrimitiveProperty = testCase "Test generating hash implementation for value object with one primitive property" (do
  assertEqual "Implementation should be equal" 
    expectedHashImplementationForValueObjectWithOnePrimitiveProperty
    (generateHashImplementation valueObjectWithOnePrimitiveProperty)
  )

expectedHashImplementationForValueObjectWithOneObjectProperty = [
  "- (NSUInteger)hash {",
  "  return self.someString.hash;",
  "}"
  ]

testGenerateHashImplementationForValueObjectWithOneObjectProperty = testCase "Test generating hash implementation for value object with one object property" (do
  assertEqual "Implementation should be equal" 
    expectedHashImplementationForValueObjectWithOneObjectProperty
    (generateHashImplementation valueObjectWithOneObjectProperty)
  )

expectedHashImplementationForValueObjectWithMixedProperties = [
  "- (NSUInteger)hash {",
  "  return self.someString.hash ^ self.someInt;",
  "}"
  ]

testGenerateHashImplementationForValueObjectWithMixedProperties = testCase "Test generating hash implementation for value object with mixed properties" (do
  assertEqual "Implementation should be equal" 
    expectedHashImplementationForValueObjectWithMixedProperties
    (generateHashImplementation valueObjectWithMixedProperties)
  )
