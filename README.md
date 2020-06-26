# CardView, Swift 5


## Demo


Latest Simple Card



Origin Card

![demo](https://github.com/MillmanY/MMCardView/blob/master/demo.gif)



## from MillmanY/MMCardView



## Use Card


1.Inherit your collectionView to MMCollectionView
       
    @IBOutlet weak var cardCollection: MMCollectionView!
    
2.Create your Cell inherit "CardCell"

    class CardACell: CardCell {

    }

    if let layout = cardCollection.collectionViewLayout as? CustomCardLayout {
         layout.titleHeight = 100.0
         layout.bottomShowCount = 3
         layout.cardHeight = 300
         layout.showStyle = .cover
    }



## Installation : Just DIY

