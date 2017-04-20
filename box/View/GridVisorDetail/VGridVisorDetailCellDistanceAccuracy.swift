import UIKit

class VGridVisorDetailCellDistanceAccuracy:UIView
{
    private let initialRadius:CGFloat
    private let endingRadius:CGFloat
    private let kRadius:CGFloat = 16
    private let kLineWidth:CGFloat = 6
    private let kBackgroundInitial:CGFloat = 0
    private let kBackgroundEnding:CGFloat = -0.0001
    
    init(distance:Double)
    {
        initialRadius = CGFloat.pi / -2.0
        
        let pi2:CGFloat = CGFloat.pi + CGFloat.pi
        var endingPercentage:CGFloat = CGFloat(distance / MGridAlgo.kMaxDistance)
        
        if endingPercentage > 1
        {
            endingPercentage = 1
        }
        
        let endingRadians:CGFloat = endingPercentage * pi2
        endingRadius = endingRadians + initialRadius
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func draw(_ rect:CGRect)
    {
        guard
        
            let context:CGContext = UIGraphicsGetCurrentContext()
        
        else
        {
            return
        }
        
        let width:CGFloat = rect.maxX
        let height:CGFloat = rect.maxY
        let width_2:CGFloat = width / 2.0
        let height_2:CGFloat = height / 2.0
        let center:CGPoint = CGPoint(x:width_2, y:height_2)
        
        context.setLineCap(CGLineCap.round)
        context.setLineWidth(kLineWidth)
        context.setStrokeColor(UIColor(white:0, alpha:0.1).cgColor)
        
        context.addArc(
            center:center,
            radius:kRadius,
            startAngle:kBackgroundInitial,
            endAngle:kBackgroundEnding,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.stroke)
        
        context.setStrokeColor(UIColor.gridBlue.cgColor)
        context.addArc(
            center:center,
            radius:kRadius,
            startAngle:initialRadius,
            endAngle:endingRadius,
            clockwise:false)
        
        context.drawPath(using:CGPathDrawingMode.stroke)
    }
}