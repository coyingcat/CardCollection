# CardView, Swift 5


## 博客地址： [UICollectionView 自定制布局，例子是钱包界面](https://juejin.im/post/5ef5b7206fb9a07eae53ea3e)


## Demo


Latest Simple Card




![new](https://github.com/coyingcat/CardCollection/blob/master/Src/1111.gif)


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

