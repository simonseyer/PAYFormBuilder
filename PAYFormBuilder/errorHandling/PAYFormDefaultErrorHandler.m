//
//  DefaultErrorHandler.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormDefaultErrorHandler.h"
#import "NSError+PAYComfort.h"

#import "PAYFormView+PAYFormDefaultErrorHandlerProtected.h"
#import "PAYFormView_protected.h"
#import "PAYFormErrorMessage.h"
#import "PAYFormErrorMessage_protected.h"



@implementation PAYFormDefaultErrorHandler

static NSMutableDictionary *errorMessages;
static UIViewController *parentViewController;

+ (void)initialize {
    errorMessages = [NSMutableDictionary new];
}

+ (void)setErrorMessage:(PAYFormErrorMessage *)errorMessage forErrorCode:(NSUInteger)code {
    errorMessages[@(code)] = errorMessage;
}

+ (void)setParentViewController:(UIViewController *)viewController {
    parentViewController = viewController;
}

static NSString *buttonText;
+ (void)setButtonText:(NSString *)text {
    buttonText = text;
}

+ (NSString *)buttonText {
    return buttonText;
}

+ (PAYFormTableFailBlock)failBlock {
    return ^BOOL(NSError *error) {
        NSAssert(buttonText, @"The button text of the default error handler has to be set, when it is used to show error messages");
        NSAssert(parentViewController, @"A parent view controller has to be set when using the DefaultErrorHandler");
        
        PAYFormErrorMessage *errorMessage = [PAYFormErrorMessage errorMessageWithError:error];
        if (!errorMessage) {
            if ([error.field isKindOfClass:PAYFormView.class]) {
                 errorMessage = [(PAYFormView *)error.field errorMessageForErrorCode:error.code];
            }
        }
        if (!errorMessage) {
            errorMessage = errorMessages[@(error.code)];
        }
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[errorMessage titleForField:error.field]
                                                                                 message:[errorMessage messageForField:error.field]
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:buttonText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([error.field isKindOfClass:PAYFormView.class]) {
                [(PAYFormView *)error.field becomeFirstResponder];
            }
        }]];
        [parentViewController presentViewController:alertController animated:YES completion:nil];

        return NO;
    };
}

@end
