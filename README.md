# WIFIDemo
简单的介绍下RealReachability使用
RealReachability是能判断当前有无网络，以及判断当前网络状态的代码
```
头文件：#import "RealReachability.h"

@property (nonatomic, assign) BOOL isUserReal; // 当前网络是否可用
@property (nonatomic, assign) NSInteger status; // 当前网络状态

//发送通知
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkChanged:) name:kRealReachabilityChangedNotification object:nil];

- (void)netWorkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    self.isUserReal = YES;
    switch (status) {
        case RealStatusNotReachable:
            self.isUserReal = NO;
            self.status = 0;
            [self alertMessage:@"没网络"];
            break;
        case RealStatusViaWiFi:
            self.isUserReal = YES;
            self.status = 1;
            [self alertMessage:@"WIFI"];
            break;
        case RealStatusViaWWAN:
            self.isUserReal = YES;
            self.status = 2;
            [self alertMessage:@"2G/3G/4G"];
            break;
            
        default:
            break;
    }
}
```
