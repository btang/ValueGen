module ValueGenTest.CodeGeneration.ObjC.Header.InterfaceDeclarationGeneratorTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import Text.Printf

import ValueGen.CodeGeneration.ObjC.Header.InterfaceDeclarationGenerator

import ValueGen.Model.Comment
import ValueGen.Model.Import
import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectComponent
import ValueGen.Model.ValueObjectExtension

tests = testGroup "CommentGenerator tests" [
  testGenerateInterfaceDeclarationWithNoExtensions,
  testGenerateInterfaceDeclarationWithOneExtension,
  testGenerateInterfaceDeclarationWithTwoExtensions
  ]

_valueObjectWithExtensions :: [ValueObjectExtension] -> ValueObject
_valueObjectWithExtensions valueObjectExtensions = ValueObject {
  ValueGen.Model.ValueObject.name = "MyObject",
  extensions = valueObjectExtensions,
  imports = [
    Import {library = "LibraryA", component = "ComponentA"},
    Import {library = "", component = "ComponentB"}
  ],
  comments = [Comment {text = " Comment 1"}, Comment {text = " Comment 2"}],
  components = [
    CommentComponent (Comment {text = " A string"}),
    ObjectPropertyComponent (ObjectProperty {objectType = "NSString", ValueGen.Model.ObjectProperty.name = "someString"}),
    CommentComponent (Comment {text = " An int"}),
    PrimitivePropertyComponent (PrimitiveProperty {primitiveType = "NSUInteger", ValueGen.Model.PrimitiveProperty.name = "someInt"})
  ]
  }

_expectedInterfaceWithProtocolConformance :: String -> [String]
_expectedInterfaceWithProtocolConformance protocolConformance = [
  printf "@interface MyObject : NSObject%s" protocolConformance,
  "",
  "// A string",
  "@property (nonatomic, readonly, strong) NSString *someString;",
  "// An int",
  "@property (nonatomic, readonly, assign) NSUInteger someInt;",
  "",
  "- (instancetype)initWithSomeString:(NSString *)someString someInt:(NSUInteger)someInt;",
  "",
  "@end"
  ]

testGenerateInterfaceDeclarationWithNoExtensions = testCase "Test generating a standard interface with no extensions" (do
  assertEqual "Interface should be equal" 
    (_expectedInterfaceWithProtocolConformance "")
    (generateInterfaceDeclaration (_valueObjectWithExtensions []))
  )

testGenerateInterfaceDeclarationWithOneExtension = testCase "Test generating a standard interface with one extension" (do
  assertEqual "Interface should be equal" 
    (_expectedInterfaceWithProtocolConformance " <NSCopying>")
    (generateInterfaceDeclaration (_valueObjectWithExtensions [Copying]))
  )

testGenerateInterfaceDeclarationWithTwoExtensions = testCase "Test generating a standard interface with two extensions" (do
  assertEqual "Interface should be equal" 
    (_expectedInterfaceWithProtocolConformance " <NSCopying, NSCoding>")
    (generateInterfaceDeclaration (_valueObjectWithExtensions [Copying, Coding]))
  )