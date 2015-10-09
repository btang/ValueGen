module ValueGen.Model.ValueObjectExtension where

data ValueObjectExtension =
  Copying |
  Coding  |
  InvalidExtension
  deriving (Show, Eq, Bounded, Enum)
