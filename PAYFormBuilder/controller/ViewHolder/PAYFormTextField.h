//
//  PAYFormTextField.h
//  paij
//
//  Created by Marius Rackwitz on 14.11.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import "PAYFormField.h"


extern NSString *const PAYFormTextFieldErrorDomain;

typedef enum {
    PAYFormTextFieldBelowMinLength = 2,
    PAYFormTextFieldAboveMaxLength = 3,
} PAYFormTextFieldErrorCodes;


@interface PAYFormTextField : PAYFormField

@property (nonatomic, assign) NSUInteger minTextLength;
@property (nonatomic, assign) NSUInteger maxTextLength;
@property (nonatomic, assign) BOOL mayExceedMaxLength;

@property (nonatomic, assign) BOOL validateWhileEnter;

- (void)setFormatTextWithGroupSizes:(NSArray *)groupSizes;
- (void)setFormatTextWithGroupSizes:(NSArray *)groupSizes separator:(NSString *)separator;

- (PAYFormFieldFormatBlock)formatBlockWithGroupSizes:(NSArray *)groupSizes separator:(NSString *)separator;

- (void)setEnabled:(BOOL)enabled;

@end