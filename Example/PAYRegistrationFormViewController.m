//
//  PAYMainViewController.m
//  Example
//
//  Created by Simon Seyer on 08.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYRegistrationFormViewController.h"

@interface PAYRegistrationFormViewController ()


@property (nonatomic, retain) PAYFormSingleLineTextField *userNameField;
@property (nonatomic, retain) PAYFormSingleLineTextField *passwordField1;
@property (nonatomic, retain) PAYFormSingleLineTextField *passwordField2;

@property (nonatomic, retain) PAYFormSingleLineTextField *streetTextField;
@property (nonatomic, retain) PAYFormSingleLineTextField *postalCodeTextField;
@property (nonatomic, retain) PAYFormSingleLineTextField *cityTextField;

@property (nonatomic, retain) PAYFormButtonGroup *countryButtonGroup;
@property (nonatomic, retain) PAYFormSwitch *formSwitch;

@end

@implementation PAYRegistrationFormViewController


- (void)loadStructure:(PAYFormTableBuilder *)tableBuilder {
    
    
    [tableBuilder addSectionWithName:nil
                          labelStyle:PAYFormTableLabelStyleNone
                        contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
        self.userNameField = [sectionBuilder addFieldWithName:@"Username" placeholder:@"your username"
                                               configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                   formField.required = YES;
                                                   formField.minTextLength = 4;
                                                   formField.textField.accessibilityLabel = @"usernameField";
                                                   formField.textField.isAccessibilityElement = YES;
                                               }];
        
        self.passwordField1 = [sectionBuilder addFieldWithName:@"Password" placeholder:@"your password"
                                                configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                    [formField activateSecureInput];
                                                    formField.textField.accessibilityLabel = @"passwordField";
                                                    formField.textField.isAccessibilityElement = YES;
                                                }];
        self.passwordField2 = [sectionBuilder addFieldWithName:@"Password 2" placeholder:@"repeat your password"
                                                configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                    [formField activateSecureInput];
                                                    formField.textField.accessibilityLabel = @"password2Field";
                                                    formField.textField.isAccessibilityElement = YES;
                                                }];
    }];
    
    [tableBuilder addSectionWithName:@"Country"
                          labelStyle:PAYFormTableLabelStyleSimple
                        contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
                            self.countryButtonGroup = [sectionBuilder addButtonGroupWithMultiSelection:NO
                                contentBlock:^(PAYFormButtonGroupBuilder *buttonGroupBuilder) {
                                    NSArray *countries = @[@[@"United States", @"usa"], @[@"Germany", @"de"], @[@"Spain", @"es"]];
                                    for (NSArray *country in countries) {
                                        [buttonGroupBuilder addOption:country[1] withText:country[0] icon:[UIImage imageNamed:country[1]]];
                                    }
                                    [buttonGroupBuilder select:@"usa"];
                                }];
                            [self.countryButtonGroup select:YES value:@"usa"];
                        }];
    
    [tableBuilder addSectionWithName:@"Address"
                          labelStyle:PAYFormTableLabelStyleSimple
                        contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
        self.streetTextField = [sectionBuilder addFieldWithName:@"Street" placeholder:@"your street"
                                                 configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                     formField.required = YES;
                                                     formField.expanding  = YES;
                                                     formField.textField.accessibilityLabel = @"streetField";
                                                     formField.textField.isAccessibilityElement = YES;
                                                 }];
        
        self.postalCodeTextField = [sectionBuilder addFieldWithName:@"Postal code" placeholder:@"your postal code"
                                                     configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                         formField.required = YES;
                                                         formField.cleanBlock = ^id(PAYFormField *formField, id value) {
                                                             NSString *strValue = value;
                                                             return [strValue stringByReplacingOccurrencesOfString:@" " withString:@""];
                                                         };
                                                         formField.textField.accessibilityLabel = @"postalCodeField";
                                                         formField.textField.isAccessibilityElement = YES;
                                                     }];
        self.cityTextField = [sectionBuilder addFieldWithName:@"City" placeholder:@"your city"
                                               configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                   formField.required = YES;
                                                   formField.textField.accessibilityLabel = @"cityField";
                                                   formField.textField.isAccessibilityElement = YES;
                                               }];
    }];
    
   
    
    [tableBuilder addSectionWithName:@"Terms and Conditions" contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
        self.formSwitch = [sectionBuilder addSwitchWithName:@"Accept"
                                             configureBlock:^(PAYFormSwitch *formSwitch) {
                                                 formSwitch.required = YES;
                                                 
                                                 [formSwitch setErrorMessage:[PAYFormErrorMessage errorMessageWithTitle:@"Accept"
                                                                                                                message:@"Please accept the terms and conditions to continue"]
                                                                forErrorCode:PAYFormMissingErrorCode];
                                                 formSwitch.switchControl.accessibilityLabel = @"termsSwitch";
                                                 formSwitch.switchControl.isAccessibilityElement = YES;
                                             }];
    }];
    
    tableBuilder.finishOnLastField = YES;
    tableBuilder.selectFirstField = YES;
    
    tableBuilder.validationBlock =  ^NSError *{
        if (![self.passwordField1.value isEqualToString:self.passwordField2.value]) {
            return [NSError validationErrorWithTitle:@"Password wrong" message:@"Please enter the same password again" control:self.passwordField2];
        }
        return nil;
    };
    
    tableBuilder.formSuccessBlock = ^{
        NSString *msg = [NSString stringWithFormat:@"Well done, %@. Here your cleaned postal code: %@. Country code: %@",
                         self.userNameField.value, self.postalCodeTextField.cleanedValue, self.countryButtonGroup.value];
        
        UIAlertView *alertView  = [[UIAlertView alloc]initWithTitle:@"Success"
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles: nil];
        [alertView show];
    };
}


@end
