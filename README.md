# CardView, Swift 5


## 博客地址： [UICollectionView 自定制布局，例子是钱包界面](https://juejin.im/post/5ef5b7206fb9a07eae53ea3e)





## * 第 2 个例子，是 Parallax



### 2.1 简化，黏住效果


![easy](https://github.com/coyingcat/CardCollection/blob/master/Src/aaa.gif)




### 2.2 原版，小小改动



![原版](https://github.com/coyingcat/CardCollection/blob/master/Src/custom-layout-parallax-gif-final.gif)


基于 [Custom UICollectionViewLayout Tutorial With Parallax](https://www.raywenderlich.com/527-custom-uicollectionviewlayout-tutorial-with-parallax#toc-anchor-011) 


Parallax， 视差效果，

就是滚动的时候，cell 上面的图片 picture , 有一个纵向 ( y 轴 ) 的位移

上上下下的晃动

<hr>


## * 第一个例子，Demo


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

