//
//  CNBlurredAbbreviatedLabel.h
//  CircleNameLabel
//
//  Created by Adi Mathew on 4/27/16.
//  Copyright © 2016 RCPD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNBlurredAbbreviatedLabel : UIView

/**
 Contains the letters to be displayed within the label. Ideally between 1 - 3 characters.
 Defaults to "."
 */
@property (nonatomic, strong) NSString *letters;
/**
 Changes the color used to 'tint' the blurring effect by changing the blurView's backgroundColor.
 Defaults to lightGrayColor. Setting it to other colors drops the alpha to 0.4 for visibility.
 */
@property (nonatomic, strong) UIColor *color;
/**
 Changes the alpha for the blurView's backgroundColor.
 Defaults to 0.5.
 */
@property (nonatomic) CGFloat colorAlpha;
/**
 Changes the value by which the base UIView's bounds.size.width is divided by to create a circular button.
 Defaults to 2.01. 
 Chaning to 2.0 or less causing blurring to act weird.
 */
@property (nonatomic) CGFloat labelRadiusFactor;

- (instancetype)initWithFrame:(CGRect)frame text: (NSString *)letters;
- (instancetype)initWithCoder:(NSCoder *)coder text: (NSString *)letters;

@end
