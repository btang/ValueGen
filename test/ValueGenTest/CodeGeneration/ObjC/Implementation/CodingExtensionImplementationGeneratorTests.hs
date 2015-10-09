module ValueGenTest.CodeGeneration.ObjC.Implementation.CodingExtensionImplementationGeneratorTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import ValueGen.CodeGeneration.ObjC.Implementation.CodingExtensionImplementationGenerator

import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectComponent

import ValueGenTest.Utils.ValueObjectTemplates

tests = testGroup "CodingExtensionImplementationGenerator tests" [
  testGenerateCodingExtensionImplementationForValueObjectWithOnePrimitiveProperty,
  testGenerateCodingExtensionImplementationForValueObjectWithOneObjectProperty,
  testGenerateCodingExtensionImplementationForValueObjectWithMixedProperties,
  testGenerateCodingExtensionImplementationForValueObjectWithMixedPrimitivePropertyTypes
  ]

expectedCodingExtensionImplementationForValueObjectWithOnePrimitiveProperty = [
  "#pragma mark - NSCoding",
  "",
  "- (instancetype)initWithCoder:(NSCoder *)aDecoder {",
  "  self = [super init];",
  "  if (self) {",
  "    _someInt = [aDecoder decodeIntegerForKey:@\"someInt\"];",
  "  }",
  "  return self;",
  "}",
  "",
  "- (void)encodeWithCoder:(NSCoder *)aCoder {",
  "  [aCoder encodeInteger:_someInt forKey:@\"someInt\"];",
  "}"
  ]

testGenerateCodingExtensionImplementationForValueObjectWithOnePrimitiveProperty = testCase "Test generating coding implementation for value object with one primitive property" (do
  assertEqual "Implementation should be equal" 
    expectedCodingExtensionImplementationForValueObjectWithOnePrimitiveProperty
    (generateCodingExtensionImplementation valueObjectWithOnePrimitiveProperty)
  )

expectedCodingExtensionImplementationForValueObjectWithOneObjectProperty = [
  "#pragma mark - NSCoding",
  "",
  "- (instancetype)initWithCoder:(NSCoder *)aDecoder {",
  "  self = [super init];",
  "  if (self) {",
  "    _someString = [aDecoder decodeObjectForKey:@\"someString\"];",
  "  }",
  "  return self;",
  "}",
  "",
  "- (void)encodeWithCoder:(NSCoder *)aCoder {",
  "  [aCoder encodeObject:_someString forKey:@\"someString\"];",
  "}"
  ]

testGenerateCodingExtensionImplementationForValueObjectWithOneObjectProperty = testCase "Test generating coding implementation for value object with one object property" (do
  assertEqual "Implementation should be equal" 
    expectedCodingExtensionImplementationForValueObjectWithOneObjectProperty
    (generateCodingExtensionImplementation valueObjectWithOneObjectProperty)
  )

expectedCodingExtensionImplementationForValueObjectWithMixedProperties = [
  "#pragma mark - NSCoding",
  "",
  "- (instancetype)initWithCoder:(NSCoder *)aDecoder {",
  "  self = [super init];",
  "  if (self) {",
  "    _someString = [aDecoder decodeObjectForKey:@\"someString\"];",
  "    _someInt = [aDecoder decodeIntegerForKey:@\"someInt\"];",
  "  }",
  "  return self;",
  "}",
  "",
  "- (void)encodeWithCoder:(NSCoder *)aCoder {",
  "  [aCoder encodeObject:_someString forKey:@\"someString\"];",
  "  [aCoder encodeInteger:_someInt forKey:@\"someInt\"];",
  "}"
  ]

testGenerateCodingExtensionImplementationForValueObjectWithMixedProperties = testCase "Test generating coding implementation for value object with mixed properties" (do
  assertEqual "Implementation should be equal" 
    expectedCodingExtensionImplementationForValueObjectWithMixedProperties
    (generateCodingExtensionImplementation valueObjectWithMixedProperties)
  )

expectedCodingExtensionImplementationForValueObjectWithMixedPrimitivePropertyTypes = [
  "#pragma mark - NSCoding",
  "",
  "- (instancetype)initWithCoder:(NSCoder *)aDecoder {",
  "  self = [super init];",
  "  if (self) {",
  "    _someBool = [aDecoder decodeBoolForKey:@\"someBool\"];",
  "    _someDouble = [aDecoder decodeDoubleForKey:@\"someDouble\"];",
  "    _someFloat = [aDecoder decodeFloatForKey:@\"someFloat\"];",
  "    _someInt = [aDecoder decodeIntForKey:@\"someInt\"];",
  "    _someInt32 = [aDecoder decodeInt32ForKey:@\"someInt32\"];",
  "    _someInt64 = [aDecoder decodeInt64ForKey:@\"someInt64\"];",
  "    _someInteger = [aDecoder decodeIntegerForKey:@\"someInteger\"];",    
  "    _somePoint = [aDecoder decodePointForKey:@\"somePoint\"];",
  "    _someRect = [aDecoder decodeRectForKey:@\"someRect\"];",
  "    _someSize = [aDecoder decodeSizeForKey:@\"someSize\"];",
  "  }",
  "  return self;",
  "}",
  "",
  "- (void)encodeWithCoder:(NSCoder *)aCoder {",
  "  [aCoder encodeBool:_someBool forKey:@\"someBool\"];",
  "  [aCoder encodeDouble:_someDouble forKey:@\"someDouble\"];",
  "  [aCoder encodeFloat:_someFloat forKey:@\"someFloat\"];",
  "  [aCoder encodeInt:_someInt forKey:@\"someInt\"];",
  "  [aCoder encodeInt32:_someInt32 forKey:@\"someInt32\"];",
  "  [aCoder encodeInt64:_someInt64 forKey:@\"someInt64\"];",
  "  [aCoder encodeInteger:_someInteger forKey:@\"someInteger\"];",
  "  [aCoder encodePoint:_somePoint forKey:@\"somePoint\"];",
  "  [aCoder encodeRect:_someRect forKey:@\"someRect\"];",
  "  [aCoder encodeSize:_someSize forKey:@\"someSize\"];",  
  "}"
  ]

testGenerateCodingExtensionImplementationForValueObjectWithMixedPrimitivePropertyTypes = testCase "Test generating coding implementation for value object with mixed primitive properties" (do
  assertEqual "Implementation should be equal" 
    expectedCodingExtensionImplementationForValueObjectWithMixedPrimitivePropertyTypes
    (generateCodingExtensionImplementation valueObjectWithMixedPrimitivePropertyTypes)
  )
