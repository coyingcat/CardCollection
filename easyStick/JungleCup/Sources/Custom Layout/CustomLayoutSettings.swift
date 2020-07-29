/**
 * .
 */

import UIKit

struct CustomLayoutSettings {

  // Elements sizes
  private (set) var itemSizeH: CGFloat
  private (set) var headerSizeH: CGFloat
  
  private (set) var menuSizeH: CGFloat

  // Behaviours
  private (set) var headerOverlayMaxAlphaValue: CGFloat

  // Spacing
  private (set) var minimumInteritemSpacing: CGFloat
  private (set) var minimumLineSpacing: CGFloat
}

extension CustomLayoutSettings {

  init() {
    self.itemSizeH = 200
    self.headerSizeH = 300
    
    self.menuSizeH = 70
    
    self.headerOverlayMaxAlphaValue = CGFloat(0.6)
    
    self.minimumInteritemSpacing = 0
    self.minimumLineSpacing = 3
  }
}
