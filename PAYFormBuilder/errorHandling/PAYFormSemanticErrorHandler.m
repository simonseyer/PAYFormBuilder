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
#import "PAYFormTextField.h"
#import "PAYFormSingleLineTextField.h"
#import "PAYFormMultiLineTextField.h"
#import <BlocksKit/BlocksKit.h>
#import <BlocksKit/UIControl+BlocksKit.h>
#import <objc/runtime.h>
#import <libextobjc/extobjc.h>

static char messageKey;
static char popUpKey;

@implementation PAYFormSemanticErrorHandler

- (BOOL)handleErrors:(NSArray *)errors {
    BOOL first = YES;
    for (NSError *error in errors) {
        if ([error.field conformsToProtocol:@protocol(PAYFormRow) ]) {
            id<PAYFormRow, PAYValidatableFormCell> formRow = (id<PAYFormRow,PAYValidatableFormCell>)error.field;
            
            PAYFormErrorMessage *errorMessage = [PAYFormErrorMessageManager errorMessageForError:error];
            NSString *msg = [errorMessage messageForField:error.field];
            objc_setAssociatedObject(formRow, &messageKey, msg, OBJC_ASSOCIATION_RETAIN);
            
            BOOL isTextField = [formRow isKindOfClass:PAYFormTextField.class];
            if (first || !isTextField) {
                [self showMessageforField:formRow];
            }
            if (isTextField) {
                UIControl *control = (UIControl *)((PAYFormField *)formRow).control;
                [control bk_addEventHandler:^(id sender) {
                    [self showMessageforField:formRow];
                } forControlEvents:UIControlEventEditingDidBegin];
                [control bk_addEventHandler:^(id sender) {
                    [self hideMessageForField:formRow];
                } forControlEvents:UIControlEventEditingDidEnd];
            }
            if (first) {
                [formRow becomeFirstResponder];
                first = NO;
            }
        }
    }
    
    return NO;
}

- (void)showMessageforField:(id<PAYFormRow, PAYValidatableFormCell>)formRow {
    NSString *msg = objc_getAssociatedObject(formRow, &messageKey);
    
    AMPopTip *popTip = [AMPopTip popTip];
    popTip.edgeInsets = UIEdgeInsetsMake(0, 30, 0, 30);
    [popTip showText:msg
           direction:AMPopTipDirectionDown
            maxWidth:formRow.view.frame.size.width - 120
              inView:formRow.view.superview
           fromFrame:formRow.view.frame];
    objc_setAssociatedObject(formRow, &popUpKey, popTip, OBJC_ASSOCIATION_RETAIN);
    
    @weakify(formRow);
    formRow.validationResetBlock = ^{
        @strongify(formRow);
        [self hideMessageForField:formRow];
        objc_setAssociatedObject(formRow, &messageKey, nil, OBJC_ASSOCIATION_RETAIN);
    };
}

- (void)hideMessageForField :(id<PAYFormRow, PAYValidatableFormCell>)formRow {
    AMPopTip *popTip = objc_getAssociatedObject(formRow, &popUpKey);
    [popTip hide];
    objc_setAssociatedObject(formRow, &popUpKey, nil, OBJC_ASSOCIATION_RETAIN);
}


@end
