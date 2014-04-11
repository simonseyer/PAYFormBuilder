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

@interface PAYMainViewController ()

@property (nonatomic, retain) PAYFormSingleLineTextField *streetTextField;
@property (nonatomic, retain) PAYFormSingleLineTextField *postalCodeTextField;
@property (nonatomic, retain) PAYFormSingleLineTextField *cityTextField;
@property (nonatomic, retain) PAYFormButtonGroup *countryButtonGroup;

@end

@implementation PAYMainViewController


- (void)loadStructure {
    [self buildTableWithBlock:^(id<PAYTableBuilder> tableBuilder){
        [tableBuilder addSectionWithName:@"Adress" labelStyle:PAYFormTableLabelStyleSimple contentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
            
            self.streetTextField = [sectionBuilder addFieldWithName:@"Street" placeholder:@"your street"
                                                     configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                         formField.isRequired = YES;
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
        }];
        
        tableBuilder.finishOnLastField = YES;
        tableBuilder.selectFirstField = YES;
        tableBuilder.formSuccessBlock = ^{
            [self performSegueWithIdentifier:@"next" sender:self];
        };
    }];
}


@end
