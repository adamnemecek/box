import UIKit

class VBoards:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CBoards!
    private weak var collectionView:VCollection!
    private weak var spinner:VSpinner?
    private let kBarHeight:CGFloat = 50
    private let kCollectionBottom:CGFloat = 20
    private let kCellHeight:CGFloat = 80
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CBoards
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VBoardsBar = VBoardsBar(
            controller:self.controller)
        
        let collectionView:VCollection = VCollection()
        collectionView.isHidden = true
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VBoardsCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.sectionInset = UIEdgeInsets(
                top:kBarHeight + kCollectionBottom,
                left:0,
                bottom:kCollectionBottom,
                right:0)
        }
        
        addSubview(spinner)
        addSubview(collectionView)
        addSubview(viewBar)
        
        NSLayoutConstraint.equals(
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
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MBoardsItem
    {
        let item:MBoardsItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        collectionView.isHidden = false
        collectionView.reloadData()
        spinner?.removeFromSuperview()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = bounds.maxX
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MBoardsItem = modelAtIndex(index:indexPath)
        let cell:VBoardsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VBoardsCell.reusableIdentifier,
            for:indexPath) as! VBoardsCell
        cell.config(item:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
}
