//
//  PAYMainViewController.m
//  Example
//
//  Created by Simon Seyer on 08.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYMainViewController.h"
#import <PAYFormSingleLineTextField.h>
#import <PAYFormButton.h>
#import <PAYFormButtonGroup.h>
#import <PAYFormMultiLineTextField.h>
#import <PAYFormDefaultErrorHandler.h>
#import <PAYFormSwitch.h>
#import <PAYFormView+PAYFormDefaultErrorHandler.h>

@interface PAYMainViewController ()

@property (nonatomic, retain) PAYFormSingleLineTextField *streetTextField;
@property (nonatomic, retain) PAYFormSingleLineTextField *postalCodeTextField;
@property (nonatomic, retain) PAYFormSingleLineTextField *cityTextField;
@property (nonatomic, retain) PAYFormButtonGroup *countryButtonGroup;
@property (nonatomic, retain) PAYFormSwitch *formSwitch;

@end

@implementation PAYMainViewController


- (void)loadStructure {
    [PAYFormDefaultErrorHandler setErrorMessage:[PAYFormErrorMessage errorMessageWithTitle:@"Missing" message:@"Field %@ is missing"]
                                   forErrorCode:PAYFormMissingErrorCode];
    
    [self buildTableWithBlock:^(id<PAYTableBuilder> tableBuilder){
        [tableBuilder addSectionWithName:nil labelStyle:PAYFormTableLabelStyleNone contentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
            
            [sectionBuilder addFieldWithName:@"Username" placeholder:@"your username"
                                                     configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                         formField.isRequired = YES;
                                                     }];
            
            [sectionBuilder addFieldWithName:@"Password" placeholder:@"your password"
                                                         configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                             [formField activateSecureInput];
                                                         }];
        }];
        
        [tableBuilder addSectionWithName:@"Adress" labelStyle:PAYFormTableLabelStyleSimple contentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
            
            self.streetTextField = [sectionBuilder addFieldWithName:@"Street" placeholder:@"your street"
                                                     configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                         formField.isRequired = YES;
                                                         formField.expanding  = YES;
                                                     }];
            
            self.postalCodeTextField = [sectionBuilder addFieldWithName:@"Postal code" placeholder:@"your postal code"
                                                         configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                             formField.isRequired = YES;
                                                             formField.textField.keyboardType = UIKeyboardTypeNumberPad;
                                                         }];
            self.cityTextField = [sectionBuilder addFieldWithName:@"City" placeholder:@"your city"
                                                   configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                       formField.isRequired = YES;
                                                   }];
        }];
        
        [tableBuilder addSectionWithName:@"Country" labelStyle:PAYFormTableLabelStyleSimple contentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
            self.countryButtonGroup = [sectionBuilder addButtonGroupWithMutliSelection:YES contentBlock:^(id<PAYButtonGroupBuilder> buttonGroupBuilder) {
                NSArray *countries = @[@[@"United States", @"usa"], @[@"Germany", @"de"], @[@"Spain", @"es"]];
                for (NSArray *country in countries) {
                    [buttonGroupBuilder addOption:country[1] withText:country[0]];
                }
                [buttonGroupBuilder select:@"usa"];
            }];
            [self.countryButtonGroup select:YES value:@"usa"];
            
            self.formSwitch = [sectionBuilder addSwitchWithName:@"Test" configureBlock:^(PAYFormSwitch *formSwitch) {
                formSwitch.isRequired = YES;
                
                [formSwitch setErrorMessage:[PAYFormErrorMessage errorMessageWithTitle:@"Accept AGB" message:@"Please accept the AGB to continue"]
                               forErrorCode:PAYFormMissingErrorCode];
            }];
        }];
        
        
        
        tableBuilder.finishOnLastField = YES;
        tableBuilder.selectFirstField = YES;
        tableBuilder.formSuccessBlock = ^{
            NSLog(@"%@", self.countryButtonGroup.values);
            NSLog(@"%@", self.formSwitch.value ? @"YES" : @"NO");
            [self performSegueWithIdentifier:@"next" sender:self];
        };
    }];
}


@end
