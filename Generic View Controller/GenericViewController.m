//
//  GenericViewController.m
//  Robert Obermann
//
//  Created by Bobby on 4/19/13.
//  Copyright (c) 2013 Robert Obermann. All rights reserved.
//

#import "GenericViewController.h"

@interface GenericViewController ()

@end

@implementation GenericViewController

@synthesize cancelButton = _cancelButton;
@synthesize doneButton = _doneButton;
@synthesize navigationItemLabel = _navigationItemLabel;

#pragma mark APP INFO

// RETURN THE APP NAME
- (NSString *)appName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}



// RETURN THE APP VERSION NUMBER
- (NSString *)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}



// IS THE APP RUNNING ON AN IPHONE
- (BOOL)deviceIsAnIphone
{
    return [[UIDevice currentDevice].model isEqualToString:@"iPhone"];
}



#pragma mark ACCESS TO PHONE DATA

// IS ACCESS TO ADDRESS BOOK GRANTED
- (BOOL)accessGrantedToAddressBook
{
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    __block BOOL accessGranted = NO;
    
    if (ABAddressBookRequestAccessWithCompletion != NULL)
    { // we're on iOS6
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     accessGranted = granted;
                                                     dispatch_semaphore_signal(sema);
                                                 });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    else
    { // we're on iOS5 or older
        accessGranted = YES;
    }
    
    return accessGranted;
}



// IS ACCESS TO CALENDAR GRANTED
- (BOOL)accessGrantedToCalendar
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    __block BOOL accessToCalendarsGranted = NO;
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    { // we're on iOS6
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
         {
             accessToCalendarsGranted = granted;
             dispatch_semaphore_signal(sema);
         }];
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    else
    { // we're on iOS5 or older
        accessToCalendarsGranted = YES;
    }
    
    return accessToCalendarsGranted;
}



#pragma mark APP-SPECIFIC COSMETICS

// NAVIGATION BAR AND ITEMS FONT
- (NSString *)navigationBarFontName
{
    return @"Your Font Name";
}



// GENERAL APP FONT
- (NSString *)appFontName
{
    return @"Another Font Name";
}



// RETURN THE KONFIRM BACKGROUND COLOR

- (UIColor *)viewBackgroundColor
{
    return [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
}



#pragma mark INTERFACE COSMETICS

// ADD A BACK BUTTON
- (void)addABackButton
{
    UIBarButtonItem *separator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [separator setWidth:4];
    
    UIButton *leftButton = [[UIButton alloc] init];
    [leftButton setFrame:CGRectMake(0,0,25,20)];
    [leftButton setBackgroundImage:[UIImage imageNamed: @"your back arrow image.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(goBackOneViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    NSArray *leftItems = [[NSArray alloc] initWithObjects:separator, leftBarButton, nil];
    
    [self.navigationItem setLeftBarButtonItems:leftItems];
}



// CHANGE THE BACKGROUND COLOR
- (void)changeBackgroudColor
{
    [self.view setBackgroundColor:[self viewBackgroundColor]];
}



// CUSTOMIZE NAVIGATION BAR
- (void)customizeNavigationBarWithTitle :(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:[self navigationBarFontName] size:18.0]];
    [label setShadowColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:title];
    [label sizeToFit];
    [self.navigationItem setTitleView:label];
}



// CUSTOMIZE A UIBUTTON
- (void)customizeButton:(UIButton *)button withFontName:(NSString *)fontName
{
    CGFloat labelFontPointSize = button.titleLabel.font.pointSize;
    [button.titleLabel setFont:[UIFont fontWithName:fontName size:labelFontPointSize]];
}



// CUSTOMIZE A UILABEL
- (void)customizeUILabel:(UILabel *)label withFontName:(NSString *)fontName
{
    CGFloat labelFontPointSize = label.font.pointSize;
    [label setFont:[UIFont fontWithName:fontName size:labelFontPointSize]];
}



// CHANGE THE SCENE TO HAVE SPECIFIC FONT AND COLOR SETTINGS FOR THE INTERFACE ELEMENTS
- (void)drawTheScene
{
    [self changeBackgroudColor];
    
    if (self.navigationController)
    {
        [self customizeNavigationBarWithTitle:self.title]; // make sure you give your view controller a title in storyboard or in viewDidLoad
        
        [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                       [UIColor whiteColor],UITextAttributeTextColor,[UIFont fontWithName:[self navigationBarFontName] size:13.0f],UITextAttributeFont,
                                                                       nil] forState:UIControlStateNormal];
        
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                        [UIColor whiteColor],UITextAttributeTextColor,[UIFont fontWithName:[self navigationBarFontName] size:13.0f],UITextAttributeFont,
                                                                        nil] forState:UIControlStateNormal];
        
        [self.navigationItem.backBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                       [UIColor whiteColor],UITextAttributeTextColor,[UIFont fontWithName:[self navigationBarFontName] size:13.0f],UITextAttributeFont,
                                                                       nil] forState:UIControlStateNormal];
        
        // uncomment this if you want to use your own back button image
        //[self.navigationItem setHidesBackButton:YES];
        //[self addABackButton]; <- only add this in a view controller you want a custom back button for
    }
    else
    {
        // add these items to your view controller in storyboard or nib and wire them up to these IBOutlets
        if (self.cancelButton)
        {
            
            [self.cancelButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor],UITextAttributeTextColor,[UIFont fontWithName:[self navigationBarFontName] size:13.0f],UITextAttributeFont,
                                                       nil] forState:UIControlStateNormal];
        }
        
        if (self.doneButton)
        {
            [self.doneButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                     [UIColor whiteColor],UITextAttributeTextColor,[UIFont fontWithName:[self navigationBarFontName] size:13.0f],UITextAttributeFont,
                                                     nil] forState:UIControlStateNormal];
        }
        
        if (self.navigationItemLabel)
        {
            CGFloat navigationItemLabelFontPointSize = self.navigationItemLabel.font.pointSize;
            [self.navigationItemLabel setFont:[UIFont fontWithName:[self navigationBarFontName] size:navigationItemLabelFontPointSize]];
        }
    }
}



#pragma mark SEGUE

// GO BACK TO THE PREVIOUS VIEW CONTROLLER
- (void)goBackOneViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark ALERTS

// SHOW A WARNING
- (void)showAWarningWithTag:(int)tag
{
    NSString *warningString;
    
    switch (tag)
    {
        case 0:
            warningString = @"No network connection detected";
            break;
        case 1:
            warningString = @"Server may be down or invalid data sent";
            break;
        case 2:
            warningString = @"Network required to show locations";
            break;
        case 3:
            warningString = @"Push notifications disabled for this app";
            break;
        case 4:
            warningString = @"Access to AddressBook required";
            break;
        case 5:
            warningString = @"Access to Events required";
            break;
        default:
            warningString = @"Unknown issue detected";
            break;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[self appName] message:warningString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alertView show];
}



#pragma mark STRING EDITING

// STRIP ALL BUT NUMBERS FROM A STRING
- (NSMutableString *)removeAllButNumbersFromString:(NSString *)string
{
    NSMutableString *parsedString = [NSMutableString stringWithCapacity:string.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO)
    {
        NSString *buffer;
        
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer])
        {
            [parsedString appendString:buffer];
            
        }
        else
        {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    
    return parsedString;
}



#pragma mark UI TOUCH

// CANCEL AND CLOSE THE VIEW
- (IBAction)cancelButtonTouched
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    //appDelegate = (Your-App-Delegate *)[[UIApplication sharedApplication] delegate];
    [self drawTheScene];
}

@end
