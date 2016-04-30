CircleBlur
===

A modified take on the iMessage/Contacts App style of putting initials in a circle. This one uses UIVibrancyEffect and UIBlurEffect instead of a custom drawRect.

## Setup  ##

```obj-c
CNBlurredAbbreviatedLabel *label = [[CNBlurredAbbreviatedLabel alloc] initWithFrame: frame];

// Optional properties
// label.color = [UIColor blueColor];
// label.colorAlpha = 0.5;
// label.labelRadiusFactor = 2.01;

[view addSubView: label];

```

Alternatively, simply drop a UIView into a storyboard VC and set it's class in the Identity inspector to CNBlurredAbbreviatedLabel.

## Bug ##

Setting property labelRadiusFactor which is the the base View's layer.cornerRadius property to 2.0, which calculates the bounds.size.width/2.0, causes UIBlurEffect to not function properly. Why? 

*ANSWER:* Because the docs for UIVisualEffectView clearly state that changing the alpha of the same will result in undefined behaviour. Removing the call to 


```obj-c

blurView.backgroundColor = [self.color colorWithAlphaComponent:self.colorAlpha];

```
fixes the issue even when labelRadiusFactor is 2.0.

## Screenshots ##

![Image of proper labels](https://raw.githubusercontent.com/mathewa6/CircleBlur/master/Screenshots/Screen%20Shot%202016-04-29%20at%202.55.15%20PM.png)
![Image of buggy label](https://raw.githubusercontent.com/mathewa6/CircleBlur/master/Screenshots/Screen%20Shot%202016-04-29%20at%203.56.39%20PM.png)