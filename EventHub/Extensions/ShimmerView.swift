
import UIKit

class ShimmerView: UIView {

    private var gradientLayer: CAGradientLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShimmerEffect()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupShimmerEffect()
    }

    private func setupShimmerEffect() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.lightGray.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.startPoint = CGPoint(x: -1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 2, y: 0)
        layer.addSublayer(gradientLayer)
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 1.5
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "shimmer")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
