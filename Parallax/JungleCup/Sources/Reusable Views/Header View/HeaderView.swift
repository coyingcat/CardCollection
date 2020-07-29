/**
 * .
 */

import UIKit

final class HeaderView: UICollectionReusableView {

  // MARK: - IBOutlets
  @IBOutlet weak var overlayView: UIView!

  // MARK: - Life Cycle
  public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)

    guard let customFlowLayoutAttributes = layoutAttributes as? CustomLayoutAttributes else {
      return
    }

    overlayView?.alpha = customFlowLayoutAttributes.headerOverlayAlpha
  }
}
