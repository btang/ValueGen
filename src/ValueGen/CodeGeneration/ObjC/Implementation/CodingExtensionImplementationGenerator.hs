module ValueGen.CodeGeneration.ObjC.Implementation.CodingExtensionImplementationGenerator where

import Text.Printf

import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectComponent

import ValueGen.Utils.PropertyUtils
import ValueGen.Utils.StringUtils 
import ValueGen.Utils.ValueObjectComponentFilters

generateCodingExtensionImplementation :: ValueObject -> [String]
generateCodingExtensionImplementation valueObject =
  concat [
    _generateInitWithCoderImplementation valueObject,
    [""],
    _generateEncodeWithCoderImplementation valueObject
  ]

_generateInitWithCoderImplementation :: ValueObject -> [String]
_generateInitWithCoderImplementation valueObject =
  concat [
    ["#pragma mark - NSCoding"],
    [""],
    ["- (instancetype)initWithCoder:(NSCoder *)aDecoder {"],
    ["  self = [super init];"],
    ["  if (self) {"],
    (map (\x -> (indent x 2)) (_generateDecodings valueObject)),
    ["  }"],
    ["  return self;"],
    ["}"]
  ]

_generateEncodeWithCoderImplementation :: ValueObject -> [String]
_generateEncodeWithCoderImplementation valueObject =
  concat [
    ["- (void)encodeWithCoder:(NSCoder *)aCoder {"],
    (map (\x -> (indent x 1)) (_generateEncodings valueObject)),
    ["}"]
  ]

_generateDecodings :: ValueObject -> [String]
_generateDecodings valueObject =
  map 
    _generateDecoding
    (filterOutComments (valueObjectComponents valueObject))

_generateDecoding :: ValueObjectComponent -> String
_generateDecoding valueObjectComponent =
  printf "%s = [aDecoder decode%sForKey:@\"%s\"];"
    (underscoredPropertyName valueObjectComponent)
    (_codingTypeForProperty valueObjectComponent)
    (propertyName valueObjectComponent)

_generateEncodings :: ValueObject -> [String]
_generateEncodings valueObject =
  map 
    _generateEncoding
    (filterOutComments (valueObjectComponents valueObject))  

_generateEncoding :: ValueObjectComponent -> String
_generateEncoding valueObjectComponent =
  printf "[aCoder encode%s:%s forKey:@\"%s\"];"
    (_codingTypeForProperty valueObjectComponent)
    (underscoredPropertyName valueObjectComponent)
    (propertyName valueObjectComponent)

_codingTypeForProperty :: ValueObjectComponent -> String
_codingTypeForProperty valueObjectComponent =
  case valueObjectComponent of
    ObjectPropertyComponent objectPropertyComponent -> "Object"
    PrimitivePropertyComponent primitivePropertyComponent -> _codingTypeForPrimitivePropertyType (primitivePropertyType primitivePropertyComponent)

_codingTypeForPrimitivePropertyType :: String -> String
_codingTypeForPrimitivePropertyType primitiveType =
  case primitiveType of
    "BOOL" -> "Bool"
    "double" -> "Double"
    "float" -> "Float"
    "int" -> "Int"
    "int32_t" -> "Int32"
    "int64_t" -> "Int64"
    "NSInteger" -> "Integer"
    "NSPoint" -> "Point"
    "NSRect" -> "Rect"
    "NSSize" -> "Size"
    _ -> ""


