//
//  PAYValidationsViewController.m
//  Example
//
//  Created by Simon Seyer on 25.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYValidationsViewController.h"
#import "PAYFormSingleLineTextField.h"
#import "PAYFormSwitch.h"

@interface PAYValidationsViewController ()

@end

@implementation PAYValidationsViewController

- (void)loadStructure:(id<PAYTableBuilder>)tableBuilder {
    // See PAYAppDelegate for default error messages
    
    [tableBuilder addSectionWithName:nil
                          labelStyle:PAYFormTableLabelStyleNone
                        contentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
                            [sectionBuilder addFieldWithName:@"Required" placeholder:@"needs to be filled"
                                              configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                  formField.isRequired = YES;
                                              }];
                            
                            [sectionBuilder addFieldWithName:@"Min/Max" placeholder:@"xxx[xxx]"
                                              configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                  formField.minTextLength = 3;
                                                  formField.maxTextLength = 6;
                                                  formField.mayExceedMaxLength = YES;
                                              }];
                            [sectionBuilder addSwitchWithName:@"Required" configureBlock:^(PAYFormSwitch *formSwitch) {
                                formSwitch.isRequired = YES;
                            }];
                            [sectionBuilder addFieldWithName:@"Number" placeholder:@"only numbers allowed"
                                              configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                  formField.validationBlock = ^NSError *(PAYFormField *formField){
                                                      NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                                                      NSNumber *number = [formatter numberFromString:formField.value];
                                                      if (!!number) {
                                                          return nil;
                                                      } else {
                                                          return [formField validationErrorWithTitle:@"No integer"
                                                                                             message:@"Please enter an integer to field %@."];
                                                      }
                                                  };
                                              }];
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
