module Main where

import ValueGenTest.CodeGeneration.ObjC.Common.CommentGeneratorTests
import ValueGenTest.CodeGeneration.ObjC.Common.InitGeneratorTests
import ValueGenTest.CodeGeneration.ObjC.Header.HeaderGeneratorTests
import ValueGenTest.CodeGeneration.ObjC.Header.ImportGeneratorTests
import ValueGenTest.CodeGeneration.ObjC.Header.InterfaceDeclarationGeneratorTests
import ValueGenTest.CodeGeneration.ObjC.Header.ObjectPropertyDeclarationGeneratorTests
import ValueGenTest.CodeGeneration.ObjC.Header.PrimitivePropertyDeclarationGeneratorTests
import ValueGenTest.CodeGeneration.ObjC.Header.ProtocolConformanceGeneratorTests
import ValueGenTest.CodeGeneration.ObjC.Implementation.CodingExtensionImplementationGeneratorTests
import ValueGenTest.CodeGeneration.ObjC.Implementation.HashImplementationGeneratorTests
import ValueGenTest.CodeGeneration.ObjC.Implementation.ImplementationGeneratorTests
import ValueGenTest.CodeGeneration.ObjC.Implementation.InitImplementationGeneratorTests
import ValueGenTest.CodeGeneration.ObjC.Implementation.IsEqualImplementationGeneratorTests

import ValueGenTest.Parsing.CommentParserTests
import ValueGenTest.Parsing.DeclarationEndParserTests
import ValueGenTest.Parsing.DeclarationStartParserTests
import ValueGenTest.Parsing.ImportParserTests
import ValueGenTest.Parsing.ObjectPropertyParserTests
import ValueGenTest.Parsing.PrimitivePropertyParserTests
import ValueGenTest.Parsing.ValueObjectComponentParserTests
import ValueGenTest.Parsing.ValueObjectParserTests

import Test.Framework.Runners.Console (defaultMain)

main = defaultMain $ [
  ValueGenTest.CodeGeneration.ObjC.Common.CommentGeneratorTests.tests,
  ValueGenTest.CodeGeneration.ObjC.Common.InitGeneratorTests.tests,
  ValueGenTest.CodeGeneration.ObjC.Header.HeaderGeneratorTests.tests,
  ValueGenTest.CodeGeneration.ObjC.Header.ImportGeneratorTests.tests,
  ValueGenTest.CodeGeneration.ObjC.Header.InterfaceDeclarationGeneratorTests.tests,
  ValueGenTest.CodeGeneration.ObjC.Header.ObjectPropertyDeclarationGeneratorTests.tests,
  ValueGenTest.CodeGeneration.ObjC.Header.PrimitivePropertyDeclarationGeneratorTests.tests,
  ValueGenTest.CodeGeneration.ObjC.Header.ProtocolConformanceGeneratorTests.tests,
  ValueGenTest.CodeGeneration.ObjC.Implementation.CodingExtensionImplementationGeneratorTests.tests,
  ValueGenTest.CodeGeneration.ObjC.Implementation.HashImplementationGeneratorTests.tests,
  ValueGenTest.CodeGeneration.ObjC.Implementation.ImplementationGeneratorTests.tests,
  ValueGenTest.CodeGeneration.ObjC.Implementation.InitImplementationGeneratorTests.tests,
  ValueGenTest.CodeGeneration.ObjC.Implementation.IsEqualImplementationGeneratorTests.tests,
  ValueGenTest.Parsing.CommentParserTests.tests, 
  ValueGenTest.Parsing.DeclarationEndParserTests.tests,
  ValueGenTest.Parsing.DeclarationStartParserTests.tests,
  ValueGenTest.Parsing.ImportParserTests.tests,
  ValueGenTest.Parsing.ObjectPropertyParserTests.tests,
  ValueGenTest.Parsing.PrimitivePropertyParserTests.tests,  
  ValueGenTest.Parsing.ValueObjectComponentParserTests.tests,
  ValueGenTest.Parsing.ValueObjectParserTests.tests
  ]