module ValueGenTest.Parsing.DeclarationEndParserTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import Text.Parsec

import ValueGen.Model.DeclarationEnd

import ValueGen.Parsing.DeclarationEndParser

tests = testGroup "DeclarationEndParser tests" [
  testParseStandardDeclarationEndSucceeds
  ]

testParseStandardDeclarationEndSucceeds = testCase "Test parsing a standard declaration end succeeds" (do
  case parse declarationEndParser "" "}\n" of
    Left _ -> assertFailure "DeclarationEndParser failed to parse a standard declaration end"
    Right declarationEnd -> assertBool "Success" True
  )
