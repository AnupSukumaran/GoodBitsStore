//
//  UIViewCustom.swift
//  EV Quiz
//
//  Created by Anup Sukumaran on 18/09/18.
//  Copyright © 2018 WIS. All rights reserved.
//


import UIKit

@IBDesignable
public class UIViewCustom: UIView {
    
    // the gradient layer
    public var gradient: CAGradientLayer?
    public var colors: [Any]?
    // An array of CGColorRef objects defining the color of each gradient stop. Animatable.
    
    @IBInspectable public var shadowOpacity: CGFloat = 0.0 {
        
        didSet {
            self.layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 0.0 {
        
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize = CGSize.zero{
        
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable public var shadowColor: UIColor = UIColor.clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0.0{
        
        didSet{
            
            self.layer.borderWidth = borderWidth
            
        }
    }
    
    @IBInspectable public var cornurRadius: CGFloat = 1.0 {
        didSet {
            layer.cornerRadius = cornurRadius
            clipsToBounds = true
        }
    }
    
    @IBInspectable public var maskToBonds: Bool = false{
        didSet{
            self.layer.masksToBounds = maskToBonds
        }
    }
    
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        
        didSet {
            
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    // the gradient start colour
    @IBInspectable public var startColor: UIColor? {
        didSet {
            updateGradient()
        }
    }
    
    // the gradient end colour
    @IBInspectable public var endColor: UIColor? {
        didSet {
            updateGradient()
        }
    }
    
    // the gradient angle, in degrees anticlockwise from 0 (east/right)
    @IBInspectable public var angle: CGFloat = 270 {
        didSet {
            updateGradient()
        }
    }

    
//    @IBInspectable var startColor: UIColor = UIColor.clear
//    @IBInspectable var endColor: UIColor = UIColor.clear
//    @IBInspectable var startAxis: CGPoint = CGPoint(x: 0.0, y: 0.0)
//    @IBInspectable var endAxis: CGPoint = CGPoint(x: 0.0, y: 0.0)
    @IBInspectable public var grad_loc1: CGFloat = 0.0 {
        didSet {
            updateGradient()
        }
    }
    
    
    @IBInspectable public var grad_loc2: CGFloat = 0.0 {
        didSet {
            updateGradient()
        }
    }
    
    override public var frame: CGRect {
        didSet {
            updateGradient()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        // this is crucial when constraints are used in superviews
        updateGradient()
    }
    
    // initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        installGradient()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        installGradient()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        configure()
        installGradient()
        updateGradient()
    }
    
    func setup() {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 1.0
    }
    
    func configure() {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornurRadius
       // newDraw()
    }
    
    // Update an existing gradient
    public func updateGradient() {
        if let gradient = self.gradient {
            let startColor = self.startColor ?? UIColor.clear
            let endColor = self.endColor ?? UIColor.clear
            gradient.colors = [startColor.cgColor, endColor.cgColor]
            let (start, end) = gradientPointsForAngle(self.angle)
            gradient.startPoint = start
            gradient.endPoint = end
            gradient.frame = self.bounds
            gradient.locations = [grad_loc1, grad_loc2] as [NSNumber]
            gradient.zPosition = -1
        }
    }
    
    
    // create vector pointing in direction of angle
    public func gradientPointsForAngle(_ angle: CGFloat) -> (CGPoint, CGPoint) {
        // get vector start and end points
        let end = pointForAngle(angle)
        let start = oppositePoint(end)
        // convert to gradient space
        let p0 = transformToGradientSpace(start)
        let p1 = transformToGradientSpace(end)
        return (p0, p1)
    }
    
    public func pointForAngle(_ angle: CGFloat) -> CGPoint {
        // convert degrees to radians
        let radians = angle * .pi / 180.0
        var x = cos(radians)
        var y = sin(radians)
        // (x,y) is in terms unit circle. Extrapolate to unit square to get full vector length
        if (abs(x) > abs(y)) {
            // extrapolate x to unit length
            x = x > 0 ? 1 : -1
            y = x * tan(radians)
        } else {
            // extrapolate y to unit length
            y = y > 0 ? 1 : -1
            x = y / tan(radians)
        }
        return CGPoint(x: x, y: y)
    }
    
    public func oppositePoint(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: -point.x, y: -point.y)
    }
    
    public func transformToGradientSpace(_ point: CGPoint) -> CGPoint {
        // input point is in signed unit space: (-1,-1) to (1,1)
        // convert to gradient space: (0,0) to (1,1), with flipped Y axis
        return CGPoint(x: (point.x + 1) * 0.5, y: 1.0 - (point.y + 1) * 0.5)
    }
    
    // create gradient layer
    public func createGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        return gradient
    }
    
    // Create a gradient and install it on the layer
    public func installGradient() {
        // if there's already a gradient installed on the layer, remove it
        if let gradient = self.gradient {
            gradient.removeFromSuperlayer()
        }
        let gradient = createGradient()
        self.layer.addSublayer(gradient)
        self.gradient = gradient
    }
    

}
