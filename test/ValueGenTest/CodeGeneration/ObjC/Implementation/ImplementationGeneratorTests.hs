module ValueGenTest.CodeGeneration.ObjC.Implementation.ImplementationGeneratorTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import ValueGen.CodeGeneration.ObjC.Implementation.ImplementationGenerator

import ValueGen.Model.Comment
import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectComponent
import ValueGen.Model.ValueObjectExtension

import ValueGenTest.Utils.ValueObjectTemplates

tests = testGroup "ImplementationGeneratorTests tests" [
  testGenerateImplementationForValueObjectWithNoExtensions,
  testGenerateImplementationForValueObjectWithCopyingExtension,
  testGenerateImplementationForValueObjectWithCodingExtension,
  testGenerateImplementationForValueObjectWithCopyingAndCodingExtensions
  ]

expectedImplementationForValueObjectWithNoExtensions = [
  "//",
  "// MyObject.m",
  "// Generated by ValueGen",
  "//",
  "",
  "#import \"MyObject.h\"",
  "",
  "@implementation MyObject",
  "",
  "- (instancetype)initWithSomeString:(NSString *)someString someInt:(NSInteger)someInt {",
  "  self = [super init];",
  "  if (self) {",
  "    _someString = [someString copy];",
  "    _someInt = someInt;",
  "  }",
  "  return self;",
  "}",
  "",
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
  "}",
  "",
  "- (NSUInteger)hash {",
  "  return self.someString.hash ^ self.someInt;",
  "}",
  "",  
  "@end"
  ]

testGenerateImplementationForValueObjectWithNoExtensions = testCase "Test generating implementation for a value object with no extensions" (do
  assertEqual "Implementations should be equal" 
    expectedImplementationForValueObjectWithNoExtensions
    (generateImplementation (valueObjectWithMixedPropertiesAndExtensions []))
  )

expectedImplementationForValueObjectWithCopyingExtension = [
  "//",
  "// MyObject.m",
  "// Generated by ValueGen",
  "//",
  "",
  "#import \"MyObject.h\"",
  "",
  "@implementation MyObject",
  "",
  "- (instancetype)initWithSomeString:(NSString *)someString someInt:(NSInteger)someInt {",
  "  self = [super init];",
  "  if (self) {",
  "    _someString = [someString copy];",
  "    _someInt = someInt;",
  "  }",
  "  return self;",
  "}",
  "",
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
  "}",
  "",
  "- (NSUInteger)hash {",
  "  return self.someString.hash ^ self.someInt;",
  "}",
  "",
  "#pragma mark - NSCopying",
  "",
  "- (instancetype)copyWithZone:(NSZone *)zone {",
  "  return self;",
  "}",
  "",
  "@end"
  ]

testGenerateImplementationForValueObjectWithCopyingExtension = testCase "Test generating implementation for a value object with Copying extension" (do
  assertEqual "Implementations should be equal" 
    expectedImplementationForValueObjectWithCopyingExtension
    (generateImplementation (valueObjectWithMixedPropertiesAndExtensions [Copying]))
  )

expectedImplementationForValueObjectWithCodingExtension = [
  "//",
  "// MyObject.m",
  "// Generated by ValueGen",
  "//",
  "",
  "#import \"MyObject.h\"",
  "",
  "@implementation MyObject",
  "",
  "- (instancetype)initWithSomeString:(NSString *)someString someInt:(NSInteger)someInt {",
  "  self = [super init];",
  "  if (self) {",
  "    _someString = [someString copy];",
  "    _someInt = someInt;",
  "  }",
  "  return self;",
  "}",
  "",
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
  "}",
  "",
  "- (NSUInteger)hash {",
  "  return self.someString.hash ^ self.someInt;",
  "}",
  "",
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
  "}",
  "",
  "@end"
  ]

testGenerateImplementationForValueObjectWithCodingExtension = testCase "Test generating implementation for a value object with Coding extension" (do
  assertEqual "Implementations should be equal" 
    expectedImplementationForValueObjectWithCodingExtension
    (generateImplementation (valueObjectWithMixedPropertiesAndExtensions [Coding]))
  )

expectedImplementationForValueObjectWithCopyingAndCodingExtensions = [
  "//",
  "// MyObject.m",
  "// Generated by ValueGen",
  "//",
  "",
  "#import \"MyObject.h\"",
  "",
  "@implementation MyObject",
  "",
  "- (instancetype)initWithSomeString:(NSString *)someString someInt:(NSInteger)someInt {",
  "  self = [super init];",
  "  if (self) {",
  "    _someString = [someString copy];",
  "    _someInt = someInt;",
  "  }",
  "  return self;",
  "}",
  "",
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
  "}",
  "",
  "- (NSUInteger)hash {",
  "  return self.someString.hash ^ self.someInt;",
  "}",
  "",
  "#pragma mark - NSCopying",
  "",  
  "- (instancetype)copyWithZone:(NSZone *)zone {",
  "  return self;",
  "}",
  "",
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
  "}",
  "",
  "@end"
  ]

testGenerateImplementationForValueObjectWithCopyingAndCodingExtensions = testCase "Test generating implementation for a value object with Copying and Coding extensions" (do
  assertEqual "Implementations should be equal" 
    expectedImplementationForValueObjectWithCopyingAndCodingExtensions
    (generateImplementation (valueObjectWithMixedPropertiesAndExtensions [Copying, Coding]))
  )
