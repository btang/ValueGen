module ValueGenTest.Parsing.PrimitivePropertyParserTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import Text.Parsec

import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObjectComponent

import ValueGen.Parsing.PrimitivePropertyParser

tests = testGroup "PrimitivePropertyParser tests" [
  testParseStandardPrimitivePropertySucceeds,
  testParsePrimitivePropertyWithMultipleSpacesSucceeds,
  testParseNonPrimitivePropertyFails
  ]

testParseStandardPrimitivePropertySucceeds = testCase "Test parsing a primitive property succeeds" (do
  case parse primitivePropertyParser "" "int myInt\n" of
    Left _ -> assertFailure "PrimitivePropertyParser failed to parse a standard primitive property"
    Right primitiveProperty -> assertEqual "Primitive property equality" (PrimitiveProperty {primitiveType = "int", name = "myInt"}) (primitivePropertyComponentValue primitiveProperty)
  )

testParsePrimitivePropertyWithMultipleSpacesSucceeds = testCase "Test parsing a primitive property with leading and inserted spaces succeeds" (do
  case parse primitivePropertyParser "" "    int     myInt\n" of
    Left _ -> assertFailure "PrimitivePropertyParser failed to parse a primitive property"
    Right primitiveProperty -> assertEqual "Primitive property equality" (PrimitiveProperty {primitiveType = "int", name = "myInt"}) (primitivePropertyComponentValue primitiveProperty)
  )

testParseNonPrimitivePropertyFails = testCase "Test parsing an object property fails" (do
  case parse primitivePropertyParser "" "int *myInt\n" of
    Left _ -> assertBool "Parse failure expected" True
    Right primitiveProperty -> assertFailure "PrimitivePropertyParser should have failed"
  )
