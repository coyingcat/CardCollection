//
//  SupplementaryView.swift
//  DragAndDropInCollectionView
//
//  Created by Jz D on 2020/9/15.
//  Copyright © 2020 Payal Gupta. All rights reserved.
//

import UIKit

class SupplementaryView: UICollectionReusableView {
      weak var label: UILabel?
    
      override init(frame: CGRect) {
          super.init(frame: frame)
          backgroundColor = UIColor.blue.withAlphaComponent(0.7)
      }

      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
      }
}
