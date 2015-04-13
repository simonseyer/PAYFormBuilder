//
//  PAYTableTheme.h
//  Pods
//
//  Created by COBI on 09.04.15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 * The table theme definition, that is used in the TableBuilder
 * to provide default styles used to layout the header of the sections 
 */
@protocol PAYTableTheme <NSObject>

- (CGFloat)rowHeight;
- (CGFloat)footerHeight;
- (CGFloat)labelStyleNoneHeight;
- (CGFloat)labelStyleEmptyHeight;
- (CGFloat)infoIconMargin;

@end
