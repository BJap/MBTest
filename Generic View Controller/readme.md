GENERIC VIEW CONTROLLER
=======================

About
-----

I decided to create this class to access many repeated or commonly used pieces of information, tasks, or do drawing for my entire apps. It's one place to come and edit values used over the entire app if this class is used to its fullest potential.

Usage
-----

To use it, add this class to your project, and subclass every one of your top-level view controllers with it.

Features
--------------
- useful dimensions to have when placing and manipulating items on the screen
**screenWidth**
**screenHeight**

- good to have for a UILabel to keep track of app info from the Target Summary page
**appName**
**appVersion**

- since iOS 5 with iMessage checking sms capability isn't enough anymore to detect an iPhone this checks more accurately
**deviceIsAnIphone**

- these automatically halt the application for iOS 6 onward until the user responds or for iOS 5 and earlier simply respond 'true'
**accessGrantedToAddressBook**
**accessGrantedToCalendar**

- allows a one-stop place to set the font style for the navigation bar or the rest of the app separately. also allows you to set the background color for the entire app. you can add your own additional methods for repeatedly used colors and their descriptions following this methods which you may add as you see fit
**navigationBarFontName**
**appFontName**
**viewBackgroundColor**

- these two methods allow you to customize a UINavigationController with a custom back button style or any title style you like. you should call the [self.navigationItem setHidesBackButton:YES animated:NO] method if you do or add it to the addABackButtonMethod
**addABackButton**
**customizeNavigationBarWithTitle: title**

- you can hand a button or label to these methods with a custom font and it will modify the labels accordingly to that font
**customizeButton: button withFontName: fontName**
**customizeUILabel: label withFontName: fontName**

- a place to do all the work and further subclass down the hierarchy to draw the interface common elements and add more to it in child view controllers. remember to call [super drawTheScene] if you do this
**drawTheScene**

- this can be used on its own in a UINavigationController (not modal view) setup to navigate backward and is also used as the target for the addABackButton method button
**goBackOneViewController**

- I have included some general warnings here that most apps will use. you may add as many others as you like. this way you only need to call a warning in one simple line by tag. you can modify this to send a warning to your own alert object instead of UIAlertView
**showAWarningWithTag: tag**

- wire your modal view cancel/back buttons to this
**cancelButtonTouched**

- in modal views wire your navigation bar and items to this and the drawTheScene method will do the rest for you
**cancelButton**
**doneButton**
**navigationBar**
**navigationItemLabel**


License
-------

Made available under the MIT License. Mention my name if you would.

Collaboration
-------------

Feel free to contact me with request or questions. I am open to constructive feedback as well.