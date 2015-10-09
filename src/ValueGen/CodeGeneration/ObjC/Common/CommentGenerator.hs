module ValueGen.CodeGeneration.ObjC.Common.CommentGenerator where

import Text.Printf

import ValueGen.Model.Comment

generateComment :: Comment -> String
generateComment comment = printf "//%s" (commentText comment)
