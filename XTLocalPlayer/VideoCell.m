//
//  VideoCell.m
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/11/15.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "VideoCell.h"
#import "NSFileManager+Category.h"

@interface VideoCell()
@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (weak, nonatomic) IBOutlet UIImageView *ivMark;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelSize;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@end

@implementation VideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.ivMark.hidden = YES;
    
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.backgroundColor = UIColor.whiteColor;
    self.tintColor = GlobalThemeColor;
}

- (void)setModel:(FileModel *)model {
    _model = model;
    NSString *absolutePath = [File_PATH stringByAppendingString:model.path];
    self.iv.image = [self _thumbnailImageForVideo:absolutePath atTime:1.0];
    self.labelTitle.text = model.name;
    self.labelSize.text = [self _fileSizeWithPath:absolutePath];
    self.labelDate.text = [self _dateWithTimestamp:model.timestamp];
}

#pragma mark - Private Method
// 获取视频封面
- (UIImage*)_thumbnailImageForVideo:(NSString *)path atTime:(NSTimeInterval)time {
    NSURL *videoURL = [NSURL fileURLWithPath:path];
    CLog(@"====>: %@", videoURL);
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : [UIImage imageNamed:@"default_img.png"];
    
    return thumbnailImage;
}

- (NSString *)_fileSizeWithPath:(NSString *)path {
    NSString *fileName = @"";
    CGFloat size = [[NSFileManager fileSizWithPath:path] floatValue];
    if (size < 1024) {
        fileName = [NSString stringWithFormat:@"%.fb", size];
    }else if (size < 1024 * 1024) {
        fileName = [NSString stringWithFormat:@"%.fKb", size/1024];
    }else if (size < 1024 * 1024 * 1024){
        fileName = [NSString stringWithFormat:@"%.fMb", size/1024/1024];
    }else {
        fileName = [NSString stringWithFormat:@"%.fGb", size/1024/1024/1024];
    }
    return [NSString stringWithFormat:NSLocalizedString(@"size:%@", nil), fileName];
}

- (NSString *)_dateWithTimestamp:(NSTimeInterval)timestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    return [formatter stringFromDate:date];
}
@end
