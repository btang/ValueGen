module ValueGenTest.Parsing.ObjectPropertyParserTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import Text.Parsec

import ValueGen.Model.ObjectProperty
import ValueGen.Model.ValueObjectComponent

import ValueGen.Parsing.ObjectPropertyParser

tests = testGroup "ObjectPropertyParser tests" [
  testParseStandardObjectPropertySucceeds,
  testParseObjectPropertyWithMultipleSpacesSucceeds,
  testParseNonObjectPropertyFails
  ]

testParseStandardObjectPropertySucceeds = testCase "Test parsing an object property succeeds" (do
  case parse objectPropertyParser "" "NSString *myString\n" of
    Left _ -> assertFailure "ObjectPropertyParser failed to parse a standard object property"
    Right objectProperty -> assertEqual "Object property equality" (ObjectProperty {objectType = "NSString", name = "myString"}) (objectPropertyComponentValue objectProperty)
  )

testParseObjectPropertyWithMultipleSpacesSucceeds = testCase "Test parsing an object property with leading and inserted spaces succeeds" (do
  case parse objectPropertyParser "" "    NSString     *myString\n" of
    Left _ -> assertFailure "ObjectPropertyParser failed to parse a object property"
    Right objectProperty -> assertEqual "Object property equality" (ObjectProperty {objectType = "NSString", name = "myString"}) (objectPropertyComponentValue objectProperty)
  )

testParseNonObjectPropertyFails = testCase "Test parsing a primitive property fails" (do
  case parse objectPropertyParser "" "int myInt\n" of
    Left _ -> assertBool "Parse failure expected" True
    Right objectProperty -> assertFailure "ObjectPropertyParser should have failed"
  )
