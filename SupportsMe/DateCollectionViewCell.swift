import UIKit

//data for the cells of the collection view - essentially each day in the calendar
class DateCollectionViewCell: UICollectionViewCell {
    
    //label displays the day in the month
    @IBOutlet weak var DateLabel: UILabel!
    
    //circle is drawn to indicate today's date
    @IBOutlet weak var Circle: UIView!
   
    //this method defines a circle to be drawn on today's date
    func DrawCircle() {
        //define the circle properties
        let center = Circle.center
        let circlePath = UIBezierPath.init(arcCenter: center, radius: (Circle.bounds.width/2 - 5), startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        //create a layer for the circle in the UIView
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.lineWidth = 2
        circleLayer.strokeEnd = 0
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = CAShapeLayerLineCap.round
        
        //create the animation
        let circleAnim = CABasicAnimation(keyPath: "strokeEnd")
        circleAnim.duration = 1
        circleAnim.toValue = 1
        circleAnim.fillMode = CAMediaTimingFillMode.forwards
        circleAnim.isRemovedOnCompletion = false
        
        //a new layer is created with the animation and the circle
        circleLayer.add(circleAnim, forKey: nil)
        Circle.layer.addSublayer(circleLayer)
        Circle.layer.backgroundColor = UIColor.clear.cgColor
    }
}
