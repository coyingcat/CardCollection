//
//  MMCardCollectionView.swift
//  Pods
//
//  Created by Millman YANG on 2017/6/21.
//
//

import UIKit

public class MMCollectionView: UICollectionView {
    fileprivate var transition = CustomFlipTransition(duration: 0.5)

    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.setup()
    }
    
    func setup() {
        self.delegate = self
        self.collectionViewLayout = CustomCardLayout()
   
    }
    
    override public var bounds: CGRect {
        didSet {
            if oldValue != bounds, bounds.size != .zero {
                switch collectionViewLayout {
                case let l as CustomCardLayout:
                    l.updateCellSize()
                default:
                    break
                }
                self.reloadData()
            }
        }
    }

 
}






extension MMCollectionView: UICollectionViewDelegate {
    
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let c = cell as? CardCell {
            c.collectionV = collectionView
            c.reloadBlock = {
                if let custom = collectionView.collectionViewLayout as? CustomCardLayout {
                    custom.selectPath = nil
                }
            }
            c.isHidden = false
        }
   
    }
    
    
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.collectionViewLayout {
        case let l as CustomCardLayout:
            l.selectPath = indexPath
        default:
            break
        }
     
    }
}

extension MMCollectionView: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        if let custom = collectionViewLayout as? CustomCardLayout, let path = custom.selectPath {

            transition.cardView = self.cellForItem(at: path)
            custom.isFullScreen = true
        }
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        if let custom = collectionViewLayout as? CustomCardLayout {
            custom.isFullScreen = false
        }
        return transition
    }
}
