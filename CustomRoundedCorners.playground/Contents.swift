//: A UIKit based Playground for presenting user interface
// CustomRoundedCorners.playground
// Author: Chad Armstrong
// Date: May 2023

// References:
/*
 - https://gist.github.com/juliensagot/32c990ba69beaa754008d787e8299fa5
 - https://stackoverflow.com/questions/35053805/how-to-give-cornerradius-for-uibezierpath
 - https://stackoverflow.com/questions/10167266/how-to-set-cornerradius-for-only-top-left-and-top-right-corner-of-a-uiview
 - https://stackoverflow.com/questions/31214620/how-to-add-rounded-corner-to-a-uibezierpath-custom-rectangle
 - https://stackoverflow.com/questions/61058639/mask-image-with-custom-uibazierpath-swift
 - https://www.appsdeveloperblog.com/uiimageview-rounded-corners-in-swift/
 - https://sarunw.com/posts/how-to-set-corner-radius-for-some-corners/
 - https://www.hackingwithswift.com/example-code/calayer/how-to-round-only-specific-corners-using-maskedcorners
 - https://developer.apple.com/documentation/quartzcore/calayer/2877488-maskedcorners?language=objc
 - https://useyourloaf.com/blog/masked-and-animated-corners/
 - https://www.appcoda.com/rounded-corners-uiview/
 - https://www.appcoda.com/bezier-paths-introduction/
 - https://itecnote.com/tecnote/ios-drawing-rounded-corners-using-uibezierpath/
 - https://medium.com/@samarthpaboowal/drawing-using-cashapelayer-in-ios-9a6c83de7eb2
 - https://www.kodeco.com/books/ios-animations-by-tutorials/v6.0/chapters/15-shapes-masks
 - https://zoonref.com/blog/howto-make-polygon-image-mask
 - https://www.youtube.com/watch?v=6oy1OuCnqpw
 - https://almostengineer.medium.com/uibezierpath-lesson-how-to-draw-cuphead-on-layers-d164fd23cf61
 - https://developer.apple.com/documentation/uikit/uibezierpath/1624351-addquadcurvetopoint?language=objc
 */

import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .green
        
		let stockImage = UIImage(named: "BRF002-small")
        let stockImageView = UIImageView(image: stockImage)
        stockImageView.frame = CGRect(x: 50, y: 200, width: 300, height: 220)
        
        view.addSubview(stockImageView)
        
        // Example 1 ----------
//        let cornerRadius:CGFloat = 16.0
//        stockImageView.layer.cornerRadius = cornerRadius
//        stockImageView.clipsToBounds = true
//        stockImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // Example 2 ----------
//        let pathWithRadius = UIBezierPath(roundedRect:stockImageView.bounds, byRoundingCorners:[.topRight, .bottomRight], cornerRadii: CGSizeMake(16.0, 16.0))
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = pathWithRadius.cgPath
//        stockImageView.layer.mask = maskLayer
        
        // Example 3 ----------
        let imageHeight = stockImageView.bounds.height
        let imageWidth = stockImageView.bounds.width
        let topLeftRadius = imageHeight / 2.0
        let topRightRadius = 16.0
        let customBezierMask = UIBezierPath()
        
        // Starting point
        customBezierMask.move(to: CGPoint(x: topLeftRadius, y: 0.0))
        // Top line
        customBezierMask.addLine(to: CGPoint(x: imageWidth-topRightRadius, y: 0.0))
        // Top right corner with a radius of 16.0
        customBezierMask.addArc(withCenter: CGPoint(x: imageWidth-topRightRadius, y: topRightRadius), radius: topRightRadius, startAngle: 3 * .pi/2, endAngle: 0, clockwise: true)
        // Right line
        customBezierMask.addLine(to: CGPoint(x: imageWidth, y: imageHeight))
        // Bottom line
        customBezierMask.addLine(to: CGPoint(x: 0.0, y: imageHeight))
        // Left line
        customBezierMask.addLine(to: CGPoint(x: 0.0, y: imageHeight - topLeftRadius))
        // Top left corner with a radius that is half the height of the image
        customBezierMask.addArc(withCenter: CGPoint(x: topLeftRadius, y: imageHeight - topLeftRadius), radius: topLeftRadius, startAngle: .pi, endAngle: 3 * .pi/2, clockwise: true)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = customBezierMask.cgPath
        stockImageView.layer.mask = maskLayer
        
        self.view = view
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
