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
    if (color != [UIColor lightGrayColor]) {
        _blurView.backgroundColor = [color colorWithAlphaComponent:_colorAlpha - 0.1];
    } else {
        _blurView.backgroundColor = [color colorWithAlphaComponent:_colorAlpha];
    }

}

-(void)setColorAlpha:(CGFloat)colorAlpha {
    _colorAlpha = colorAlpha;
    _blurView.backgroundColor = [_color colorWithAlphaComponent: colorAlpha];
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

- (void)setDefaults {
    
//  WTF http://stackoverflow.com/questions/28798269/round-uivisualeffectview
   
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle: UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    blurView.frame = self.bounds;
    
    //Changing this line is what causes the blurring to act weird.
    self.clipsToBounds = YES;
    [self addSubview:blurView];
    
    CGFloat size = idealFontSizeForFont([UIFont systemFontOfSize:100.0f], self.bounds, self.letters);
    size = size == NAN ? size : 60;
    
    UILabel *tx = [[UILabel alloc] initWithFrame:self.bounds];
    tx.font = [UIFont systemFontOfSize:size];
    tx.textColor = [UIColor whiteColor];
    tx.textAlignment = NSTextAlignmentCenter;
    tx.backgroundColor = [UIColor clearColor];
    
    UIVibrancyEffect *vib = [UIVibrancyEffect effectForBlurEffect:blur];
    UIVisualEffectView *vibView = [[UIVisualEffectView alloc] initWithEffect:vib];
    vibView.frame = blurView.bounds;
    [blurView.contentView addSubview:vibView];
    [vibView.contentView addSubview:tx];
    
    
    self.letterLabel = tx;
    self.blurView = blurView;
    self.color = [UIColor lightGrayColor];
    self.colorAlpha = 0.5;
    self.labelRadiusFactor = 2.01;

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
