//
//  PAYTestTest.m
//  Example
//
//  Created by Simon Seyer on 09.05.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYValidationsTest.h"
#import <KIF/KIF.h>
#import "KIFUITestActor+PAYComfort.h"

@implementation PAYValidationsTest

- (void)setUp {
    [super setUp];

    self.stopTestsOnFirstBigFailure = YES;
}

- (void)beforeAll {
    [super beforeAll];
    
    [tester tapViewWithAccessibilityLabel:@"Validation"];
}

- (void)afterAll {
    [super afterAll];
    [tester tapViewWithAccessibilityLabel:@"Back"];
}

- (void)test_A_requiredFieldFail {
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester waitForViewWithAccessibilityLabel:@"Missing"];
    [tester waitForViewWithAccessibilityLabel:@"Field Required is missing"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_B_requiredFieldSuccess {
    // Enter value
    [tester enterText:@"Test" intoViewWithAccessibilityLabel:@"requiredField"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester checkForAbsenceOfViewWithAccessibilityLabel:@"Field Required is missing"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_C_minLengthFail {
    // Enter value
    [tester enterText:@"12" intoViewWithAccessibilityLabel:@"minMaxField"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester waitForViewWithAccessibilityLabel:@"To short"];
    [tester waitForViewWithAccessibilityLabel:@"Content of field Min/Max is to short. Please enter a minimum of 3 characters"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_D_maxLengthFail {
    // Enter value
    [tester clearTextFromAndThenEnterText:@"1234567" intoViewWithAccessibilityLabel:@"minMaxField"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester waitForViewWithAccessibilityLabel:@"To long"];
    [tester waitForViewWithAccessibilityLabel:@"Content of field Min/Max is to long. Please enter a maximum of 6 characters"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_E_minMaxLengthSuccess {
    // Enter value
    [tester clearTextFromAndThenEnterText:@"1234" intoViewWithAccessibilityLabel:@"minMaxField"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester checkForAbsenceOfViewWithAccessibilityLabel:@"Content of field Min/Max is to short. Please enter a minimum of 3 characters"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_F_requiredSwitchFail {
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester waitForViewWithAccessibilityLabel:@"Missing"];
    [tester waitForViewWithAccessibilityLabel:@"Please check Required"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_G_requiredSwitchSuccess {
    // Enter value
    UISwitch *switchUI = (UISwitch *)[tester waitForViewWithAccessibilityLabel:@"requiredSwitch"];
    [switchUI setOn:YES animated:YES];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester checkForAbsenceOfViewWithAccessibilityLabel:@"Please check Required"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_H_intValidationFail {
    // Enter value
    [tester enterText:@"abc" intoViewWithAccessibilityLabel:@"integerValidationField"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester waitForViewWithAccessibilityLabel:@"No integer"];
    [tester waitForViewWithAccessibilityLabel:@"Please enter an integer to field Number."];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_I_intValidationSuccess {
    // Enter value
    [tester clearTextFromAndThenEnterText:@"123" intoViewWithAccessibilityLabel:@"integerValidationField"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester checkForAbsenceOfViewWithAccessibilityLabel:@"Please enter an integer to field Number."];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_J_requiredButtonGroupFail {
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester waitForViewWithAccessibilityLabel:@"Missing"];
    [tester waitForViewWithAccessibilityLabel:@"Field Required button group is missing"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_K_requiredButtonGroupSuccess {
    // Enter value
    [tester tapViewWithAccessibilityLabel:@"option1"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester checkForAbsenceOfViewWithAccessibilityLabel:@"Field Required button group is missing"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_L_requiredTextViewFail {
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester waitForViewWithAccessibilityLabel:@"Missing"];
    [tester waitForViewWithAccessibilityLabel:@"Field Required is missing"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_M_requiredTextViewSuccess {
    // Enter value
    [tester clearTextFromAndThenEnterText:@"abcasdasd" intoViewWithAccessibilityLabel:@"textView"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester checkForAbsenceOfViewWithAccessibilityLabel:@"Field Required text view is missing"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

@end
