module ValueGen.CodeGeneration.ObjC.Implementation.CopyingExtensionImplementationGenerator where

import ValueGen.Model.ValueObject

generateCopyingExtensionImplementation :: ValueObject -> [String]
generateCopyingExtensionImplementation valueObject = 
  concat [
    ["#pragma mark - NSCopying"],
    [""],
    ["- (instancetype)copyWithZone:(NSZone *)zone {"],
    ["  return self;"],
    ["}"]
  ]
