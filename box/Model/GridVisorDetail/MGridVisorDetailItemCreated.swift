import UIKit

class MGridVisorDetailItemCreated:MGridVisorDetailItem
{
    let created:TimeInterval
    private let kCellHeight:CGFloat = 55
    
    init(model:MGridAlgoItemHostile)
    {
        let reusableIdentifier:String = VGridVisorDetailCellCreated.reusableIdentifier
        created = model.created
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
