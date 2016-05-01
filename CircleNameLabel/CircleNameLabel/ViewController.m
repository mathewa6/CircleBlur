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
@property (strong, nonatomic) IBOutlet CNBlurredAbbreviatedLabel *bugLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // This next line sets the corner radius of the UIView subclass to be
    // view.bounds.size.width/labelRadiusFactor.
    // However if it is set to width/2.0 blurring becomes disabled/noisy.
    // Setting it to 2.01 for some reason works. Why ?
    self.bugLabel.labelRadiusFactor = 4.0;
}

/**
 Ignore dis.
 */
- (void)move:(UIPanGestureRecognizer *)pan {
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
