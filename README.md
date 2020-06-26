# CardView, Swift 5


## Demo


Latest Simple Card



<video width="320" height="240" autoplay>
  <source src="https://github.com/coyingcat/CardCollection/blob/master/Src/aa.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>



![tip](https://github.com/coyingcat/CardCollection/blob/master/Src/_wwwweee.png)


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

