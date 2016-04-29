CircleBlur
===

A modified take on the iMessage/Contacts App style of putting initials in a circle. This one uses UIVibrancyEffect and UIBlurEffect instead of a custom drawRect.

## Setup  ##

```
CNBlurredAbbreviatedLabel *label = [[CNBlurredAbbreviatedLabel alloc] initWithFrame: frame];

// Optional properties
// label.color = [UIColor blueColor];
// label.colorAlpha = 0.5;
// label.labelRadiusFactor = 2.01;

[view addSubView: label];

```

## Bug ##

Setting property labelRadiusFactor which is the the base View's layer.cornerRadius property to 2.0, which calculates the bounds.size.width/2.0, causes UIBlurEffect to not function properly. Why? 

## Screenshots ##

![Image of proper labels](https://raw.githubusercontent.com/mathewa6/CircleBlur/master/Screenshots/Screen%20Shot%202016-04-29%20at%202.55.15%20PM.png)
![Image of buggy label](https://raw.githubusercontent.com/mathewa6/CircleBlur/master/Screenshots/Screen%20Shot%202016-04-29%20at%203.56.39%20PM.png)