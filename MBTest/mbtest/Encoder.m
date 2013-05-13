//
//  Encoder.m
//  mbtest
//
//  Created by Robert Obermann on 2/28/13.
//  Copyright (c) 2013 Robert Obermann. All rights reserved.
//

#import "Encoder.h"

@implementation Encoder

#define SSK_STRING @"00112233445566778899"

#pragma mark ENCODING AND CONVERSION

// STANDARD SHA1 ENCODING
- (NSString *)encode:(NSString *)dccString
{
    // concatentate the DCC and SSK
    NSString *input = [NSString stringWithFormat:@"%@%@", dccString, SSK_STRING];
    
    int arrayLength = input.length / 2;
    uint8_t inputArray[arrayLength];
    
    // populate inputArray with bytes from the hex string
    for (int i = 0, j = 0; i < input.length; i = i + 2, j++)
    {
        // pair of hex 'characters'
        char aChar = [input characterAtIndex:i];
        char bChar = [input characterAtIndex:i + 1];
        
        // binary values for each hex 'character'
        int a = [self intValueForHexChar:aChar];
        int b = [self intValueForHexChar:bChar];
        
        // combine the pair of binary values into a single byte
        int aAndB = (a << 4) | b;
        
        inputArray[j] = aAndB;
    }
    
    // encode the array of bytes
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(inputArray, arrayLength, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    // build a hex string from the array of encoded bytes
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return [output uppercaseString];
}



// INTERGER VALUE FOR A GIVEN HEX CHARACTER
// IOS DOESN'T KNOW HOW TO CONVERT HEX STRINGS
- (int)intValueForHexChar:(char)character
{
    int asciiValue = (int)character;
    int intValue = -1;
    
    // convert each hex character to its true binary worth
    if (asciiValue >= '0' && asciiValue <= '9')
    {
        intValue = asciiValue - '0';
    }
    else if (asciiValue >= 'A' && asciiValue <= 'F')
    {
        intValue = asciiValue - 'A' + 10;
    }
    else if (asciiValue >= 'a' && asciiValue <= 'f')
    {
        intValue = asciiValue - 'a' + 10;
    }
    
    return intValue;
}

@end
