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
        
    CNBlurredAbbreviatedLabel *bl = [[CNBlurredAbbreviatedLabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/1.5, self.view.frame.size.height/1.5, self.view.frame.size.width/3, self.view.frame.size.width/3)];
//    bl.color = [UIColor redColor];
    [bl addGestureRecognizer:pan];
//    bl.colorAlpha = 0.25;
//    bl.labelRadiusFactor = 2.01;
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
