//
//  PAYFieldsViewController.m
//  Example
//
//  Created by Simon Seyer on 25.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFieldsViewController.h"

@interface PAYFieldsViewController ()

@end

@implementation PAYFieldsViewController


- (void)loadStructure:(PAYFormTableBuilder *)tableBuilder {

    [tableBuilder addSectionWithName:@"Simple fields"
                        contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
                            [sectionBuilder addFieldWithName:@"Simple field" placeholder:@"placeholder"];
                            [sectionBuilder addFieldWithPlaceholder:@"Full size field"];
                            [sectionBuilder addTextViewWithPlaceholder:@"Text view with placeholder"];
                            [sectionBuilder addTextViewWithPlaceholder:@"Adjustable Text view with placeholder" adjustable:YES];
                        }];
    
    [tableBuilder addSectionWithName:@"Advanced fields"
                        contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
                            [sectionBuilder addFieldWithName:@"Expanding"
                                                 placeholder:@"placeholder"
                                              configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                  formField.expanding = YES;
                                              }];
                            [sectionBuilder addFieldWithName:@"Formatted"
                                                 placeholder:@"xxx-xxx-xx"
                                              configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                  [formField setFormatTextWithGroupSizes:@[@3, @3, @2]
                                                                               separator:@"-"];
                                              }];
                            [sectionBuilder addFieldWithName:@"Limited"
                                                 placeholder:@"xxx"
                                              configureBlock:^(PAYFormSingleLineTextField *formField) {
                                                  formField.maxTextLength = 3;
                                                  formField.validateWhileEnter = YES;
                                              }];
                        }];
}


@end
