import UIKit
import Foundation

// MARK: - Designable Extension

@IBDesignable
extension UIView {
    
    @IBInspectable
    /// Should the corner be as circle
    public var circleCorner: Bool {
        get {
            return min(bounds.size.height, bounds.size.width) / 2 == _cornerRadius
        }
        set {
            _cornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : _cornerRadius
        }
    }
    
    @IBInspectable
    /// Corner radius of view; also inspectable from Storyboard.
    public var _cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = circleCorner ? min(bounds.size.height, bounds.size.width) / 2 : newValue
                //abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    @IBInspectable
    /// Border color of view; also inspectable from Storyboard.
    public var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            layer.borderColor = color.cgColor
        }
    }
    
    @IBInspectable
    /// Border width of view; also inspectable from Storyboard.
    public var _borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    /// Shadow color of view; also inspectable from Storyboard.
    public var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    /// Shadow offset of view; also inspectable from Storyboard.
    public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    /// Shadow opacity of view; also inspectable from Storyboard.
    public var shadowOpacity: Double {
        get {
            return Double(layer.shadowOpacity)
        }
        set {
            layer.shadowOpacity = Float(newValue)
        }
    }
    
    @IBInspectable
    /// Shadow radius of view; also inspectable from Storyboard.
    public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    /// Shadow path of view; also inspectable from Storyboard.
    public var shadowPath: CGPath? {
        get {
            return layer.shadowPath
        }
        set {
            layer.shadowPath = newValue
        }
    }
    
    @IBInspectable
    /// Should shadow rasterize of view; also inspectable from Storyboard.
    /// cache the rendered shadow so that it doesn't need to be redrawn
    public var shadowShouldRasterize: Bool {
        get {
            return layer.shouldRasterize
        }
        set {
            layer.shouldRasterize = newValue
        }
    }
    
    @IBInspectable
    /// Should shadow rasterize of view; also inspectable from Storyboard.
    /// cache the rendered shadow so that it doesn't need to be redrawn
    public var shadowRasterizationScale: CGFloat {
        get {
            return layer.rasterizationScale
        }
        set {
            layer.rasterizationScale = newValue
        }
    }
    
    @IBInspectable
    /// Corner radius of view; also inspectable from Storyboard.
    public var maskToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
}


// MARK: - Properties

public extension UIView {
    
    /// Size of view.
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self._width = newValue.width
            self._height = newValue.height
        }
    }
    
    /// Width of view.
    var _width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    /// Height of view.
    var _height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
}

extension UIView {
    
    func superview<T>(of type: T.Type) -> T? {
        return superview as? T ?? superview.flatMap { $0.superview(of: T.self) }
    }
    
}


// MARK: - Methods

public extension UIView {
    
    typealias Configuration = (UIView) -> Swift.Void
    
    func config(configurate: Configuration?) {
        configurate?(self)
    }
    
    /// Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}

extension UIView {
    
    func searchVisualEffectsSubview() -> UIVisualEffectView? {
        if let visualEffectView = self as? UIVisualEffectView {
            return visualEffectView
        } else {
            for subview in subviews {
                if let found = subview.searchVisualEffectsSubview() {
                    return found
                }
            }
        }
        return nil
    }
    
    /// This is the function to get subViews of a view of a particular type
    /// https://stackoverflow.com/a/45297466/5321670
    func subViews<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T{
                all.append(aView)
            }
        }
        return all
    }
    
    
    /// This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T
    /// https://stackoverflow.com/a/45297466/5321670
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
    
    
    
    /// Returns text and UI direction based on current view settings
//    var userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection
//    {
//        if #available(iOS 9.0, *) {
//            return UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute)
//        } else {
//            return UIApplication.shared.userInterfaceLayoutDirection
//        }
//    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-5.0, 5.0, -3, 3, -2.0, 2.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }

    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {

        var borders = [UIView]()

        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }


        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }

        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }

        return borders
    }

}

extension UIView {
    func addBlur(withAlpha alpha: CGFloat, style: UIBlurEffect.Style, insert at: Int) {
        let blurredEffectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blurredEffectView.frame = self.bounds
        blurredEffectView.alpha = alpha
        self.insertSubview(blurredEffectView, at: at)
    }
}
