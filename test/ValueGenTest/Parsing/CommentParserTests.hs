module ValueGenTest.Parsing.CommentParserTests where

import Test.Framework.Providers.API
import Test.Framework.Providers.HUnit
import Test.HUnit

import Text.Parsec

import ValueGen.Model.Comment
import ValueGen.Model.ValueObjectComponent

import ValueGen.Parsing.CommentParser

tests = testGroup "CommentParser tests" [
  testParseCommentWithNoLeadingSpacesSucceeds,
  testParseCommentWithLeadingSpacesSucceeds,
  testParseCommentWithTwoCommentMarkersSucceeds,
  testParseNonCommentFails,
  testParseCommentWithNoNewlineFails
  ]

testParseCommentWithNoLeadingSpacesSucceeds = testCase "Test parsing a comment with no leading spaces succeeds" (do
  case parse commentParser "" "#some test comment\n" of
    Left _ -> assertFailure "CommentParser failed to parse comment with no leading spaces"
    Right commentComponent -> assertEqual "Comment equality" (Comment {text = "some test comment"}) (commentComponentValue commentComponent)
  )

testParseCommentWithLeadingSpacesSucceeds = testCase "Test parsing a comment with leading spaces succeeds" (do
  case parse commentParser "" "#    some test comment\n" of
    Left _ -> assertFailure "CommentParser failed to parse comment with leading spaces"
    Right commentComponent -> assertEqual "Comment equality" (Comment {text = "    some test comment"}) (commentComponentValue commentComponent)
  )

testParseCommentWithTwoCommentMarkersSucceeds = testCase "Test parsing a comment with two comment markers succeeds" (do
  case parse commentParser "" "##some test comment\n" of
    Left _ -> assertFailure "CommentParser failed to parse comment with two comment markers"
    Right commentComponent -> assertEqual "Comment equality" (Comment {text = "#some test comment"}) (commentComponentValue commentComponent)
  )

testParseNonCommentFails = testCase "Test parsing of a non-comment fails" (do
  case parse commentParser "" "not a comment\n" of
    Left _ -> assertBool "Parse failure expected" True
    Right _ -> assertFailure "CommentParser should have failed"
  )

testParseCommentWithNoNewlineFails = testCase "Test parsing of a comment without a newline fails" (do
  case parse commentParser "" "# comment without newline" of
    Left _ -> assertBool "Parse failure expected" True
    Right _ -> assertFailure "CommentParser should have failed"
  )