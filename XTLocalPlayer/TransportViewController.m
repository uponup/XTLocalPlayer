//
//  TransportViewController.m
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/11/14.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "TransportViewController.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "MyHTTPConnection.h"

@interface TransportViewController ()

@property (weak, nonatomic) IBOutlet UIView *transportTipView;
@property (weak, nonatomic) IBOutlet UILabel *transportUrlLabel;


@property (nonatomic, strong) HTTPServer * httpServer;

@end

@implementation TransportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.transportUrlLabel.text = [NSString stringWithFormat:@"http://%@:%hu", [Utils getIpAddresses], [self.httpServer listeningPort]];
    
    
    
}


#pragma mark - Lazy Method

- (HTTPServer *)httpServer {
    if (!_httpServer) {
        _httpServer = [[HTTPServer alloc] init];
        [_httpServer setPort:9527];
        [_httpServer setType:@"_http._tcp."];
        // webPath是server搜寻HTML等文件的路径
        NSString *webPath = [[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"web"] stringByDeletingLastPathComponent];
        CLog(@"===>:%@", webPath);
        [_httpServer setDocumentRoot:webPath];
        [_httpServer setConnectionClass:[MyHTTPConnection class]];
        NSError *err;
        if ([_httpServer start:&err]) {
            NSLog(@"port %hu",[_httpServer listeningPort]);
        }else{
            NSLog(@"%@",err);
        }
        NSString *ipStr = [Utils getIpAddresses];
        NSLog(@"ip地址 %@", ipStr);
    }
    return _httpServer;
}


@end
