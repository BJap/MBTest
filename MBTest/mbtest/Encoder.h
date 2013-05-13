//
//  Encoder.h
//  mbtest
//
//  Created by Robert Obermann on 2/28/13.
//  Copyright (c) 2013 Robert Obermann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface Encoder : NSObject

- (NSString *)encode:(NSString *)input;

@end
