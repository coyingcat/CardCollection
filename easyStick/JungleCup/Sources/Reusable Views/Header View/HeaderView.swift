/**
 * .
 */

import UIKit

final class HeaderView: UICollectionReusableView {

  
  @IBOutlet weak var img: UIImageView!
  
  
  
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
  
  
  override func awakeFromNib() {
//    img.layer.borderWidth = 3
//    img.layer.borderColor = UIColor.blue.cgColor
//    layer.borderWidth = 3
//    layer.borderColor = UIColor.systemPink.cgColor
  }
}
