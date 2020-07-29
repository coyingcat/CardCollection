/**
 * .
 */

import UIKit

struct CustomLayoutSettings {

  // Elements sizes
  var itemSize: CGSize?
  var headerSize: CGSize?
  var menuSize: CGSize?
  var sectionsHeaderSize: CGSize?
  var sectionsFooterSize: CGSize?

  // Behaviours
  var isHeaderStretchy: Bool
  var isAlphaOnHeaderActive: Bool
  var headerOverlayMaxAlphaValue: CGFloat
  var isMenuSticky: Bool
  var isSectionHeadersSticky: Bool
  var isParallaxOnCellsEnabled: Bool

  // Spacing
  var minimumInteritemSpacing: CGFloat
  var minimumLineSpacing: CGFloat
  var maxParallaxOffset: CGFloat
}

extension CustomLayoutSettings {

  init() {
    self.itemSize = nil
    self.headerSize = nil
    self.menuSize = nil
    self.sectionsHeaderSize = nil
    self.sectionsFooterSize = nil
    self.isHeaderStretchy = false
    self.isAlphaOnHeaderActive = true
    self.headerOverlayMaxAlphaValue = 0
    self.isMenuSticky = false
    self.isSectionHeadersSticky = false
    self.isParallaxOnCellsEnabled = false
    self.maxParallaxOffset = 0
    self.minimumInteritemSpacing = 0
    self.minimumLineSpacing = 0
  }
}
