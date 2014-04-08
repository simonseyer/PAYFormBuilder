//
//  PAYMainViewController.m
//  Example
//
//  Created by Simon Seyer on 08.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYMainViewController.h"
#import <PAYFormSingleLineTextField.h>

@interface PAYMainViewController ()

@end

@implementation PAYMainViewController


- (void)loadStructure {
    [self buildTableWithBlock:^(id<PAYTableBuilder> tableBuilder) {
        [tableBuilder addSectionWithName:@"Test" labelStyle:PAYFormTableLabelStyleSimple contentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
            [sectionBuilder addFieldWithName:@"Test" placeholder:@"Hallo" configureBlock:^(PAYFormSingleLineTextField *formField) {
                formField.isRequired = YES;
            }];
        }];
    }];
}


@end
