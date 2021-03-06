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
@property (nonatomic, strong) UIVisualEffectView *vibView;

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
    if (color != [UIColor lightGrayColor]) {
        _blurView.contentView.backgroundColor = [color colorWithAlphaComponent:_colorAlpha - 0.1];
    } else {
        _blurView.contentView.backgroundColor = [color colorWithAlphaComponent:_colorAlpha];
    }

}

-(void)setColorAlpha:(CGFloat)colorAlpha {
    _colorAlpha = colorAlpha;
    _blurView.contentView.backgroundColor = [_color colorWithAlphaComponent: colorAlpha];
}

-(void)setLabelRadiusFactor:(CGFloat)labelRadiusFactor {
    _labelRadiusFactor = labelRadiusFactor;
    self.layer.cornerRadius = self.frame.size.width/labelRadiusFactor;
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

-(void)layoutSubviews {
    self.blurView.frame = self.bounds;
    self.vibView.frame = self.blurView.bounds;
}

- (void)setDefaults {
    _color = [UIColor lightGrayColor];
    _colorAlpha = 0.25;
    _labelRadiusFactor = 2.0;
    
//  WTF http://stackoverflow.com/questions/28798269/round-uivisualeffectview
   
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle: UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    blurView.contentView.backgroundColor = [self.color colorWithAlphaComponent:self.colorAlpha]; //FIXED
    
    //Changing this line is what used to cause the blurring to act weird.
    self.layer.cornerRadius = self.frame.size.width/_labelRadiusFactor;
    
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
    
    UIVibrancyEffect *vib = [UIVibrancyEffect effectForBlurEffect:blur];
    UIVisualEffectView *vibView = [[UIVisualEffectView alloc] initWithEffect:vib];
    [blurView.contentView addSubview:vibView];
    [vibView.contentView addSubview:tx];
    
    self.letterLabel = tx;
    self.blurView = blurView;
    self.vibView = vibView;
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
