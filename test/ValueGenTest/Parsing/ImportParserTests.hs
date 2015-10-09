module ValueGenTest.Parsing.ImportParserTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import Text.Parsec

import ValueGen.Model.Import

import ValueGen.Parsing.ImportParser

tests = testGroup "ImportParser tests" [
  testParseImportWithLibraryAndComponentSucceeds,
  testParseImportWithComponentButNoLibrarySucceeds,
  testParseImportWithLibraryAndNoComponentFails
  ]

testParseImportWithLibraryAndComponentSucceeds = testCase "Test parsing an import with library and component succeeds" (do
  case parse importParser "" "%import library=MyLibrary component=MyComponent\n" of
    Left _ -> assertFailure "ImportParser failed to parse an import with library and component"
    Right importResult -> assertEqual "Import equality" (Import {library = "MyLibrary", component = "MyComponent"}) importResult
  )

testParseImportWithComponentButNoLibrarySucceeds = testCase "Test parsing an import with a component but no library succeeds" (do
  case parse importParser "" "%import library= component=MyComponent\n" of
    Left _ -> assertFailure "ImportParser failed to parse an import with component but no library"
    Right importResult -> assertEqual "Import equality" (Import {library = "", component = "MyComponent"}) importResult
  )

testParseImportWithLibraryAndNoComponentFails = testCase "Test parsing an import with library but no component fails" (do
  case parse importParser "" "%import library=MyLibrary component=\n" of
    Left _ -> assertBool "Parse failure expected" True
    Right importResult -> assertFailure "ImportParser should have failed"
  )
