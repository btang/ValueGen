module Main where

import System.Environment
import System.IO

import Text.Printf

import Text.Parsec.String

import ValueGen.Parsing.ValueObjectParser

import ValueGen.CodeGeneration.ObjC.Writer

main = do
  args <- getArgs
  result <- parseFromFile valueObjectParser (head args)
  case result of
    Left _ -> putStrLn (printf "Failed to parse value object in file: %s" (head args))
    Right valueObject -> writeObjCFiles valueObject
