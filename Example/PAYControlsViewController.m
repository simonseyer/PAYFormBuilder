//
//  PAYButtonViewController.m
//  Example
//
//  Created by Simon Seyer on 25.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYControlsViewController.h"
#import "PayFormButton.h"

@interface PAYControlsViewController ()

@end

@implementation PAYControlsViewController


- (void)loadStructure:(id<PAYTableBuilder>)tableBuilder {
    
    [tableBuilder addSectionWithName:@"Simple buttons"
                        contentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
                            [sectionBuilder addButtonWithText:@"Button style centered"
                                                        style:PAYFormButtonStyleCentered
                                               selectionBlock:nil];
                            [sectionBuilder addButtonWithText:@"Button style disabled centered"
                                                        style:PAYFormButtonStyleDisabledCentered
                                               selectionBlock:nil];
                            [sectionBuilder addButtonWithText:@"Button style hilighted centered"
                                                        style:PAYFormButtonStyleHilightedCentered
                                               selectionBlock:nil];
                            [sectionBuilder addButtonWithText:@"Button style primary centered"
                                                        style:PAYFormButtonStylePrimaryCentered
                                               selectionBlock:nil];
                            [sectionBuilder addButtonWithText:nil
                                                        style:PAYFormButtonStyleEmpty
                                               selectionBlock:nil];
                            [sectionBuilder addButtonWithText:@"Button style disclosure"
                                                        style:PAYFormButtonStyleDisclosure
                                               selectionBlock:nil];
                            [sectionBuilder addButtonWithText:@"Button style selection"
                                                        style:PAYFormButtonStyleSelection
                                               selectionBlock:nil];
                            [sectionBuilder addButtonWithText:@"Button style icon disclosure"
                                                        style:PAYFormButtonStyleIconDisclosure
                                                         icon:[UIImage imageNamed:@"de"]
                                               selectionBlock:nil];
                            [sectionBuilder addButtonWithText:@"Button icon selection"
                                                        style:PAYFormButtonStyleIconSelection
                                                         icon:[UIImage imageNamed:@"usa"]
                                               selectionBlock:nil];
                        }];
    
    NSArray *countries = @[@[@"United States", @"usa"], @[@"Germany", @"de"], @[@"Spain", @"es"]];
    
    [tableBuilder addSectionWithName:@"Single selection button group"
                        contentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
                            [sectionBuilder addButtonGroupWithMutliSelection:NO
                                                                contentBlock:^(id<PAYButtonGroupBuilder> buttonGroupBuilder) {
                                                                    for (NSArray *country in countries) {
                                                                        [buttonGroupBuilder addOption:country[1]
                                                                                             withText:country[0]
                                                                                                 icon:[UIImage imageNamed:country[1]]];
                                                                    }
                                                                    [buttonGroupBuilder select:@"usa"];
                                                                }];
                        }];
    
    [tableBuilder addSectionWithName:@"Multi selection button group"
                        contentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
                            [sectionBuilder addButtonGroupWithMutliSelection:YES
                                                                contentBlock:^(id<PAYButtonGroupBuilder> buttonGroupBuilder) {
                                                                    for (NSArray *country in countries) {
                                                                        [buttonGroupBuilder addOption:country[1]
                                                                                             withText:country[0]];
                                                                    }
                                                                    [buttonGroupBuilder select:@"usa"];
                                                                }];
                        }];
    
    [tableBuilder addSectionWithName:@"Switch"
                          labelStyle:PAYFormTableLabelStyleSimple
                        contentBlock:^(id<PAYSectionBuilder> sectionBuilder) {
                            [sectionBuilder addSwitchWithName:@"Switch with label"];
                        }];

    tableBuilder.formSuccessBlock = ^{
       // NSLog(@"%@", self.countryButtonGroup.values);
       // NSLog(@"%@", self.formSwitch.value ? @"YES" : @"NO");
       // [self performSegueWithIdentifier:@"next" sender:self];
    };
}


@end
