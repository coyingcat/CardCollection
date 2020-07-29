/**
 * .
 */

import UIKit

final class PlayerCell: UICollectionViewCell {

  // MARK: - IBOutlets
  @IBOutlet weak var picture: UIImageView!

  // MARK: - View Life Cycle
  
  override func prepareForReuse() {
    super.prepareForReuse()

    picture.transform = .identity
  }
}
