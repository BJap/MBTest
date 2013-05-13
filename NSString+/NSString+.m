//
//  NSString+.m
//  konfirm
//
//  Created by Bobby on 5/13/13.
//  Copyright (c) 2013 konfirm. All rights reserved.
//

#import "NSString+.h"

@implementation NSString (RemoveAllButNumbers)

#pragma mark STRING EDITING

// STRIP ALL BUT NUMBERS FROM THE STRING
- (NSString *)removeAllButNumbers
{
    NSMutableString *parsedString = [NSMutableString stringWithCapacity:self.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    // check each letter in the string and keep only the numbers
    while ([scanner isAtEnd] == NO)
    {
        NSString *buffer;
        
        // keep the character or move to the next one
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer])
        { // the character being scanned is a number
            [parsedString appendString:buffer];
            
        }
        else
        { // the character being scanned is a character other than a number
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    
    return parsedString;
}

@end
