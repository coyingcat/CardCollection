/**
 * .
 */

import UIKit

protocol MenuViewDelegate {
  func reloadCollectionViewDataWithTeamIndex(_ index: Int)
}

final class MenuView: UICollectionReusableView {

  // MARK: - Properties
  var delegate: MenuViewDelegate?
  
  // MARK: - View Life Cycle
  override func prepareForReuse() {
    super.prepareForReuse()

    delegate = nil
  }
}

// MARK: - IBActions
extension MenuView {

  @IBAction func tappedButton(_ sender: UIButton) {
    delegate?.reloadCollectionViewDataWithTeamIndex(sender.tag)
  }
}
