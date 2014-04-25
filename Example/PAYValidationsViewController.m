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
    [tableBuilder addSectionWithName:nil
                          labelStyle:PAYFormTableLabelStyleNone
                        contentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
                            [sectionBuilder addFieldWithName:@"Required" placeholder:@"needs to be filled"
                                              configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                  formField.isRequired = YES;
                                              }];
                            
                            [sectionBuilder addFieldWithName:@"Min/Max length" placeholder:@"xxx[xxx]"
                                              configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                  formField.minTextLength = 3;
                                                  formField.maxTextLength = 6;
                                                  formField.mayExceedMaxLength = YES;
                                              }];
                            [sectionBuilder addSwitchWithName:@"Required" configureBlock:^(PAYFormSwitch *formSwitch) {
                                formSwitch.isRequired = YES;
                            }];
                            [sectionBuilder addFieldWithName:@"Number" placeholder:@"only numbers allowd"
                                              configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                  formField.validationBlock = ^NSError *(PAYFormField *formField){
                                                      NSScanner* scan = [NSScanner scannerWithString:formField.value];
                                                      if ([scan scanInt:nil]) {
                                                          return nil;
                                                      } else {
                                                          return [formField validationErrorWithTitle:@"No integer"
                                                                                             message:@"Please enter an integer to field %@"];
                                                      }
                                                  };
                                              }];
                            [sectionBuilder addButtonWithText:@"Done"
                                                        style:PAYFormButtonStylePrimaryCentered
                                               selectionBlock:^(PAYFormButton *formButton) {
                                                   [self onDone:formButton];
                            }];
                        }];
    
    tableBuilder.selectFirstField = YES;
    tableBuilder.finishOnLastField = YES;
    tableBuilder.validationBlock =  ^NSError *{
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
