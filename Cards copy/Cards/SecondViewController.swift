//
//  SecondViewController.swift
//  MMCardView
//
//  Created by MILLMAN on 2016/9/21.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

protocol SecondViewProtocol {
    func removeCard()
}
class SecondViewController: UIViewController {
    var delegate:SecondViewProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    @IBAction func disMissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func removeAction() {
        self.dismiss(animated: true) { 
            self.delegate?.removeCard()
        }
    }
    



}
