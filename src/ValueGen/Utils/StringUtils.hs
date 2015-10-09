module ValueGen.Utils.StringUtils where

indent :: String -> Int -> String
indent string levels = concat [concat (replicate levels "  "), string]
