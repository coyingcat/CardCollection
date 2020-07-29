/**
 * .
 */

import UIKit

struct CustomLayoutSettings {

  // Elements sizes
  private (set) var itemSizeH: CGFloat
  private (set) var headerSizeH: CGFloat
  
  var menuSize: CGSize?
  var sectionsHeaderSize: CGSize?
  var sectionsFooterSize: CGSize?

  // Behaviours
  private (set) var isHeaderStretchy: Bool
  private (set) var isAlphaOnHeaderActive: Bool
  private (set) var headerOverlayMaxAlphaValue: CGFloat
  private (set) var isMenuSticky: Bool
  private (set) var isSectionHeadersSticky: Bool
  private (set) var isParallaxOnCellsEnabled: Bool

  // Spacing
  private (set) var minimumInteritemSpacing: CGFloat
  private (set) var minimumLineSpacing: CGFloat
  private (set) var maxParallaxOffset: CGFloat
}

extension CustomLayoutSettings {

  init() {
    self.itemSizeH = 200
    self.headerSizeH = 300
    self.menuSize = nil
    self.sectionsHeaderSize = nil
    self.sectionsFooterSize = nil
    
    
    
    self.isHeaderStretchy = true
    self.isAlphaOnHeaderActive = true
    self.headerOverlayMaxAlphaValue = CGFloat(0.6)
    self.isMenuSticky = true
    self.isSectionHeadersSticky = true
    self.isParallaxOnCellsEnabled = true
    
    
    
    self.maxParallaxOffset = 60
    self.minimumInteritemSpacing = 0
    self.minimumLineSpacing = 3
  }
}
