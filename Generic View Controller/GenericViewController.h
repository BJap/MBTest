//
//  GenericViewController.h
//  Robert Obermann
//
//  Created by Bobby on 4/19/13.
//  Copyright (c) 2013 Robert Obermann. All rights reserved.
//

// be sure to import these frameworks into your application
#import <AddressBook/AddressBook.h>
#import <EventKit/EventKit.h>

#import <UIKit/UIKit.h>
//#import "Your-App-Delegate.h"

@interface GenericViewController : UIViewController
{
    CGFloat screenWidth;
    CGFloat screenHeight;
    //Your-App-Delegate *appDelegate;
}

- (NSString *)appName;
- (NSString *)appVersion;
- (BOOL)deviceIsAnIphone;
- (BOOL)accessGrantedToAddressBook;
- (BOOL)accessGrantedToCalendar;
- (NSString *)navigationBarFontName;
- (NSString *)appFontName;
- (UIColor *)viewBackgroundColor;
- (void)addABackButton;
- (void)changeBackgroudColor;
- (void)customizeNavigationBarWithTitle:(NSString *)title;
- (void)customizeButton:(UIButton *)button withFontName:(NSString *)fontName;
- (void)customizeUILabel:(UILabel *)label withFontName:(NSString *)fontName;
- (void)drawTheScene;
- (void)goBackOneViewController;
- (void)showAWarningWithTag:(int)tag;
- (NSMutableString *)removeAllButNumbersFromString:(NSString *)string;
- (IBAction)cancelButtonTouched;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UILabel *navigationItemLabel;

@end
