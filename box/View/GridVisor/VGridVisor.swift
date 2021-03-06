import UIKit

class VGridVisor:VView
{
    private(set) weak var viewMetal:VGridVisorMetal?
    private(set) weak var viewBar:VGridVisorBar!
    private(set) weak var viewTarget:VGridVisorTarget!
    private weak var layoutTargetTop:NSLayoutConstraint!
    private weak var layoutTargetLeft:NSLayoutConstraint!
    private weak var spinner:VSpinner?
    private weak var controller:CGridVisor!
    private weak var previewLayer:CALayer?
    private let kBarHeight:CGFloat = 50
    private let kTargetSize:CGFloat = 220
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CGridVisor
        
        guard
            
            let viewMetal:VGridVisorMetal = VGridVisorMetal(
                controller:self.controller)
            
        else
        {
            let error:String = NSLocalizedString("VGridVisor_errorMetal", comment:"")
            VAlert.messageOrange(message:error)
            
            return
        }
        
        viewMetal.isHidden = true
        self.viewMetal = viewMetal
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VGridVisorBar = VGridVisorBar(
            controller:self.controller)
        self.viewBar = viewBar
        
        let viewTarget:VGridVisorTarget = VGridVisorTarget(
            controller:self.controller)
        self.viewTarget = viewTarget
        
        addSubview(viewMetal)
        addSubview(spinner)
        addSubview(viewBar)
        addSubview(viewTarget)
        
        NSLayoutConstraint.equals(
            view:viewMetal,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:spinner,
            toView:viewBar)
        NSLayoutConstraint.bottomToBottom(
            view:spinner,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        layoutTargetTop = NSLayoutConstraint.topToTop(
            view:viewTarget,
            toView:self)
        layoutTargetLeft = NSLayoutConstraint.leftToLeft(
            view:viewTarget,
            toView:self)
        NSLayoutConstraint.size(
            view:viewTarget,
            constant:kTargetSize)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        previewLayer?.frame = bounds
        
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let remainWidth:CGFloat = width - kTargetSize
        let remainHeight:CGFloat = height - kTargetSize
        let marginLeft:CGFloat = remainWidth / 2.0
        let marginTop:CGFloat = remainHeight / 2.0
        layoutTargetTop.constant = marginTop
        layoutTargetLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func showMetal()
    {
        spinner?.stopAnimating()
        spinner?.removeFromSuperview()
        viewMetal?.isHidden = false
    }
    
    func addPreviewLayer(previewLayer:CALayer)
    {
        self.previewLayer = previewLayer
        layer.addSublayer(previewLayer)
    }
}
