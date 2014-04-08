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

@interface PAYMainViewController ()

@property (nonatomic, retain) PAYFormSingleLineTextField *streetTextField;
@property (nonatomic, retain) PAYFormSingleLineTextField *postalCodeTextField;
@property (nonatomic, retain) PAYFormSingleLineTextField *cityTextField;
@property (nonatomic, retain) PAYFormSection *countrySection;

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
            NSArray *countries = @[@[@"United States", @"usa"], @[@"Germany", @"de"], @[@"Spain", @"es"]];
            for (NSArray *country in countries) {
                [sectionBuilder addButtonWithText:country[0] style:PAYFormButtonStyleIconSelection
                                   selectionBlock:^(PAYFormView *formButton) {
                                       
                                       
                                   }
                                   configureBlock:^(PAYFormButton *formButton) {
                                       if ([country[0] isEqualToString:@"United States"]) {
                                           [formButton requestSelection];
                                       }
                                       formButton.iconView.image = [UIImage imageNamed:country[1]];
                                   }];
            }
            
        }];
        
        tableBuilder.finishOnLastField = YES;
        tableBuilder.selectFirstField = YES;
        tableBuilder.formSuccessBlock = ^{
            [self performSegueWithIdentifier:@"next" sender:self];
        };
    }];
}


@end
