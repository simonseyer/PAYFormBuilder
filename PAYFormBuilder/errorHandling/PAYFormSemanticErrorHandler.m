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
#import "PAYFormErrorStyler.h"
#import "UITableViewCell+ScrollInset.h"
#import "A2DynamicDelegate.h"

static char popUpKey;

@interface PAYFormSemanticErrorHandler ()

@property (nonatomic, retain) PAYFormErrorStyler *styler;

@end


@implementation PAYFormSemanticErrorHandler

- (instancetype)init {
    self = [super init];
    if (self) {
        self.styler = [PAYFormErrorStyler new];
    }
    return self;
}

- (BOOL)handleErrors:(NSArray *)errors {
    BOOL first = YES;
    for (NSError *error in errors) {
        if ([error.field conformsToProtocol:@protocol(PAYFormRow) ]) {
            id<PAYFormRow, PAYValidatableFormCell> formRow = (id<PAYFormRow,PAYValidatableFormCell>)error.field;
            [self.styler styleField:formRow];
            
            PAYFormErrorMessage *errorMessage = [PAYFormErrorMessageManager errorMessageForError:error];
            NSString *msg = [errorMessage messageForField:error.field];
            
            BOOL isTextField = [formRow isKindOfClass:PAYFormTextField.class];
            if (first || !isTextField) {
                [self showMessage:msg forField:formRow];
            }
            if (isTextField) {
                if ([formRow isKindOfClass:PAYFormSingleLineTextField.class]) {
                    UITextField *textField = ((PAYFormSingleLineTextField *)formRow).textField;
                    
                    [textField bk_addEventHandler:^(id sender) {
                        [self showMessage:msg forField:formRow];
                    } forControlEvents:UIControlEventEditingDidBegin];
                    [textField bk_addEventHandler:^(id sender) {
                        [self hideMessageForField:formRow];
                    } forControlEvents:UIControlEventEditingDidEnd];
                } else if ([formRow isKindOfClass:PAYFormMultiLineTextField.class]) {
                    UITextView *textView = ((PAYFormMultiLineTextField *)formRow).textView;
                    
                    A2DynamicDelegate *dd = textView.bk_dynamicDelegate;
                    [dd implementMethod:@selector(textViewDidBeginEditing:) withBlock:^(UITextView *textView) {
                        [self showMessage:msg forField:formRow];
                    }];
                    [dd implementMethod:@selector(textViewDidEndEditing:) withBlock:^(UITextView *textView) {
                        [self hideMessageForField:formRow];
                    }];
                    
                    // TODO: Overrites delegates from the user
                    ((PAYFormMultiLineTextField *)formRow).delegate = (id<UITextViewDelegate>)dd;
                }
            }
            if (first) {
                [formRow becomeFirstResponder];
                first = NO;
            }
        }
    }
    
    return NO;
}

- (void)showMessage:(NSString *)msg forField:(id<PAYFormRow, PAYValidatableFormCell>)formRow{
    // Preventing the popup to appear twice
    if (objc_getAssociatedObject(formRow, &popUpKey)) {
        return;
    }
    
    AMPopTip *popTip = [AMPopTip popTip];
    popTip.edgeInsets = UIEdgeInsetsMake(0, 30, 0, 30);
    [popTip showText:msg
           direction:AMPopTipDirectionDown
            maxWidth:formRow.view.frame.size.width - 120
              inView:formRow.view
           fromFrame:CGRectMake(0, formRow.view.frame.size.height, formRow.view.frame.size.width, 0)];
    objc_setAssociatedObject(formRow, &popUpKey, popTip, OBJC_ASSOCIATION_RETAIN);
    
    // TODO: dynamic offset
    formRow.view.scrollInsets = UIEdgeInsetsMake(0, 0, 60, 0);
    if (formRow.section.views.lastObject == formRow) {
        formRow.section.footerHeight = 30;
    }
    
    
    @weakify(formRow);
    [formRow.validationResetBlocks addObject:^{
        @strongify(formRow);
        [self hideMessageForField:formRow];
        if ([formRow isKindOfClass:PAYFormSingleLineTextField.class]) {
            UITextField *textField = ((PAYFormSingleLineTextField *)formRow).textField;
            
            [textField bk_removeEventHandlersForControlEvents:UIControlEventEditingDidBegin];
            [textField bk_removeEventHandlersForControlEvents:UIControlEventEditingDidEnd];
        } else if ([formRow isKindOfClass:PAYFormMultiLineTextField.class]) {
            UITextView *textView = ((PAYFormMultiLineTextField *)formRow).textView;
            textView.delegate = nil;
        }
    }];
}

- (void)hideMessageForField :(id<PAYFormRow, PAYValidatableFormCell>)formRow {
    AMPopTip *popTip = objc_getAssociatedObject(formRow, &popUpKey);
    [popTip hide];
    objc_setAssociatedObject(formRow, &popUpKey, nil, OBJC_ASSOCIATION_RETAIN);
    
    formRow.section.footerHeight = 0;
    formRow.view.scrollInsets = UIEdgeInsetsMake(0, 0, 0, 0);
}


@end
