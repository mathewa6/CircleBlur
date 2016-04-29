//
//  CNBlurredAbbreviatedLabel.m
//  CircleNameLabel
//
//  Created by Adi Mathew on 4/27/16.
//  Copyright © 2016 RCPD. All rights reserved.
//

#import "CNBlurredAbbreviatedLabel.h"

@interface CNBlurredAbbreviatedLabel()

@property (nonatomic, strong) UILabel *letterLabel;
@property (nonatomic, strong) UIVisualEffectView *blurView;

@end

@implementation CNBlurredAbbreviatedLabel

-(void)setLetters:(NSString *)letters {
    _letters = letters;
    [UIView animateWithDuration:0.5 animations:^{
        _letterLabel.text = letters; //CHECK FONT HERE
        CGFloat size = idealFontSizeForFont([UIFont systemFontOfSize:100.0f], self.bounds, self.letters);
        _letterLabel.font = [UIFont systemFontOfSize: size];
    }];
}

- (void)setColor:(UIColor *)color {
    _color = color;
    _blurView.backgroundColor = [color colorWithAlphaComponent:0.5];

}

-(instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame text:@"."];
}

-(instancetype)initWithFrame:(CGRect)frame text: (NSString *)letters {
    NSParameterAssert(letters);
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaults];
        self.letters = letters ? letters : self.letters;
    }
    
    return  self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    return [self initWithCoder:coder text:@"."];
}

- (instancetype)initWithCoder:(NSCoder *)coder text: (NSString *)letters {
    self = [super initWithCoder:coder];
    if (self) {
        [self setDefaults];
        self.letters = letters ? letters : self.letters;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setDefaults];
    }
    return self;
}

//Commented code will convert it into non-blended non subtractive text with white background.
- (void)setDefaults {
    self.color = [UIColor lightGrayColor];
    
//  WTF http://stackoverflow.com/questions/28798269/round-uivisualeffectview
   
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle: UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    blurView.backgroundColor = [self.color colorWithAlphaComponent:0.5];
    blurView.frame = self.bounds;
    
    self.layer.cornerRadius = self.frame.size.width/2.01;
    self.clipsToBounds = YES;
    [self addSubview:blurView];
    
    CGFloat size = idealFontSizeForFont([UIFont systemFontOfSize:100.0f], self.bounds, self.letters);
    size = size == NAN ? size : 60;
    
    UILabel *tx = [[UILabel alloc] initWithFrame:self.bounds];
    tx.font = [UIFont systemFontOfSize:size];
    tx.textColor = [UIColor whiteColor];
//    tx.text = self.letters ? self.letters : @"_";
    tx.textAlignment = NSTextAlignmentCenter;
    tx.backgroundColor = [UIColor clearColor];
    
    self.letterLabel = tx;
    self.blurView = blurView;
    
    UIVibrancyEffect *vib = [UIVibrancyEffect effectForBlurEffect:blur];
    UIVisualEffectView *vibView = [[UIVisualEffectView alloc] initWithEffect:vib];
    vibView.frame = blurView.bounds;
    [blurView.contentView addSubview:vibView];
    [vibView.contentView addSubview:tx];

}

static CGFloat idealFontSizeForFont( UIFont *font, CGRect rect, NSString *text) {
    CGFloat ppp = font.lineHeight/font.pointSize;
    CGFloat idealPointSize = rect.size.height * ppp;
    if (text.length == 1) {
        idealPointSize = 0.6 * idealPointSize;
    } else {
        idealPointSize = 0.75 * idealPointSize / text.length;
    }
    
    return idealPointSize;
}


@end
