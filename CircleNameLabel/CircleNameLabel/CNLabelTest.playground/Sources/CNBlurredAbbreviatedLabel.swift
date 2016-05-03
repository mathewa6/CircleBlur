import UIKit

public class CNBlurredAbbreviatedLabel: UIView {
    public var letters = "_"
    
    private var letterLabel: UILabel
    private var blurView: UIVisualEffectView
    private var vibView: UIVisualEffectView
    
    override public init(frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .Light)
        blurView = UIVisualEffectView(effect: blurEffect)
        let vibEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        vibView = UIVisualEffectView(effect: vibEffect)
        letterLabel = UILabel(frame: frame)
        
        super.init(frame: frame)
        
        self.setDefaults()
    }
    
    convenience public init() {
        self.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        blurView.frame = self.bounds
        vibView.frame = self.blurView.bounds
    }
    
    func setDefaults() {
        self.layer.cornerRadius = self.bounds.size.width/2.0
        self.clipsToBounds = true
        //baseView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.25)
        
        blurView.frame = self.bounds
        blurView.contentView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
        let size: CGFloat = idealSize(UIFont.systemFontOfSize(100.0), self.bounds, letters)
        
        letterLabel = UILabel(frame: self.bounds)
        letterLabel.font = UIFont.systemFontOfSize(size)
        letterLabel.textColor = UIColor.whiteColor()
        letterLabel.textAlignment = .Center
        letterLabel.backgroundColor = UIColor.clearColor()
        letterLabel.text = letters
        
        //blurView.addSubview(text)
        self.addSubview(blurView)
        

        vibView.frame = blurView.bounds
        
        blurView.contentView.addSubview(vibView)
        vibView.contentView.addSubview(letterLabel)

    }
    
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

}

