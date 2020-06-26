//
//  CardCCell.swift
//  MMCardView
//
//  Created by MILLMAN on 2016/9/21.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class CardCCell: CardCell {
   
    private var callBack:(()->Void)?

    func clickCallBack(c:@escaping ()->Void) {
        self.callBack = c
    }
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
