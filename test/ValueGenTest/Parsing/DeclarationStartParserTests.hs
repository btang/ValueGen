module ValueGenTest.Parsing.DeclarationStartParserTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import Text.Parsec

import ValueGen.Model.DeclarationStart
import ValueGen.Model.ValueObjectComponent
import ValueGen.Model.ValueObjectExtension

import ValueGen.Parsing.DeclarationStartParser

tests = testGroup "DeclarationStartParser tests" [
  testParseStandardDeclarationStartSucceeds,
  testParseDeclarationStartWithoutOpeningBraceFails,
  testParseDeclarationStartWithoutNameFails,
  testParseDeclarationStartWithExtensionsSucceeds
  ]

testParseStandardDeclarationStartSucceeds = testCase "Test parsing a standard declaration start succeeds" (do
  case parse declarationStartParser "" "MyValueGenObject {\n" of
    Left _ -> assertFailure "DeclarationStartParser failed to parse a standard declaration start"
    Right declarationStart -> assertEqual "Declaration start equality" (DeclarationStart {name = "MyValueGenObject", extensions = []}) declarationStart
  )

testParseDeclarationStartWithoutOpeningBraceFails = testCase "Test parsing a declaration start without an opening brace fails" (do
  case parse declarationStartParser "" "MyValueGenObject " of
    Left _ -> assertBool "Parse failure expected" True
    Right declarationStart -> assertFailure "Parse failure expected"
  )

testParseDeclarationStartWithoutNameFails = testCase "Test parsing a declaration start without a name fails" (do
  case parse declarationStartParser "" " { " of
    Left _ -> assertBool "Parse failure expected" True
    Right declarationStart -> assertFailure "Parse failure expected"
  )

expectedDeclarationStartWithExtensions = DeclarationStart {
    name = "MyValueGenObject",
    extensions = [Copying, InvalidExtension, Coding]
  }

testParseDeclarationStartWithExtensionsSucceeds = testCase "Test parsing of a declaration start with extensions succeeds" (do
  case parse declarationStartParser "" "MyValueGenObject (Copying, Junk, Coding) {\n" of
    Left _ -> assertFailure "DeclarationStartParser failed to parse a declaration start with extensions"
    Right declarationStart -> assertEqual "Declaration start equality" expectedDeclarationStartWithExtensions declarationStart
  )
