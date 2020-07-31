/**
 * .
 */

import UIKit

final class CustomLayout: UICollectionViewLayout {
  
  enum Element: String {
    case header
    case menu
    case cell
    
    var id: String {
        rawValue
    }
    
    var kind: String {
        "Kind\(rawValue.capitalized)"
    }
  }
  
  override public class var layoutAttributesClass: AnyClass {
     CustomLayoutAttributes.self
  }
  
  override public var collectionViewContentSize: CGSize {
     CGSize(width: collectionViewWidth, height: contentHeight)
  }
  
  // MARK: - Properties
  let settings = CustomLayoutSettings()
  private var oldBounds = CGRect.zero
  private var contentHeight = CGFloat.zero
  private var cache = [Element: [IndexPath: CustomLayoutAttributes]]()
  private var visibleLayoutAttributes = [CustomLayoutAttributes]()
  private var zIndex = 0
  
  private var collectionViewHeight: CGFloat {
     collectionView!.frame.height
  }
  
  private var collectionViewWidth: CGFloat {
     collectionView!.frame.width
  }
  
  private var cellHeight: CGFloat {
     settings.itemSizeH
  }
  
  private var headerSize: CGSize {
     CGSize(width: collectionViewWidth, height: settings.headerSizeH)
  }
  
  private var menuSize: CGSize {
    CGSize(width: collectionViewWidth, height: settings.menuSizeH)
  }
  
  private var contentOffset: CGPoint {
    collectionView!.contentOffset
  }
}

// MARK: - LAYOUT CORE PROCESS
extension CustomLayout {
  
  override public func prepare() {
    guard let collectionView = collectionView, collectionView.numberOfItems(inSection: 0) > 0 else {
        return
    }
    
    prepareCache()
    contentHeight = 0
    zIndex = 0
    oldBounds = collectionView.bounds
    let itemSize = CGSize(width: collectionViewWidth, height: cellHeight)
    
    let headerAttributes = CustomLayoutAttributes(
      forSupplementaryViewOfKind: Element.header.kind,
      with: IndexPath(item: 0, section: 0)
    )
    prepareElement(size: headerSize, type: .header, attributes: headerAttributes)
    
    let menuAttributes = CustomLayoutAttributes(
      forSupplementaryViewOfKind: Element.menu.kind,
      with: IndexPath(item: 0, section: 0))
    prepareElement(size: menuSize, type: .menu, attributes: menuAttributes)
    
    
      for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
        let cellIndexPath = IndexPath(item: item, section: 0)
        let attributes = CustomLayoutAttributes(forCellWith: cellIndexPath)
        let lineInterSpace = settings.minimumLineSpacing
        attributes.frame = CGRect(
          x: settings.minimumInteritemSpacing,
          y: contentHeight + lineInterSpace,
          width: itemSize.width,
          height: itemSize.height
        )
        attributes.zIndex = zIndex
        contentHeight = attributes.frame.maxY
        cache[.cell]?[cellIndexPath] = attributes
        zIndex += 1
      }
    
    cache[.menu]?.first?.value.zIndex = zIndex
  }
  
  override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    if oldBounds.size != newBounds.size {
      cache.removeAll(keepingCapacity: true)
    }
    return true
  }
  
  private func prepareCache() {
    cache.removeAll(keepingCapacity: true)
    cache[.header] = [IndexPath: CustomLayoutAttributes]()
    cache[.menu] = [IndexPath: CustomLayoutAttributes]()
    cache[.cell] = [IndexPath: CustomLayoutAttributes]()
  }
  
  private func prepareElement(size: CGSize, type: Element, attributes: CustomLayoutAttributes) {
    guard size != .zero else { return }
    
    attributes.initialOrigin = CGPoint(x: 0, y: contentHeight)
    attributes.frame = CGRect(origin: attributes.initialOrigin, size: size)
    
    attributes.zIndex = zIndex
    zIndex += 1
    
    contentHeight = attributes.frame.maxY
    
    cache[type]?[attributes.indexPath] = attributes
  }
}

//MARK: - PROVIDING ATTRIBUTES TO THE COLLECTIONVIEW
extension CustomLayout {
  
  public override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    switch elementKind {
    case Element.header.kind:
      return cache[.header]?[indexPath]
    case CustomLayout.Element.menu.kind:
      return cache[.menu]?[indexPath]
    default:
      return nil
    }
  }
  
  override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache[.cell]?[indexPath]
  }
  
  override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let collectionView = collectionView else { return nil }
    
    visibleLayoutAttributes.removeAll(keepingCapacity: true)
    for (type, elementInfos) in cache {
      for (indexPath, attributes) in elementInfos {
        
        
        attributes.transform = .identity
        
        updateSupplementaryViews(type, attributes: attributes, collectionView: collectionView, indexPath: indexPath)
        if attributes.frame.intersects(rect) {
          if type == .cell{
            updateCells(attributes, collectionView: collectionView, indexPath: indexPath)
          }
          visibleLayoutAttributes.append(attributes)
        }
      }
    }
    return visibleLayoutAttributes
  }
  
  private func updateSupplementaryViews(_ type: Element, attributes: CustomLayoutAttributes, collectionView: UICollectionView, indexPath: IndexPath) {
    switch type {
    case .header:
        attributes.transform = CGAffineTransform(translationX: 0, y: contentOffset.y)
        attributes.headerOverlayAlpha = min(settings.headerOverlayMaxAlphaValue, contentOffset.y / headerSize.height)
    case .menu:
      print(contentOffset.y)
      if contentOffset.y < 0{
        attributes.transform = CGAffineTransform(translationX: 0, y: attributes.initialOrigin.y - headerSize.height + contentOffset.y)
      }
      else{
        attributes.transform = CGAffineTransform(translationX: 0, y: max(attributes.initialOrigin.y, contentOffset.y) - headerSize.height)
      }
        
    default:
      break
    }
  }
  
  
  private func updateCells(_ attributes: CustomLayoutAttributes, collectionView: UICollectionView, indexPath: IndexPath) {
      if contentOffset.y < 0{
        attributes.transform = CGAffineTransform(translationX: 0, y: attributes.initialOrigin.y + contentOffset.y)
      }

  }
  
 
}

