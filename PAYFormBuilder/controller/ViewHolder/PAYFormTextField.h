//
//  PAYFormTextField.h
//  PAYFormBuilder
//
//  Created by Marius Rackwitz on 14.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormField.h"

/**
 *  A form field with a single line textfield.
 */
@interface PAYFormTextField : PAYFormField

/**
 *  Set the minimum text length the user has to enter. If
 *  the minimum text length is not reached, the validation fails.
 */
@property (nonatomic, assign) NSUInteger minTextLength;

/**
 *  Set the maximum text length the user could enter. If
 *  the maximum text length is exceeded, the validation fails.
 */
@property (nonatomic, assign) NSUInteger maxTextLength;

/**
 *  When true, the user could enter as many characters he like but
 *  validation still fails, when maxTextLength is exceeded.
 *  When false, the user could not enter more characters than 
 *  specified in maxTextLength. (default)
 */
@property (nonatomic, assign) BOOL mayExceedMaxLength;

/**
 *  When true, the validation of minTextLength and maxTextLength is
 *  done all the time the user entered text.
 *  When false, the validation is normally when the form is submitted (default)
 */
@property (nonatomic, assign) BOOL validateWhileEnter;

/**
 *  Sets a format that is defined by groups of characters.
 *  Example: for the groupSizes [@3, @3, @2] the text "aaabbbcc" is
 *           formatted as "aaa bbb cc"
 *
 *  @param groupSizes an array of group sizes
 */
- (void)setFormatTextWithGroupSizes:(NSArray *)groupSizes;

/**
 *  Sets a format that is defined by groups of characters.
 *  Example: for the groupSizes [@3, @3, @2] and the sepearator "-" the text "aaabbbcc" is
 *           formatted as "aaa-bbb-cc"
 *
 *  @param groupSizes an array of group sizes
 *  @param separator  an string to seperate the groups
 */
- (void)setFormatTextWithGroupSizes:(NSArray *)groupSizes separator:(NSString *)separator;

@end
