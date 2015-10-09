module ValueGenTest.CodeGeneration.ObjC.Common.CommentGeneratorTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import ValueGen.CodeGeneration.ObjC.Common.CommentGenerator

import ValueGen.Model.Comment

tests = testGroup "CommentGenerator tests" [
  testGenerateComment
  ]

testGenerateComment = testCase "Test generating a standard comment" (do
  assertEqual "Comment should be equal" 
    "//some test comment" 
    (generateComment (Comment {text = "some test comment"}))
  )
