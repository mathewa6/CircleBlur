//
//  ViewController.m
//  CircleNameLabel
//
//  Created by Adi Mathew on 4/26/16.
//  Copyright © 2016 RCPD. All rights reserved.
//

#import "ViewController.h"
#import "CNBlurredAbbreviatedLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    
//  WTF  http://stackoverflow.com/questions/28798269/round-uivisualeffectview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3, self.view.frame.size.height/3, self.view.frame.size.width/3, self.view.frame.size.width/3)];
//    view.backgroundColor = [UIColor lightGrayColor];
//    view.tintColor = [UIColor redColor];
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle: UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    blurView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
    blurView.frame = view.bounds;
//    blurView.layer.cornerRadius = blurView.frame.size.width/2;
//    blurView.clipsToBounds = YES;
    view.layer.cornerRadius = view.frame.size.width/2.01;
    view.clipsToBounds = YES;
    [view addSubview:blurView];
    
    UILabel *tx = [[UILabel alloc] initWithFrame:view.bounds];
    tx.font = [UIFont systemFontOfSize:75];
    tx.textColor = [UIColor whiteColor];
    tx.text = @"A";
    tx.textAlignment = NSTextAlignmentCenter;
    tx.backgroundColor = [UIColor clearColor];
    
    UIVibrancyEffect *vib = [UIVibrancyEffect effectForBlurEffect:blur];
    UIVisualEffectView *vibView = [[UIVisualEffectView alloc] initWithEffect:vib];
    vibView.frame = blurView.bounds;
    [blurView.contentView addSubview:vibView];
    [vibView.contentView addSubview:tx];

    [view addGestureRecognizer:pan];
    
    [self.view addSubview: view];
    
    CNBlurredAbbreviatedLabel *bl = [[CNBlurredAbbreviatedLabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/1.5, self.view.frame.size.height/1.5, self.view.frame.size.width/3, self.view.frame.size.width/3)];
    bl.color = [UIColor redColor];
    [self.view addSubview: bl];
}

- (void)move:(UIPanGestureRecognizer *)pan {
//    CGPoint touch = [pan locationInView:self.view];
//    pan.view.center = touch;
    CGPoint translation = [pan translationInView:self.view];
    
    pan.view.center = CGPointMake(pan.view.center.x + translation.x,
                                         pan.view.center.y + translation.y);
      
    [pan setTranslation:CGPointMake(0, 0) inView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
