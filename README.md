# Some simple methods for correctly handling NSStrings, backed by tests

NSString is implemented using UTF-16 and leaks some details of this implementation to the user.

## [@"é" length] == 2
`[string length]` returns the length of the string in Unicode code units, not in apparent visual characters (or for that matter, in Unicode code points either).

Instead, use `[string rhg_composedCharacterLength]`.

## When "é" is not equal to "é"
`[string isEqualToString:anotherString]` performs a byte by byte comparison. 

Make sure this is what you want.

```
NSString *s = @"\u00E9"; // é
NSString *t = @"e\u0301"; // e + ´
BOOL isEqual = [s isEqualToString:t];
NSLog(@"%@ is %@ to %@", s, isEqual ? @"equal" : @"not equal", t);
// => é is not equal to é
```

If not, use `[s rhg_isCanonicallyEquivalentToString:t]` or `[s rhg_isCompatiblyEquivalentToString:t]`.

Example courtesy of the excellent objc.io article (NSString and Unicode)[http://www.objc.io/issue-9/unicode.html], Issue #9, by Ole Begemann. I wrote this small category while reading that article and exploring some of the issues raised therein. Thanks for the inspiration, Ole. I highly recommend reading the full article, for, among other things, through explanations of Unicode concepts such as composed characters and canonical equivalence.