//
//  PAYTestTest.m
//  Example
//
//  Created by Simon Seyer on 09.05.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYValidationsTest.h"
#import <KIF/KIF.h>
#import <KIF/UIAccessibilityElement-KIFAdditions.h>

@implementation PAYValidationsTest

- (void)setUp {
    [super setUp];

    self.stopTestsOnFirstBigFailure = YES;
}

- (void)beforeAll {
    [super beforeAll];
    
    [tester tapViewWithAccessibilityLabel:@"Validation"];
}

- (void)test_A_requiredFieldFail {
    [tester tapViewWithAccessibilityLabel:@"Done"];
    if ([self findViewWithLabel:@"Missing"] && [self findViewWithLabel:@"Field Required is missing"]) {
        [tester tapViewWithAccessibilityLabel:@"Ok"];
    } else {
        [tester fail];
    }
}

- (void)test_B_requiredFieldSuccess {
    [tester enterText:@"Test" intoViewWithAccessibilityLabel:@"requiredField"];
    [tester tapViewWithAccessibilityLabel:@"Done"];
    if ([self findViewWithLabel:@"Missing"] && [self findViewWithLabel:@"Field Required is missing"]) {
        [tester fail];
    }
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_C_minLengthFail {
    [tester enterText:@"12" intoViewWithAccessibilityLabel:@"minMaxField"];
    [tester tapViewWithAccessibilityLabel:@"Done"];
    if ([self findViewWithLabel:@"To short"] && [self findViewWithLabel:@"Content of field Min/Max is to short. Please enter a minimum of 3 characters"]) {
        [tester tapViewWithAccessibilityLabel:@"Ok"];
    } else {
        [tester fail];
    }
}

- (void)test_D_maxLengthFail {
    [tester clearTextFromAndThenEnterText:@"1234567" intoViewWithAccessibilityLabel:@"minMaxField"];
    [tester tapViewWithAccessibilityLabel:@"Done"];
    if ([self findViewWithLabel:@"To long"] && [self findViewWithLabel:@"Content of field Min/Max is to long. Please enter a maximum of 6 characters"]) {
        [tester tapViewWithAccessibilityLabel:@"Ok"];
    } else {
        [tester fail];
    }
}

- (void)test_E_minMaxLengthSuccess {
    [tester clearTextFromAndThenEnterText:@"1234" intoViewWithAccessibilityLabel:@"minMaxField"];
    [tester tapViewWithAccessibilityLabel:@"Done"];
    if ([self findViewWithLabel:@"To short"] && [self findViewWithLabel:@"Content of field Min/Max is to short. Please enter a minimum of 3 characters"]) {
        [tester fail];
    } else {
        [tester tapViewWithAccessibilityLabel:@"Ok"];
    }
}

- (void)test_F_requiredSwitchFail {
    [tester tapViewWithAccessibilityLabel:@"Done"];
    if ([self findViewWithLabel:@"Missing"] && [self findViewWithLabel:@"Please check Required"]) {
        [tester tapViewWithAccessibilityLabel:@"Ok"];
    } else {
        [tester fail];
    }
}

- (void)test_G_requiredSwitchSuccess {
    UISwitch *switchUI = (UISwitch *)[tester waitForViewWithAccessibilityLabel:@"requiredSwitch"];
    [switchUI setOn:YES animated:YES];
    [tester tapViewWithAccessibilityLabel:@"Done"];
    if ([self findViewWithLabel:@"Missing"] && [self findViewWithLabel:@"Please check Required"]) {
        [tester fail];
    } else {
        [tester tapViewWithAccessibilityLabel:@"Ok"];
    }
}

- (void)test_H_intValidationFail {
    [tester enterText:@"abc" intoViewWithAccessibilityLabel:@"integerValidationField"];
    [tester tapViewWithAccessibilityLabel:@"Done"]; // for keyboard
    [tester tapViewWithAccessibilityLabel:@"Done"];
    if ([self findViewWithLabel:@"No integer"] && [self findViewWithLabel:@"Please enter an integer to field Number."]) {
        [tester tapViewWithAccessibilityLabel:@"Ok"];
    } else {
        [tester fail];
    }
}

- (void)test_I_intValidationFail {
    [tester clearTextFromAndThenEnterText:@"123" intoViewWithAccessibilityLabel:@"integerValidationField"];
    [tester tapViewWithAccessibilityLabel:@"Done"]; // for keyboard
    [tester tapViewWithAccessibilityLabel:@"Done"];
    if ([self findViewWithLabel:@"No integer"] && [self findViewWithLabel:@"Please enter an integer to field Number."]) {
        [tester fail];
    } else {
        [tester tapViewWithAccessibilityLabel:@"Ok"];
    }
}

- (BOOL)findViewWithLabel:(NSString*)label {
    UIView *view = nil;
    return [UIAccessibilityElement accessibilityElement:NULL view:&view withLabel:label value:nil traits:UIAccessibilityTraitNone tappable:NO error:nil];
}

@end
