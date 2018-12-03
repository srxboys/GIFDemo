# GIFDemo
* gif 基于SDWebImage 动图随便玩【srxboys】
* 亲测 

-
## EXAMPLE
```objc
#import "YLImageView.h"
#import "YLGIFImage.h"
//本地gif
NSData * data = [NSData dataWithContentsOfFile:本地地址];
UIImage* gifImg = [YLGIFImage imageWithData:data];
imgView.image = gifImg;
```

```objc
#import "YLImageView.h"
#import "YLImageView+WebCache.h"
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

<br />

> GitHub other:
- 读帧 gif webp pnga ...
> - [YYImage](https://github.com/ibireme/YYImage)
> - [PINRemoteImage](https://github.com/pinterest/PINRemoteImage)
 
- only gif 格式
> - [YLGIFImage](https://github.com/liyong03/YLGIFImage)
> - [FLAnimatedImage](https://github.com/Flipboard/FLAnimatedImage)
 
- 读帧
> - [MJRefresh](https://github.com/CoderMJLee/MJRefresh)

- 
> - [iOS-WebP](https://github.com/seanooi/iOS-WebP)
 
- 
> - [GiftCard-iOS](https://github.com/MartinRGB/GiftCard-iOS)


