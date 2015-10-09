module ValueGenTest.Parsing.ValueObjectParserTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import Text.Parsec

import Text.Printf

import ValueGen.Model.Comment
import ValueGen.Model.DeclarationEnd
import ValueGen.Model.DeclarationStart
import ValueGen.Model.Import
import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectComponent
import ValueGen.Model.ValueObjectExtension

import ValueGen.Parsing.ValueObjectParser

import Text.ParserCombinators.Parsec.Error

tests = testGroup "ValueObjectParser tests" [
  testParseValidValueObjectSucceeds
  ]

expectedValidValueObject = ValueObject {
  ValueGen.Model.ValueObject.name = "MyObject",
  ValueGen.Model.ValueObject.extensions = [Copying, Coding],
  imports = [
    Import {library="LibraryA", component="ComponentA"},
    Import {library="LibraryB", component="ComponentB"}
  ],
  comments = [Comment {text = " A simple object"}],
  components = [
    CommentComponent (Comment {text = " A string"}),
    ObjectPropertyComponent (ObjectProperty {objectType = "NSString", ValueGen.Model.ObjectProperty.name = "someString"}),
    CommentComponent (Comment {text = " An int"}),
    PrimitivePropertyComponent (PrimitiveProperty {primitiveType = "NSUInteger", ValueGen.Model.PrimitiveProperty.name = "someInt"})
  ]
  }

validValueObjectString = 
  "%import library=LibraryA component=ComponentA\n\
  \%import library=LibraryB component=ComponentB\n\
  \\n\
  \# A simple object\n\
  \MyObject (Copying, Coding) {\n\
  \# A string\n\
  \NSString *someString\n\
  \# An int\n\
  \NSUInteger someInt\n\
  \}\n"

testParseValidValueObjectSucceeds = testCase "Test parsing a valid value object succeeds" (do
  case parse valueObjectParser "" validValueObjectString of
    Left _ -> assertFailure "ValueObjectParser failed to parse a value object"
    Right valueObject -> assertEqual "ValueObject equality" expectedValidValueObject valueObject
  )
