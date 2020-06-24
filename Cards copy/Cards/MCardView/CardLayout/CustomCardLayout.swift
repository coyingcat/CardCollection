//
//  CustomCardLayout.swift
//  Pods
//
//  Created by MILLMAN on 2016/9/20.
//
//

import UIKit

let BottomPercent:CGFloat = 0.85



class CardLayoutAttributes: UICollectionViewLayoutAttributes {
    var isExpand = false

    override func copy(with zone: NSZone? = nil) -> Any {
        let attribute = super.copy(with: zone) as! CardLayoutAttributes
        attribute.isExpand = isExpand
        return attribute
    }
}

public class CustomCardLayout: UICollectionViewLayout {
    
    
    fileprivate var insertPath = [IndexPath]()
    fileprivate var deletePath = [IndexPath]()
    fileprivate var attributeList = [CardLayoutAttributes]()
    
    

    fileprivate var _selectPath: IndexPath? {
        didSet {
            self.collectionView!.isScrollEnabled = (_selectPath == nil)
        }
    }
    
    
    
    public var selectPath: IndexPath? {
        set {
            _selectPath = (_selectPath == newValue) ? nil : newValue
            self.collectionView?.performBatchUpdates({
                self.invalidateLayout()
            }, completion: nil)
        } get {
            return _selectPath
        }
    }
    
    
    
    public var bottomShowCount = 6 {
        didSet {
            self.collectionView?.performBatchUpdates({
                self.collectionView?.reloadData()
            }, completion: nil)
        }
    }
    
    public var isFullScreen = false {
        didSet {
            self.collectionView?.performBatchUpdates({
                self.collectionView?.reloadData()
            }, completion: nil)
        }
    }
    
    public var titleHeight:CGFloat = 56 {
        didSet {
            self.collectionView?.performBatchUpdates({ 
                self.invalidateLayout()
            }, completion: nil)
        }
    }
    
    public var cardHeight: CGFloat = 320 {
        didSet {
            var c = cellSize
            c.height = cardHeight
            cellSize = c
            collectionView?.performBatchUpdates({ 
                self.invalidateLayout()
            }, completion: nil)
        }
    }
    
    lazy var cellSize:CGSize = {
        guard let collection = collectionView else {
            return .zero
        }
        
        let w = collection.bounds.width
        let h = collection.bounds.height * BottomPercent
        let size = CGSize(width: w, height: h)
        return size
    }()

    override public var collectionViewContentSize: CGSize {
        guard let collection = collectionView else {
            return .zero
        }
        let sections = collection.numberOfSections
        let total = (0..<sections).reduce(0){ (t, current) -> Int in
            t + collection.numberOfItems(inSection: current)
        }
        let contentHeight = titleHeight * CGFloat(total-1) + cellSize.height
        return CGSize(width: cellSize.width, height: contentHeight )
    }
    
     func updateCellSize(){
        guard let collection = collectionView else {
            return
        }
        self.cellSize.width  = collection.frame.width
        self.cellSize.height = cardHeight * BottomPercent
    }
    
    override public func prepare() {
        super.prepare()
        guard let collection = collectionView else {
            return
        }
        let update = collection.calculate.isNeedUpdate()
    
        if let select = selectPath, !update {
            
            var bottomIdx:CGFloat = 0
            self.attributeList.forEach({
                if $0.indexPath == select {
                    setSelect(attribute: $0)
                } else {
                    setBottom(attribute: $0, bottomIdx: &bottomIdx)
                }
            })
        } else {
            _selectPath = nil
            if !update , collection.calculate.totalCount == attributeList.count {
                attributeList.forEach({ [unowned self] in
                    self.setNoSelect(attribute: $0)
                })
                return
            }
            let list = generateAttributeList
            if list.count > 0 {
                attributeList.removeAll()
                attributeList += list
            }
        }
    }
    
    fileprivate var generateAttributeList: [CardLayoutAttributes] {
        var arr = [CardLayoutAttributes]()
        guard let collection = collectionView else {
            return arr
        }
        let offsetY = max(collection.contentOffset.y, 0)
        let startIdx = abs(Int(offsetY/titleHeight))
        let sections = collection.numberOfSections
        var itemsIdx = 0
        
        for sec in 0..<sections {
            let count = collection.numberOfItems(inSection: sec)
            if (itemsIdx + count - 1) < startIdx {
                itemsIdx += count
                continue
            }
            for item in 0..<count {
                if itemsIdx >= startIdx {
                    let indexPath = IndexPath(item: item, section: sec)
                    let attr = CardLayoutAttributes(forCellWith: indexPath)
                    attr.zIndex = itemsIdx
                    setNoSelect(attribute: attr)
                    arr.append(attr)
                }
                itemsIdx += 1
            }
        }
        return arr
    }
    
