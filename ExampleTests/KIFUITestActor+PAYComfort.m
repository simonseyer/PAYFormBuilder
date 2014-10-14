//
//  KIFTestCase+PAYComfort.m
//  Example
//
//  Created by Simon Seyer on 15.05.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "KIFUITestActor+PAYComfort.h"
#import <KIF/KIFUITestActor-ConditionalTests.h>
#import <KIF/NSError-KIFAdditions.h>

@implementation KIFUITestActor (PAYComfort)

- (void)checkForAbsenceOfViewWithAccessibilityLabel:(NSString*)label {
    if ([self tryFindingViewWithAccessibilityLabel:label error:NULL]) {
        [self failWithError:[NSError KIFErrorWithFormat:@"View with accessibility label '%@' should be absent!", label]
                   stopTest:YES];
    }
}


@end
