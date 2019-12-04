//
//  AboutViewController.m
//  XTLocalPlayer
//
//  Created by upon on 2019/12/4.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "AboutViewController.h"
#import <MessageUI/MessageUI.h>

#import "NormalView.h"
#import "UIView+NibCreatable.h"
#import "NSString+Extend.h"



@interface AboutViewController ()<MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) IBOutlet UIImageView *ivLogo;
@property (nonatomic, strong) IBOutlet UILabel *labelDetail;
@end

#define Items @[NSLocalizedString(@"去App Store评分", nil), NSLocalizedString(@"联系我们", nil)]
@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"关于", nil);
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *icon = [[infoDict valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    self.ivLogo.image = [UIImage imageNamed:icon];
    NSString *detail = [NSString stringWithFormat:@"%@ %@-%@", infoDict[@"CFBundleDisplayName"], infoDict[@"CFBundleShortVersionString"], infoDict[@"CFBundleVersion"]];
    self.labelDetail.text = detail;

    for (NSInteger i=0; i<Items.count; i++) {
        NSString *title = Items[i];
        NormalView *cell = [NormalView createFromNib];
        cell.title = title;
        cell.tag = i+100;
        [self.view addSubview:cell];
        [cell autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [cell autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [cell autoSetDimension:ALDimensionHeight toSize:58];
        [cell autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.ivLogo withOffset:80 + (i*58)];
        
        [cell addTarget:self action:@selector(cellControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)cellControlAction:(UIControl *)control {
    if (control.tag == 100) {
        
    }else {
        NSArray *contactChannel = @[@{
            @"title": NSLocalizedString(@"商务洽谈", nil),
            @"value": @"+86 17611102431",
        }, @{
            @"title": NSLocalizedString(@"意见反馈", nil),
            @"value": @"uponup@163.com",
        }];
        
        NSString *mesg = [NSString stringWithFormat:NSLocalizedString(@"感谢您选择这款应用，如果您能给我们一些反馈信息那就跟好了。您可以选择以下%@个渠道与我们联系：", nil), @(contactChannel.count)];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"联系我们", nil) message:mesg preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSInteger i=0; i<contactChannel.count; i++) {
            NSDictionary *channel = contactChannel[i];
            NSString *title = [NSString stringWithFormat:@"%@：%@", channel[@"title"], channel[@"value"]];
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self performAlertActionWithValue:channel[@"value"]];
            }];
            [alert addAction:action];
        }
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:actionCancel];
        
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Delegate: MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    switch (result){
        case MFMailComposeResultCancelled: // 用户取消编辑
            CLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            CLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent: // 用户点击发送
            CLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            CLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
    }
    
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private Method

- (void)performAlertActionWithValue:(NSString *)value {
    if ([value containsString:@"@"]) {
        // 邮件
        [self sendEmail:value];
    }else {
        // 电话
        NSString * telStr = [NSString stringWithFormat:@"tel:%@", [value removeWhiteSpace]];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {
            }];
        } else {
            //iOS10以前
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
        }
    }
}

- (void)sendEmail:(NSString *)email {
    if ([MFMailComposeViewController canSendMail]) {
        // 用户已设置邮件账户
        // 邮件服务器
        MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
        // 设置邮件代理
        mailCompose.mailComposeDelegate = self;
        
        // 设置邮件主题
        NSString *subjectTitle = [NSString stringWithFormat:@"%@ Feed back", [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"]];
        [mailCompose setSubject:subjectTitle];
        
        // 设置收件人
        [mailCompose setToRecipients:@[email]];
        // 设置抄送人
        //        [mailCompose setCcRecipients:@[@"iosfeedback@mavericksmobile.com"]];
        // 设置密抄送
        //        [mailCompose setBccRecipients:@[@"iosfeedback@mavericksmobile.com"]];
        
        /**
         *  设置邮件的正文内容
         */
        NSString *emailContent = @"Hi,\nProblem Description:\n\n\n===============\n";
        // 是否为HTML格式
        [mailCompose setMessageBody:emailContent isHTML:NO];
        
        // 弹出邮件发送视图
        [self presentViewController:mailCompose animated:YES completion:nil];
        
    }else{
        CLog(@"Please log in to your email and  send support mail.");
    }
}

@end
