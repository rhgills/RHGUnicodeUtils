//
//  NSString+RHGUnicodeUtils.m
//  Unicode
//
//  Created by Robert Gilliam on 2/11/14.
//  Copyright (c) 2014 Robert Gilliam. All rights reserved.
//

#import "NSString+RHGUnicodeUtils.h"

@implementation NSString (RHGUnicodeUtils)

- (NSUInteger)rhg_composedCharacterLength
{
    __block NSUInteger length = 0;
    
    [self enumerateComposedCharactersUsingBlock:^(NSString *character) {
        length++;
    }];
    
    return length;
}

- (void)enumerateComposedCharactersUsingBlock:(void (^)(NSString *character))block
{
    NSRange fullRange = NSMakeRange(0, [self length]);
    [self enumerateSubstringsInRange:fullRange options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        block(substring);
    }];
}

- (BOOL)rhg_isCanonicallyEquivalentToString:(NSString *)string
{
    return [[self decomposedStringWithCanonicalMapping] isEqualToString:[string decomposedStringWithCanonicalMapping]];
}

- (BOOL)rhg_isCompatiblyEquivalentToString:(NSString *)string
{
    return [[self decomposedStringWithCompatibilityMapping] isEqualToString:[string decomposedStringWithCompatibilityMapping]];
}

@end
