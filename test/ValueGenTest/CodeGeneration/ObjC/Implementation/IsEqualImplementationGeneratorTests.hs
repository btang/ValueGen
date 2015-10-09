module ValueGenTest.CodeGeneration.ObjC.Implementation.IsEqualImplementationGeneratorTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import Text.Printf

import ValueGen.CodeGeneration.ObjC.Implementation.IsEqualImplementationGenerator

import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectComponent

import ValueGenTest.Utils.ValueObjectTemplates

tests = testGroup "IsEqualImplementationGenerator tests" [
  testGenerateIsEqualImplementationForValueObjectWithOnePrimitiveProperty,
  testGenerateIsEqualImplementationForValueObjectWithOneObjectProperty,
  testGenerateIsEqualImplementationForValueObjectWithMixedProperties
  ]

expectedIsEqualImplementationForValueObjectWithOnePrimitiveProperty = [
  "- (BOOL)isEqual:(id)obj {",
  "  if(![obj isKindOfClass:[MyObject class]]) {",
  "    return NO;",
  "  }",
  "",
  "  MyObject *other = (MyObject *)obj;",
  "",
  "  BOOL someIntIsEqual = self.someInt == other.someInt;",
  "",
  "  return someIntIsEqual;",
  "}"
  ]

testGenerateIsEqualImplementationForValueObjectWithOnePrimitiveProperty = testCase "Test generating coding implementation for a value object with one primitive property" (do
  assertEqual "Implementation should be equal" 
    expectedIsEqualImplementationForValueObjectWithOnePrimitiveProperty
    (generateIsEqualImplementation valueObjectWithOnePrimitiveProperty)
  )

expectedIsEqualImplementationForValueObjectWithOneObjectProperty = [
  "- (BOOL)isEqual:(id)obj {",
  "  if(![obj isKindOfClass:[MyObject class]]) {",
  "    return NO;",
  "  }",
  "",
  "  MyObject *other = (MyObject *)obj;",
  "",
  "  BOOL someStringIsEqual = self.someString == other.someString || [self.someString isEqual:other.someString];",
  "",
  "  return someStringIsEqual;",
  "}"
  ]

testGenerateIsEqualImplementationForValueObjectWithOneObjectProperty = testCase "Test generating coding implementation for a value object with one object property" (do
  assertEqual "Implementation should be equal" 
    expectedIsEqualImplementationForValueObjectWithOneObjectProperty
    (generateIsEqualImplementation valueObjectWithOneObjectProperty)
  )

expectedIsEqualImplementationForValueObjectWithMixedProperties = [
  "- (BOOL)isEqual:(id)obj {",
  "  if(![obj isKindOfClass:[MyObject class]]) {",
  "    return NO;",
  "  }",
  "",
  "  MyObject *other = (MyObject *)obj;",
  "",
  "  BOOL someStringIsEqual = self.someString == other.someString || [self.someString isEqual:other.someString];",
  "  BOOL someIntIsEqual = self.someInt == other.someInt;",
  "",
  "  return someStringIsEqual && someIntIsEqual;",
  "}"
  ]

testGenerateIsEqualImplementationForValueObjectWithMixedProperties = testCase "Test generating coding implementation for a value object with mixed properties" (do
  assertEqual "Implementation should be equal" 
    expectedIsEqualImplementationForValueObjectWithMixedProperties
    (generateIsEqualImplementation valueObjectWithMixedProperties)
  )
