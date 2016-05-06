import UIKit

let chars = "AB"

func idealSize(font: UIFont, _ rect: CGRect, _ text: String) -> CGFloat {
    let ppp = font.lineHeight/font.pointSize
    var idealPointSize = rect.size.height * ppp
    
    if text.characters.count == 1 {
        idealPointSize *= 0.6
    } else {
        idealPointSize = 0.75 * idealPointSize /  CGFloat(text.characters.count)
    }
    
    return idealPointSize
}

let bg = UIView(frame: CGRectMake(0, 0, 450, 450))
bg.backgroundColor = UIColor.redColor()

var baseView = UIView(frame: CGRectMake(112.5, 112.5, 225, 225))
baseView.layer.cornerRadius = baseView.bounds.size.width/2.0
baseView.clipsToBounds = true
//baseView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.25)

var blurEffect = UIBlurEffect(style: .Light)
var blurView = UIVisualEffectView(effect: blurEffect)
blurView.frame = baseView.bounds
blurView.contentView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)

let size: CGFloat = idealSize(UIFont.systemFontOfSize(100.0), baseView.bounds, chars)

var text = UILabel(frame: baseView.bounds)
text.font = UIFont.systemFontOfSize(size)
text.textColor = UIColor.whiteColor()
text.textAlignment = .Center
text.backgroundColor = UIColor.clearColor()
text.text = chars

//blurView.addSubview(text)
baseView.addSubview(blurView)

var vibEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
var vibView = UIVisualEffectView(effect: vibEffect)
vibView.frame = blurView.bounds

blurView.contentView.addSubview(vibView)
vibView.contentView.addSubview(text)


var v = CNBlurredAbbreviatedLabel(frame: CGRectMake(112.5, 112.5, 225, 225))
v.letters = "ABC"

bg.addSubview(v)


