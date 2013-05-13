//
//  TestViewController.m
//  mbtest
//
//  Created by Robert Obermann on 2/25/13.
//  Copyright (c) 2013 Robert Obermann. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController
@synthesize dccTextField = _dccTextField;
@synthesize encodedStringLabel = _encodedStringLabel;

#pragma mark TEXTFIELD DELEGATE

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}



#pragma mark ERROR MESSAGES

// SHOW THE CORRESPONDING ERROR MESSAGE OR THE DEFAULT ERROR MESSAGE
- (void)showErrorCode:(int)code
{
    NSString *alertTitle;
    NSString *alertMessage;
    NSString *cancelButtonTitle;
    
    switch (code)
    {
        case 0:
            alertTitle = @"Invalid String Length";
            alertMessage = [NSString stringWithFormat:@"String length is %i, should be 8", self.dccTextField.text.length];
            cancelButtonTitle = @"OK";
            break;
            
        case 1:
            alertTitle = @"Invalid Characters";
            alertMessage = [NSString stringWithFormat:@"String '%@' contains invalid characters", self.dccTextField.text];
            cancelButtonTitle = @"OK";
            break;

        default:
            alertTitle = @"Unknown Error";
            alertMessage = [NSString stringWithFormat:@"An unknown error has occurred"];
            cancelButtonTitle = @"OK";
            break;
    }
    
    UIAlertView *invalidCharacterAlertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                                        message:alertMessage
                                                                       delegate:self
                                                              cancelButtonTitle:cancelButtonTitle
                                                              otherButtonTitles:nil, nil];
    [invalidCharacterAlertView show];
}



#pragma mark UI TOUCH

// USER HAS TOUCHED THE SHOW MESSAGE DIGEST BUTTON
- (IBAction)showMessageDigestButtonTouched:(id)sender
{
    [self.dccTextField resignFirstResponder];
    
    NSString *dccString = self.dccTextField.text;
    
    // test the dcc for the correct length
    if (dccString.length == 8)
    {
        NSCharacterSet *validHexCharactersSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFabcdef"];
        bool dccStringHasValidHexCharacters = ![dccString rangeOfCharacterFromSet:validHexCharactersSet].location;
        
        // test the dcc for valid hex characters
        if (dccStringHasValidHexCharacters)
        {
            self.dccTextField.text = [dccString uppercaseString];
            
            // encode the DCC and update the label to the encoded version
            Encoder *encoder = [[Encoder alloc] init];
            NSString *encodedString = [encoder encode:dccString];
            [self.encodedStringLabel setText:encodedString];
        }
        else // non-hex characters are present
        {
            [self showErrorCode:1];
        }
    }
    else // the string isn't 8 characters
    {
        [self showErrorCode:0];
    }
}



#pragma mark VIEW CONTROLLER DELEGATE

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // remove the filler text from the UI builder
    [self.encodedStringLabel setText:@""];
}

@end