    fileprivate func setNoSelect(attribute:CardLayoutAttributes) {
        guard let collection = collectionView else {
            return
        }
        let shitIdx = Int(collection.contentOffset.y/titleHeight)
        if shitIdx < 0 {
            return
        }
        attribute.isExpand = false
        let index = attribute.zIndex
        var currentFrame = CGRect(x: collection.frame.origin.x, y: titleHeight * CGFloat(index), width: cellSize.width, height: cellSize.height)
 
                
        if index <= shitIdx , index >= shitIdx{
            attribute.frame = CGRect(x: currentFrame.origin.x, y: collection.contentOffset.y, width: cellSize.width, height: cellSize.height)
        } else if index <= shitIdx, currentFrame.maxY > collection.contentOffset.y{
            currentFrame.origin.y -= (currentFrame.maxY - collection.contentOffset.y )
            attribute.frame = currentFrame
        }else {
            attribute.frame = currentFrame
        }

    }
    
    fileprivate func setSelect(attribute:CardLayoutAttributes) {
        guard let collection = collectionView else {
            return
        }
        attribute.isExpand = true
        // 0.01 prevent no reload
        attribute.frame = CGRect(x: collection.frame.origin.x, y: collection.contentOffset.y + 0.01 , width: cellSize.width, height: cellSize.height)
    }
    
    fileprivate func setBottom(attribute:CardLayoutAttributes, bottomIdx:inout CGFloat) {
        guard let collection = collectionView else {
            return
        }
        let baseHeight = collection.contentOffset.y + collection.bounds.height * 0.9
        let bottomH = cellSize.height * 0.1
        let margin:CGFloat = bottomH/CGFloat(bottomShowCount-1)
        attribute.isExpand = false
        let yPos = isFullScreen ? (collection.contentOffset.y + collection.bounds.height) : ( bottomIdx * margin + baseHeight )
        attribute.frame = CGRect(x: 0, y: yPos, width: cellSize.width, height: cellSize.height)
        bottomIdx += 1
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let first = attributeList.first(where: { $0.indexPath == indexPath }) else {
            return CardLayoutAttributes(forCellWith: indexPath)
        }
        return first
    }

    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collection = collectionView else {
            return nil
        }
        var reset = rect
        reset.origin.y = collection.contentOffset.y
        
        let arr = attributeList.filter {
            var fix = $0.frame
            fix.size.height = titleHeight
            return fix.intersects(reset)
        }
        return arr
    }
    
    override public func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let at = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
        guard let collection = collectionView, let a = at else {
            return at
        }
        if deletePath.contains(itemIndexPath) {
            if let original = attributeList.first(where: { $0.indexPath == itemIndexPath }) {
                a.frame = original.frame
            }
            let randomLoc = (itemIndexPath.row % 2 == 0) ? 1 : -1
            let x = collection.frame.width * CGFloat(randomLoc)
            a.transform = CGAffineTransform(translationX: x, y: 0)
        }
        
        return a
    }
    
    override public func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let at = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        guard let collection = collectionView, let a = at else {
            return at
        }
        if self.insertPath.contains(itemIndexPath) {
            let randomLoc = (itemIndexPath.row%2 == 0) ? 1 : -1
            let x = collection.frame.width * CGFloat(-randomLoc)
            a.transform = CGAffineTransform(translationX: x, y: 0)
        }
        return a
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override public func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        deletePath.removeAll()
        insertPath.removeAll()
        for update in updateItems {
            if update.updateAction == .delete {
                
                let path = (update.indexPathBeforeUpdate != nil) ? update.indexPathBeforeUpdate : update.indexPathAfterUpdate
                if let p = path {
                    deletePath.append(p)
                }
            }
            else if let path = update.indexPathAfterUpdate, update.updateAction == .insert {
                insertPath.append(path)
            }
        }
    }
    
    override public func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        guard let collection = collectionView else {
            return
        }
        if deletePath.count > 0 || insertPath.count > 0 {
            deletePath.removeAll()
            insertPath.removeAll()
            
            let vi = collection.subviews.sorted {
                $0.layer.zPosition < $1.layer.zPosition
            }
            
            vi.forEach({ (vi) in
                collection.addSubview(vi)
            })
            
        }
    }
}
