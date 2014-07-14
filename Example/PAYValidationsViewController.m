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

- (void)loadStructure:(id<PAYTableBuilder>)tableBuilder {
    // See PAYAppDelegate for default error messages
    
    [tableBuilder addSectionWithLabelStyle:PAYFormTableLabelStyleNone
                        contentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
                            [sectionBuilder addFieldWithName:@"Required" placeholder:@"needs to be filled"
                                              configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                  formField.isRequired = YES;
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
                                formSwitch.isRequired = YES;
                                formSwitch.switchControl.accessibilityLabel = @"requiredSwitch";
                                formSwitch.switchControl.isAccessibilityElement = YES;
                            }];
                            [sectionBuilder addFieldWithName:@"Number" placeholder:@"only numbers allowed"
                                              configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                  formField.validationBlock = PAYValidation.integerValidationBlock;
                                                  formField.textField.accessibilityLabel = @"integerValidationField";
                                                  formField.textField.isAccessibilityElement = YES;
                                              }];
                            
                        }];
    [tableBuilder addSectionWithName:@"Required button group" contentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
        [sectionBuilder addButtonGroupWithMultiSelection:NO contentBlock:^(id<PAYButtonGroupBuilder> groupBuilder) {
            PAYFormButton *button0 = [groupBuilder addOption:@0 withText:@"Option 1"];
            button0.accessibilityLabel = @"option1";
            button0.isAccessibilityElement = YES;
            [groupBuilder addOption:@1 withText:@"Option 2"];
            groupBuilder.isRequired = YES;
        }];
    }];
    [tableBuilder addSectionWithLabelStyle:PAYFormTableLabelStyleNone contentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
        [sectionBuilder addButtonWithText:@"Done"
                                    style:PAYFormButtonStylePrimaryCentered
                           selectionBlock:^(PAYFormButton *formButton) {
                               [self onDone:formButton];
                           }];
    }];
    
    tableBuilder.validationBlock =  ^NSError *{
        // Here you could add a validation for the complete form
        return nil;
    };
    tableBuilder.formSuccessBlock = ^{
        UIAlertView *alertView  = [[UIAlertView alloc]initWithTitle:@"Success"
                                                            message:@"Well done!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles: nil];
        [alertView show];
    };
    
}


@end
