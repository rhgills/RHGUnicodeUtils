//
//  UnicodeTests.m
//  UnicodeTests
//
//  Created by Robert Gilliam on 2/11/14.
//  Copyright (c) 2014 Robert Gilliam. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+RHGUnicodeUtils.h"


@interface UnicodeTests : XCTestCase

@end

@implementation UnicodeTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMultipleCodeUnitCharacter
{
    NSString *s = @"\U0001F30D"; // earth globe emoji 🌍
    XCTAssertEqual([s rhg_composedCharacterLength], (NSUInteger)1);
}

- (void)testDecomposedCharacter
{
    NSString *s = @"e\u0301"; // e + ´
    XCTAssertEqual([s rhg_composedCharacterLength], (NSUInteger)1);
}

- (void)testVariationSequence
{
    NSString *s = @"\u2614\ufe0f"; // ☔️ (U+2614 U+FE0F)
    XCTAssertEqual([s rhg_composedCharacterLength], (NSUInteger)1);
}

- (void)testCanonicalEquivalence
{
    NSString *a = @"a";
    NSString *b = @"a";
    
    XCTAssertTrue([a rhg_isCanonicallyEquivalentToString:b]);
    
    NSString *composed = @"\u00E9"; // é
    NSString *decomposed = @"e\u0301"; // e + ´
    
    XCTAssertTrue([composed rhg_isCanonicallyEquivalentToString:decomposed]);
    
    NSString *ligature = @"\uFB00"; // ﬀ ligature
    NSString *ff = @"ff"; // ff
    
    XCTAssertFalse([ligature rhg_isCanonicallyEquivalentToString:ff]);
}

- (void)testCompatibleEquivalence
{
    NSString *a = @"a";
    NSString *b = @"a";
    
    XCTAssertTrue([a rhg_isCompatiblyEquivalentToString:b]);
    
    NSString *composed = @"\u00E9"; // é
    NSString *decomposed = @"e\u0301"; // e + ´
    
    XCTAssertTrue([composed rhg_isCompatiblyEquivalentToString:decomposed]);
    
    NSString *ligature = @"\uFB00"; // ﬀ ligature
    NSString *ff = @"ff"; // ff
    
    XCTAssertTrue([ligature rhg_isCompatiblyEquivalentToString:ff]);
}

- (void)testByteEquivalence
{
    NSString *a = @"a";
    NSString *b = @"a";
    
    XCTAssertTrue([a isEqualToString:b]);
    
    NSString *composed = @"\u00E9"; // é
    NSString *decomposed = @"e\u0301"; // e + ´

    XCTAssertFalse([composed isEqualToString:decomposed]);
    
    NSString *ligature = @"\uFB00"; // ﬀ ligature
    NSString *ff = @"ff"; // ff
    
    XCTAssertFalse([ligature isEqualToString:ff]);
}

- (void)testEnumerateCharacters
{
    NSString *simple = @"abc";
    
    NSMutableArray *characters = [NSMutableArray new];
    [simple enumerateComposedCharactersUsingBlock:^(NSString *aCharacter){
        [characters addObject:aCharacter];
    }];
    
    NSArray *expected =  @[@"a", @"b", @"c"];
    XCTAssertEqualObjects(characters, expected);
}

@end
