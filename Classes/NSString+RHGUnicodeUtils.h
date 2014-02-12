//
//  NSString+RHGUnicodeUtils.h
//  Unicode
//
//  Created by Robert Gilliam on 2/11/14.
//  Copyright (c) 2014 Robert Gilliam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RHGUnicodeUtils)

- (NSUInteger)rhg_composedCharacterLength;
- (void)enumerateComposedCharactersUsingBlock:(void (^)(NSString *character))block;

- (BOOL)rhg_isCanonicallyEquivalentToString:(NSString *)string;
- (BOOL)rhg_isCompatiblyEquivalentToString:(NSString *)string;

@end
