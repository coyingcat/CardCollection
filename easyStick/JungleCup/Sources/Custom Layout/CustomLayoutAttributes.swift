/**
 * .
 */

import UIKit

final class CustomLayoutAttributes: UICollectionViewLayoutAttributes {

  // MARK: - Properties
  
  var initialOrigin = CGPoint.zero
  var headerOverlayAlpha = CGFloat.zero

  // MARK: - Life Cycle
  override func copy(with zone: NSZone?) -> Any {
    guard let copiedAttributes = super.copy(with: zone) as? CustomLayoutAttributes else {
      return super.copy(with: zone)
    }

    
    copiedAttributes.initialOrigin = initialOrigin
    copiedAttributes.headerOverlayAlpha = headerOverlayAlpha
    return copiedAttributes
  }
  
  override func isEqual(_ object: Any?) -> Bool {
    guard let otherAttributes = object as? CustomLayoutAttributes else {
      return false
    }

    if otherAttributes.initialOrigin != initialOrigin
      || otherAttributes.headerOverlayAlpha != headerOverlayAlpha {
        return false
    }

    return super.isEqual(object)
  }
}
