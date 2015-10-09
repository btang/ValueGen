module ValueGenTest.Utils.ValueObjectTemplates where

import ValueGen.Model.Comment
import ValueGen.Model.ObjectProperty
import ValueGen.Model.PrimitiveProperty
import ValueGen.Model.ValueObject
import ValueGen.Model.ValueObjectComponent
import ValueGen.Model.ValueObjectExtension

valueObjectWithOneObjectProperty = 
  ValueObject {
    ValueGen.Model.ValueObject.name = "MyObject",
    extensions = [],
    imports = [],
    comments = [],
    components = [
      CommentComponent (Comment {text = " A string"}),
      ObjectPropertyComponent (ObjectProperty {objectType = "NSString", ValueGen.Model.ObjectProperty.name = "someString"})
    ]
  }

valueObjectWithOnePrimitiveProperty = 
  ValueObject {
    ValueGen.Model.ValueObject.name = "MyObject",
    extensions = [],
    imports = [],
    comments = [],
    components = [
      CommentComponent (Comment {text = " An int"}),
      PrimitivePropertyComponent (PrimitiveProperty {primitiveType = "NSInteger", ValueGen.Model.PrimitiveProperty.name = "someInt"})
    ]
  }

valueObjectWithMixedProperties = 
  ValueObject {
    ValueGen.Model.ValueObject.name = "MyObject",
    extensions = [],
    imports = [],
    comments = [],
    components = [
      CommentComponent (Comment {text = " A string"}),
      ObjectPropertyComponent (ObjectProperty {objectType = "NSString", ValueGen.Model.ObjectProperty.name = "someString"}),
      CommentComponent (Comment {text = " An int"}),
      PrimitivePropertyComponent (PrimitiveProperty {primitiveType = "NSInteger", ValueGen.Model.PrimitiveProperty.name = "someInt"})
    ]
  }

valueObjectWithMixedPropertiesAndExtensions :: [ValueObjectExtension] -> ValueObject
valueObjectWithMixedPropertiesAndExtensions extensions = ValueObject {
  ValueGen.Model.ValueObject.name = "MyObject",
  extensions = extensions,
  imports = [],
  comments = [],
  components = [
    CommentComponent (Comment {text = " A string"}),
    ObjectPropertyComponent (ObjectProperty {objectType = "NSString", ValueGen.Model.ObjectProperty.name = "someString"}),
    CommentComponent (Comment {text = " An int"}),
    PrimitivePropertyComponent (PrimitiveProperty {primitiveType = "NSInteger", ValueGen.Model.PrimitiveProperty.name = "someInt"})
  ]
  }

valueObjectWithMixedPrimitivePropertyTypes = 
  ValueObject {
    ValueGen.Model.ValueObject.name = "MyObject",
    extensions = [],
    imports = [],
    comments = [],
    components = [
      PrimitivePropertyComponent (PrimitiveProperty {primitiveType = "BOOL", ValueGen.Model.PrimitiveProperty.name = "someBool"}),
      PrimitivePropertyComponent (PrimitiveProperty {primitiveType = "double", ValueGen.Model.PrimitiveProperty.name = "someDouble"}),
      PrimitivePropertyComponent (PrimitiveProperty {primitiveType = "float", ValueGen.Model.PrimitiveProperty.name = "someFloat"}),
      PrimitivePropertyComponent (PrimitiveProperty {primitiveType = "int", ValueGen.Model.PrimitiveProperty.name = "someInt"}),
      PrimitivePropertyComponent (PrimitiveProperty {primitiveType = "int32_t", ValueGen.Model.PrimitiveProperty.name = "someInt32"}),
      PrimitivePropertyComponent (PrimitiveProperty {primitiveType = "int64_t", ValueGen.Model.PrimitiveProperty.name = "someInt64"}),
      PrimitivePropertyComponent (PrimitiveProperty {primitiveType = "NSInteger", ValueGen.Model.PrimitiveProperty.name = "someInteger"}),
      PrimitivePropertyComponent (PrimitiveProperty {primitiveType = "NSPoint", ValueGen.Model.PrimitiveProperty.name = "somePoint"}),
      PrimitivePropertyComponent (PrimitiveProperty {primitiveType = "NSRect", ValueGen.Model.PrimitiveProperty.name = "someRect"}),
      PrimitivePropertyComponent (PrimitiveProperty {primitiveType = "NSSize", ValueGen.Model.PrimitiveProperty.name = "someSize"})
    ]  
  }