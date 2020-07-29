/**
 * .
 */

import UIKit

final class PlayerCell: UICollectionViewCell {

  // MARK: - IBOutlets
  @IBOutlet weak var picture: UIImageView!

  // MARK: - View Life Cycle
  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)

    guard let attributes = layoutAttributes as? CustomLayoutAttributes else {
      return
    }

    picture.transform = attributes.parallax
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()

    picture.transform = .identity
  }
}
