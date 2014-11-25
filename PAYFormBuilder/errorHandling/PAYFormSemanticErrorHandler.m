//
//  PAYFormSemanticErrorHandler.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 25.11.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormSemanticErrorHandler.h"
#import "PAYFormErrorMessage_protected.h"
#import <AMPopTip/AMPopTip.h>
#import "NSError+PAYComfort.h"
#import "PAYFormRow.h"
#import "PAYFormErrorMessageManager_protected.h"


@implementation PAYFormSemanticErrorHandler

- (BOOL)handleErrors:(NSArray *)errors {
    for (NSError *error in errors) {
        if ([error.field conformsToProtocol:@protocol(PAYFormRow) ]) {
            id<PAYFormRow, PAYValidatableFormCell> formRow = (id<PAYFormRow,PAYValidatableFormCell>)error.field;
            PAYFormErrorMessage *errorMessage = [PAYFormErrorMessageManager errorMessageForError:error];
            
            __block AMPopTip *popTip = [AMPopTip popTip];
            popTip.edgeInsets = UIEdgeInsetsMake(0, 30, 0, 30);
            [popTip showText:[errorMessage messageForField:error.field]
                        direction:AMPopTipDirectionDown
                         maxWidth:200
                           inView:formRow.view.superview
                        fromFrame:formRow.view.frame];
            formRow.validationResetBlock = ^{
                [popTip hide];
                popTip = nil;
            };
        }
    }
    
    return NO;
}

@end
