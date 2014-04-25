//
//  PAYAppDelegate.m
//  Example
//
//  Created by Simon Seyer on 08.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYAppDelegate.h"
#import "PAYFormDefaultErrorHandler.h"
#import "PAYFormSwitch.h"
#import "PAYFormView+PAYFormDefaultErrorHandler.h"
#import "PAYFormTextField.h"

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
    [PAYFormTextField setErrorMessage:[PAYFormErrorMessage errorMessageWithTitleBlock:^NSString *(id<PAYValidatableFormCell> formCell) {
        return @"To short";
    } messageBlock:^NSString *(id<PAYValidatableFormCell> formCell) {
        PAYFormTextField *textField = (PAYFormTextField *)formCell;
        return [NSString stringWithFormat:@"Content of field %%@ is to short. Please enter a minimum of %i characters", textField.minTextLength];
    }]
                                   forErrorCode:PAYFormTextFieldBelowMinLengthErrorCode];
    [PAYFormSwitch setErrorMessage:[PAYFormErrorMessage errorMessageWithTitle:@"Missing"
                                                                      message:@"Please check %@"]
                      forErrorCode:PAYFormMissingErrorCode];
    
    return YES;
}


@end
