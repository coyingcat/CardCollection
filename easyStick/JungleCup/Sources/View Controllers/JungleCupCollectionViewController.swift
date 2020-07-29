/**
 * .
 */

import UIKit

final class JungleCupCollectionViewController: UICollectionViewController {
 
  // MARK: - Properties
  var customLayout: CustomLayout? {
      collectionView?.collectionViewLayout as? CustomLayout
  }


  override var prefersStatusBarHidden: Bool {
      true
  }

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    setupCollectionViewLayout()
  }
}

private extension JungleCupCollectionViewController {

  func setupCollectionViewLayout() {
    
    guard let collectionView = collectionView else { return }

    collectionView.register(
      UINib(nibName: "HeaderView", bundle: nil),
      forSupplementaryViewOfKind: CustomLayout.Element.header.kind,
      withReuseIdentifier: CustomLayout.Element.header.id
    )

    collectionView.register(
      UINib(nibName: "MenuView", bundle: nil),
      forSupplementaryViewOfKind: CustomLayout.Element.menu.kind,
      withReuseIdentifier: CustomLayout.Element.menu.id
    )

   
  }
}

//MARK: - UICollectionViewDataSource
extension JungleCupCollectionViewController {

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Tigers().playerPictures[section].count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomLayout.Element.cell.id, for: indexPath)
    if let playerCell = cell as? PlayerCell {
      playerCell.picture.image = UIImage(named: Tigers().playerPictures[indexPath.section][indexPath.item])
    }
    return cell
  }

  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case CustomLayout.Element.header.kind:
      let topHeaderView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: CustomLayout.Element.header.id,
        for: indexPath
      )
      return topHeaderView

    case CustomLayout.Element.menu.kind:
      let menuView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: CustomLayout.Element.menu.id,
        for: indexPath
      )
      if let menuView = menuView as? MenuView {
        menuView.delegate = self
      }
      return menuView

    default:
      return UICollectionReusableView()
    }
  }
}

// MARK: - MenuViewDelegate
extension JungleCupCollectionViewController: MenuViewDelegate {

  func reloadCollectionViewDataWithTeamIndex(_ index: Int) {
    
    
  }
}
