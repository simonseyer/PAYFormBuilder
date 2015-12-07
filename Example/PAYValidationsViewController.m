//
//  PAYValidationsViewController.m
//  Example
//
//  Created by Simon Seyer on 25.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYValidationsViewController.h"


@interface PAYValidationsViewController ()

@end

@implementation PAYValidationsViewController

- (void)loadStructure:(PAYFormTableBuilder *)tableBuilder {
    // See PAYAppDelegate for default error messages
    
    [tableBuilder addSectionWithLabelStyle:PAYFormTableLabelStyleNone
                        contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
                            [sectionBuilder addFieldWithName:@"Required" placeholder:@"needs to be filled"
                                              configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                  formField.required = YES;
                                                  formField.textField.accessibilityLabel = @"requiredField";
                                                  formField.textField.isAccessibilityElement = YES;
                                              }];
                            
                            [sectionBuilder addFieldWithName:@"Min/Max" placeholder:@"xxx[xxx]"
                                              configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                  formField.minTextLength = 3;
                                                  formField.maxTextLength = 6;
                                                  formField.mayExceedMaxLength = YES;
                                                  formField.textField.accessibilityLabel = @"minMaxField";
                                                  formField.textField.isAccessibilityElement = YES;
                                              }];
                            [sectionBuilder addSwitchWithName:@"Required" configureBlock:^(PAYFormSwitch *formSwitch) {
                                formSwitch.required = YES;
                                formSwitch.switchControl.accessibilityLabel = @"requiredSwitch";
                                formSwitch.switchControl.isAccessibilityElement = YES;
                            }];
                            [sectionBuilder addFieldWithName:@"Number" placeholder:@"only numbers allowed"
                                              configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                  formField.validationBlock = PAYValidation.integerValidationBlock;
                                                  formField.cleanBlock = (id)^(PAYFormField *formField, NSString *value) {
                                                      return [value stringByReplacingOccurrencesOfString:@" " withString:@""];
                                                  };
                                                  formField.textField.accessibilityLabel = @"integerValidationField";
                                                  formField.textField.isAccessibilityElement = YES;
                                              }];
                            
                        }];
    [tableBuilder addSectionWithName:@"Required button group" contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
        [sectionBuilder addButtonGroupWithMultiSelection:NO contentBlock:^(PAYFormButtonGroupBuilder *groupBuilder) {
            PAYFormButton *button0 = [groupBuilder addOption:@0 withText:@"Option 1"];
            button0.view.accessibilityLabel = @"option1";
            button0.view.isAccessibilityElement = YES;
            [groupBuilder addOption:@1 withText:@"Option 2"];
            groupBuilder.required = YES;
        }];
    }];
    [tableBuilder addSectionWithName:@"Required text view" contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
        [sectionBuilder addTextViewWithPlaceholder:@"Required" configureBlock:^(PAYFormMultiLineTextField *textView) {
            textView.required = YES;
            textView.textView.accessibilityLabel = @"textView";
            textView.textView.isAccessibilityElement = YES;
        }];
    }];
    [tableBuilder addSectionWithLabelStyle:PAYFormTableLabelStyleNone contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
        [sectionBuilder addButtonWithText:@"Done"
                                    style:PAYFormButtonStylePrimary
                           selectionBlock:^(PAYFormButton *formButton) {
                               [self onDone:formButton];
                           }];
    }];
    
    tableBuilder.validationBlock =  ^NSError *{
        // Here you could add a validation for the complete form
        return nil;
    };
    tableBuilder.formSuccessBlock = ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success"
                                                                                 message:@"Well done!"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    };
    
}


@end
