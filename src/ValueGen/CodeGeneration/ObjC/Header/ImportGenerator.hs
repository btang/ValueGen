module ValueGen.CodeGeneration.ObjC.Header.ImportGenerator where

import Text.Printf

import ValueGen.Model.Import

generateImport :: Import -> String
generateImport importData =
  case (importLibrary importData) of
    "" -> 
      printf "#import \"%s.h\"" 
        (importComponent importData)
    library -> 
      printf "#import <%s/%s.h>" 
        (importLibrary importData) 
        (importComponent importData)
