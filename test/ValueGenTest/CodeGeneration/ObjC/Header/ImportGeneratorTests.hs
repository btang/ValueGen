module ValueGenTest.CodeGeneration.ObjC.Header.ImportGeneratorTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import ValueGen.CodeGeneration.ObjC.Header.ImportGenerator

import ValueGen.Model.Import

tests = testGroup "ImportGenerator tests" [
  testGenerateImportWithLibraryAndComponent,
  testGenerateImportWithComponentButNoLibrary
  ]

importWithLibraryAndComponent = Import {library = "MyLibrary", component = "MyComponent"}

testGenerateImportWithLibraryAndComponent = testCase "Test generating an import with library and component" (do
  assertEqual "Import should be equal"
    "#import <MyLibrary/MyComponent.h>"
    (generateImport importWithLibraryAndComponent)
  )

importWithComponentButNoLibrary = Import {library = "", component = "MyComponent"}

testGenerateImportWithComponentButNoLibrary = testCase "Test generating an import with a component but no library" (do
  assertEqual "Import should be equal"
    "#import \"MyComponent.h\""
    (generateImport importWithComponentButNoLibrary)
  )
