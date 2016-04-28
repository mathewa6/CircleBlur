//
//  CNBlurredAbbreviatedLabel.h
//  CircleNameLabel
//
//  Created by Adi Mathew on 4/27/16.
//  Copyright © 2016 RCPD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNBlurredAbbreviatedLabel : UIView

@property (nonatomic, strong) NSString *letters;
@property (nonatomic, strong) UIColor *color;

- (instancetype)initWithFrame:(CGRect)frame text: (NSString *)letters;
- (instancetype)initWithCoder:(NSCoder *)coder text: (NSString *)letters;

@end
