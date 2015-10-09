module ValueGen.Model.Comment where

data Comment = Comment {
  text :: String
} deriving (Show, Eq)

commentText (Comment text) = text
