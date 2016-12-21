# GIFDemo
* gif 基于SDWebImage 动图随便玩【srxboys】
* 亲测 

-
## EXAMPLE
```objc
//本地gif
NSData * data = [NSData dataWithContentsOfFile:本地地址];
UIImage* gifImg = [YLGIFImage imageWithData:data];
imgView.image = gifImg;

//网络gif
[_imgView sd_setImageWithURL:[NSURL URLWithString:图片地址字符串]];
```
-

###效果图(如下):

![srxboys_RXGifDemo](https://github.com/srxboys/GIFDemo/blob/master/gifDemo.gif) 

-


//原作者:liyong03 <br />
https://github.com/liyong03/YLGIFImage <br />
https://github.com/liyong03/SDWebImage-YLGIFImage
