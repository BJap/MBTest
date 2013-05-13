//
//  TestViewController.h
//  mbtest
//
//  Created by Robert Obermann on 2/25/13.
//  Copyright (c) 2013 Robert Obermann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Encoder.h"

@interface TestViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *dccTextField;
@property (weak, nonatomic) IBOutlet UILabel *encodedStringLabel;

@end
