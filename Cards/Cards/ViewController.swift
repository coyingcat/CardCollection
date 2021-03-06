//
//  ViewController.swift
//  MMCardView
//
//  Created by Millman on 09/20/2016.
//  Copyright (c) 2016 Millman. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    var sectionData = [["CardA","CardB","CardC"],["CardB","CardB","CardB"],["CardC"],["CardD"]]
    @IBOutlet weak var cardCollection: MMCollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        cardCollection.dataSource = self
        
        
        
        cardCollection.register(UINib(nibName: "CardACell", bundle: nil), forCellWithReuseIdentifier: "CardA")
        cardCollection.register(UINib(nibName: "CardBCell", bundle: nil), forCellWithReuseIdentifier: "CardB")
        cardCollection.register(UINib(nibName: "CardCCell", bundle: nil), forCellWithReuseIdentifier: "CardC")
        
        if let layout = cardCollection.collectionViewLayout as? CustomCardLayout {
            layout.titleHeight = 100.0
            layout.bottomShowCount = 3
            layout.cardHeight = 300
       
        }
    }
    
    
    

    
}




extension ViewController: UICollectionViewDataSource{
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionData.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionData[section].count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
        let idenTifier = sectionData[indexPath.section][indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idenTifier, for: indexPath)
        switch cell {
        case let c as CardBCell:
            c.imgV.image = #imageLiteral(resourceName: "image1")
        default:
            break
        }
        return cell
    }
}

