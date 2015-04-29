//
//  PAYButtonViewController.m
//  Example
//
//  Created by Simon Seyer on 25.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYControlsViewController.h"

@interface PAYControlsViewController ()

@end

@implementation PAYControlsViewController


- (void)loadStructure:(PAYFormTableBuilder *)tableBuilder {
    [tableBuilder addSectionWithName:@"Simple buttons"
                        contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
                            [sectionBuilder addButtonWithText:@"Default button"
                                                        style:PAYFormButtonStyleDefault
                                               selectionBlock:nil];
                            [sectionBuilder addButtonWithText:@"Disclosure button"
                                                        style:PAYFormButtonStyleDisclosure
                                               selectionBlock:nil];
                            [sectionBuilder addButtonWithText:@"Disclosure button"
                                                   detailText:@"with details"
                                                        style:PAYFormButtonStyleDisclosure
                                               selectionBlock:nil];
                            [sectionBuilder addButtonWithText:@"Selection button"
                                                        style:PAYFormButtonStyleSelection
                                               selectionBlock:nil];
                            [sectionBuilder addButtonWithText:@"Disclosure button with icon"
                                                         icon:[UIImage imageNamed:@"de"]
                                                        style:PAYFormButtonStyleDisclosure
                                               selectionBlock:nil];
                            [sectionBuilder addButtonWithText:@"Selection button with icon"
                                                         icon:[UIImage imageNamed:@"usa"]
                                                        style:PAYFormButtonStyleSelection
                                               selectionBlock:nil];
                        }];
    
    [tableBuilder addSectionWithContentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
        [sectionBuilder addButtonWithText:@"Centered button"
                                    style:PAYFormButtonStyleCentered
                           selectionBlock:nil];
    }];
    [tableBuilder addSectionWithContentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
        [sectionBuilder addButtonWithText:@"Primary button"
                                    style:PAYFormButtonStylePrimary
                           selectionBlock:nil];
    }];
    [tableBuilder addSectionWithContentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
        [sectionBuilder addButtonWithText:@"Hilighted button"
                                    style:PAYFormButtonStyleHilighted
                           selectionBlock:nil];
    }];
    
    NSArray *countries = @[@[@"United States", @"usa"], @[@"Germany", @"de"], @[@"Spain", @"es"]];
    
    [tableBuilder addSectionWithName:@"Single selection button group"
                        contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
                            [sectionBuilder addButtonGroupWithMultiSelection:NO
                                                                contentBlock:^(PAYFormButtonGroupBuilder *buttonGroupBuilder) {
                                                                    for (NSArray *country in countries) {
                                                                        [buttonGroupBuilder addOption:country[1]
                                                                                             withText:country[0]
                                                                                                 icon:[UIImage imageNamed:country[1]]];
                                                                    }
                                                                    [buttonGroupBuilder select:@"usa"];
                                                                }];
                        }];
    
    [tableBuilder addSectionWithName:@"Multi selection button group"
                        contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
                            [sectionBuilder addButtonGroupWithMultiSelection:YES
                                                                contentBlock:^(PAYFormButtonGroupBuilder *buttonGroupBuilder) {
                                                                    for (NSArray *country in countries) {
                                                                        [buttonGroupBuilder addOption:country[1]
                                                                                             withText:country[0]];
                                                                    }
                                                                    [buttonGroupBuilder select:@"usa"];
                                                                }];
                        }];
    
    [tableBuilder addSectionWithName:@"Switch"
                          labelStyle:PAYFormTableLabelStyleSimple
                        contentBlock:^(PAYFormSectionBuilder * sectionBuilder) {
                            [sectionBuilder addSwitchWithName:@"Switch with label"];
                        }];

    tableBuilder.formSuccessBlock = ^{
        // NSLog(@"%@", self.countryButtonGroup.values);
        // NSLog(@"%@", self.formSwitch.value ? @"YES" : @"NO");
        // [self performSegueWithIdentifier:@"next" sender:self];
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.tintColor = UIColor.redColor;
}


@end
