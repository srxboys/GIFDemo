/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "YLImageView+WebCache.h"
#import "objc/runtime.h"
#import "YLGIFImage.h"
#import "objc/runtime.h"
#import "UIView+WebCacheOperation.h"
#import "UIView+WebCache.h"
#import "NSData+ImageContentType.h"
#import "UIImageView+WebCache.h"

static char imageURLKey;

@implementation YLImageView (WebCache)

- (void)sd_setImageWithURL:(NSURL *)url {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)sd_setImageWithURL:(NSURL *)url completed:(SDExternalCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDExternalCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDExternalCompletionBlock)completedBlock {
    [self sd_cancelCurrentImageLoad];
    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (!(options & SDWebImageDelayPlaceholder)) {
        self.image = placeholder;
    }
    
    if (url) {
        __weak UIImageView *weakSelf = self;
        
        [self sd_internalSetImageWithURL:url
                        placeholderImage:placeholder
                                 options:options
                            operationKey:nil
                           setImageBlock:^(UIImage *image, NSData *imageData) {
                               SDImageFormat imageFormat = [NSData sd_imageFormatForImageData:imageData];
                               if (imageFormat == SDImageFormatGIF) {
                                   UIImage* gifImg = [YLGIFImage imageWithData:imageData];
                                   weakSelf.image = gifImg;
                               } else if (image) {
                                       weakSelf.image = image;
                                       [weakSelf setNeedsLayout];
                               }
                               else {
                                       if ((options & SDWebImageDelayPlaceholder)) {
                                           weakSelf.image = placeholder;
                                           [weakSelf setNeedsLayout];
                                       }
                                   }
                           }
                                progress:progressBlock
                               completed:completedBlock];
        
//        id <SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadImageWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSData* data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//            if (!wself) return;
//            dispatch_main_sync_safe(^{
//                if (!wself) return;
//                if (image) {
//                    wself.image = image;
//                    [wself setNeedsLayout];
//                } else if (data) {
//                    UIImage* gifImg = [YLGIFImage imageWithData:data];
//                    wself.image = gifImg;
//                    [wself setNeedsLayout];
//                } else {
//                    if ((options & SDWebImageDelayPlaceholder)) {
//                        wself.image = placeholder;
//                        [wself setNeedsLayout];
//                    }
//                }
//                if (completedBlock && finished) {
//                    completedBlock(image, data, error, cacheType, url);
//                }
//            });
//        }];
//        [self sd_setImageLoadOperation:operation forKey:@"YLImageViewImageLoad"];
//    } else {
//        dispatch_main_async_safe(^{
//            NSError *error = [NSError errorWithDomain:@"SDWebImageErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
//            if (completedBlock) {
//                completedBlock(nil, nil, error, SDImageCacheTypeNone, url);
//            }
//        });
    }
}

- (void)sd_setImageWithPreviousCachedImageWithURL:(NSURL *)url andPlaceholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDExternalCompletionBlock)completedBlock {
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    UIImage *lastPreviousCachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    
    [self sd_setImageWithURL:url placeholderImage:lastPreviousCachedImage ?: placeholder options:options progress:progressBlock completed:completedBlock];
}

- (NSURL *)sd_imageURL {
    return objc_getAssociatedObject(self, &imageURLKey);
}

- (void)sd_cancelCurrentImageLoad {
    [self sd_cancelImageLoadOperationWithKey:@"YLImageViewImageLoad"];
}


@end
