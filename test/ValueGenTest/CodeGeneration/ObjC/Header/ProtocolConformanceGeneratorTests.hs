module ValueGenTest.CodeGeneration.ObjC.Header.ProtocolConformanceGeneratorTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import ValueGen.CodeGeneration.ObjC.Header.ProtocolConformanceGenerator

import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectExtension

tests = testGroup "ProtocolConformanceGeneratorTests tests" [
  testGenerateProtocolConformanceForOneExtension,
  testGenerateProtocolConformanceForTwoExtensions
  ]

valueObjectWithOneExtension = ValueObject {
  ValueGen.Model.ValueObject.name = "MyObject",
  extensions = [Copying],
  imports = [],
  comments = [],
  components = []
  }

testGenerateProtocolConformanceForOneExtension = testCase "Test generating protocol conformance for one extension" (do
  assertEqual "Protocol conformance should be equal"
    "<NSCopying>"
    (generateProtocolConformance valueObjectWithOneExtension)
  )

valueObjectWithTwoExtensions = ValueObject {
  ValueGen.Model.ValueObject.name = "MyObject",
  extensions = [Copying, Coding],
  imports = [],
  comments = [],
  components = []
  }

testGenerateProtocolConformanceForTwoExtensions = testCase "Test generating protocol conformance for two extensions" (do
  assertEqual "Protocol conformance should be equal"
    "<NSCopying, NSCoding>"
    (generateProtocolConformance valueObjectWithTwoExtensions)
  )