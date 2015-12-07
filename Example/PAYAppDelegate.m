//
//  PAYAppDelegate.m
//  Example
//
//  Created by Simon Seyer on 08.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYAppDelegate.h"

@implementation PAYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    // Configure table builder default error messages
    [PAYFormDefaultErrorHandler setButtonText:@"Ok"];
    [PAYFormDefaultErrorHandler setErrorMessage:[PAYFormErrorMessage errorMessageWithTitle:@"Missing"
                                                                                   message:@"Field %@ is missing"]
                                   forErrorCode:PAYFormMissingErrorCode];
    [PAYFormDefaultErrorHandler setErrorMessage:[PAYFormErrorMessage errorMessageWithTitle:@"To long"
                                                                                   message:@"Content of field %@ is to long"]
                                   forErrorCode:PAYFormTextFieldAboveMaxLengthErrorCode];
    [PAYFormTextField setErrorMessage:[PAYFormErrorMessage errorMessageWithTitleBlock:^NSString *(id formView) {
        return @"To short";
    } messageBlock:^NSString *(id formView) {
        PAYFormTextField *textField = (PAYFormTextField *)formView;
        return [NSString stringWithFormat:@"Content of field %%@ is to short. Please enter a minimum of %tu characters", textField.minTextLength];
    }]
                         forErrorCode:PAYFormTextFieldBelowMinLengthErrorCode];
    [PAYFormTextField setErrorMessage:[PAYFormErrorMessage errorMessageWithTitleBlock:^NSString *(id formView) {
        return @"To long";
    } messageBlock:^NSString *(id formView) {
        PAYFormTextField *textField = (PAYFormTextField *)formView;
        return [NSString stringWithFormat:@"Content of field %%@ is to long. Please enter a maximum of %tu characters", textField.maxTextLength];
    }]
                         forErrorCode:PAYFormTextFieldAboveMaxLengthErrorCode];
    
    [PAYFormField setErrorMessage:[PAYFormErrorMessage errorMessageWithTitle:@"No integer" message:@"Please enter an integer to field %@."]
                     forErrorCode:PAYFormIntegerValidationErrorCode];
    
    [PAYFormSwitch setErrorMessage:[PAYFormErrorMessage errorMessageWithTitle:@"Missing" message:@"Please check %@"]
                      forErrorCode:PAYFormMissingErrorCode];
    
    [PAYFormDefaultErrorHandler setParentViewController:self.window.rootViewController];
    
    return YES;
}


@end
