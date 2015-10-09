module ValueGenTest.Parsing.ValueObjectComponentParserTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import Text.Parsec

import ValueGen.Model.Comment
import ValueGen.Model.DeclarationEnd
import ValueGen.Model.DeclarationStart
import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.Property
import ValueGen.Model.ValueObjectComponent

import ValueGen.Parsing.ValueObjectComponentParser

tests = testGroup "ValueObjectComponentParser tests" [
  testParseCommentComponentSucceeds,
  testParseObjectPropertyComponentSucceeds,
  testParsePrimitivePropertyComponentSucceeds,
  testParseNonComponentFails
  ]

testParseCommentComponentSucceeds = testCase "Test parsing a comment component succeeds" (do
  case parse valueObjectComponentParser "" "#some test comment\n" of
    Left _ -> assertFailure "ValueObjectComponentParser failed to parse a comment component"
    Right commentComponent -> assertEqual "Comment equality" (Comment {text = "some test comment"}) (commentComponentValue commentComponent)
  )

testParseObjectPropertyComponentSucceeds = testCase "Test parsing an object property component succeeds" (do
  case parse valueObjectComponentParser "" "NSString *myString\n" of
    Left _ -> assertFailure "ValueObjectComponentParser failed to parse a standard object property"
    Right objectProperty -> assertEqual "Object property equality" (ObjectProperty {objectType = "NSString", ValueGen.Model.ObjectProperty.name = "myString"}) (objectPropertyComponentValue objectProperty)  
  )

testParsePrimitivePropertyComponentSucceeds = testCase "Test parsing a primitive property component succeeds" (do
  case parse valueObjectComponentParser "" "int myInt\n" of
    Left _ -> assertFailure "ValueObjectComponentParser failed to parse a standard primitive property"
    Right primitiveProperty -> assertEqual "Primitive property equality" (PrimitiveProperty {primitiveType = "int", ValueGen.Model.PrimitiveProperty.name = "myInt"}) (primitivePropertyComponentValue primitiveProperty)  
  )

testParseNonComponentFails = testCase "Test parsing non-component fails" (do
  case parse valueObjectComponentParser "" "some random junk\n" of
    Left _ -> assertBool "Parse failure expected" True
    Right invalidProperty -> assertFailure "ValueObjectComponentParser should have failed"
  )
