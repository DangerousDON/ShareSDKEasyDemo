//
//  ViewController.m
//  ShareSDKEasyDemo
//
//  Created by DonelAccount on 14/12/27.
//  Copyright (c) 2014年 Code4App co.Ltd. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import <FacebookConnection/ISSFacebookApp.h>
@interface ViewController ()<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.versionLabel.text = [NSString stringWithFormat:@"当前ShareSDK版本:%@",[ShareSDK version]];
#warning 注意,本Demo只是列举ShareSDK的初步使用方法,适合刚刚学习使用ShareSDK的小伙伴，提供了多个最多人使用的平台，基本上可以满足大部分使用者的需求。另外更多的平台使用方法基本一致。更进阶更高级更完整的使用方法请参考ShareSDK.h顶层类，或者到ShareSDK官方http://mob.com下载官方的demo或者咨询官方技术支持。
  
}
- (IBAction)ShowShareView:(UIButton *)sender {
    ShareType type = 0;
    switch (sender.tag) {
        case 1:
            type = ShareTypeSinaWeibo;
            break;
        case 2:
            type = ShareTypeTencentWeibo;
            break;
        case 3:
            type = ShareTypeRenren;
            break;
        case 4:
            type = ShareTypeWeixiSession;
            break;
        case 5:
            type = ShareTypeWeixiTimeline;
            break;
        case 6:
            type = ShareTypeQQ;
            break;
        case 7:
            type = ShareTypeQQSpace;
            break;
        case 8:
            type = ShareTypeFacebook;
            break;
        case 9:
            type = ShareTypeTwitter;
            break;
        case 10:
            type = ShareTypeSMS;
            break;
        case 11:
            type = ShareTypeMail;
            break;
        default:
            break;
    }
    
    //1.定制分享的内容
    NSString* path = [[NSBundle mainBundle]pathForResource:@"ShareSDK" ofType:@"jpg"];
    id<ISSContent> publishContent = [ShareSDK content:@"Hello,Code4App.com!" defaultContent:nil image:[ShareSDK imageWithPath:path] title:@"This is title" url:@"http://mob.com" description:@"This is description" mediaType:SSPublishContentMediaTypeNews];
    
    // 定制新浪微博的分享信息
    [publishContent addSinaWeiboUnitWithContent:@"定制新浪微博的分享信息" image:[ShareSDK imageWithPath:path]];
    
    //2.分享
    [ShareSDK showShareViewWithType:type container:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        //如果分享成功
        if (state == SSResponseStateSuccess) {
            NSLog(@"分享成功");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Code4App" message:@"分享成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        //如果分享失败
        if (state == SSResponseStateFail) {
            NSLog(@"分享失败,错误码:%ld,错误描述%@",(long)[error errorCode],[error errorDescription]);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Code4App" message:@"分享失败，请看日记错误描述" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        if (state == SSResponseStateCancel){
            NSLog(@"分享取消");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Code4App" message:@"进入了分享取消状态" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
    //3.没了，就是这么简单    
}
- (IBAction)ShowShareActionSheet:(id)sender {
    //1.定制分享的内容
    NSString* path = [[NSBundle mainBundle]pathForResource:@"ShareSDK" ofType:@"jpg"];
    id<ISSContent> publishContent = [ShareSDK content:@"Hello,Code4App.com!" defaultContent:nil image:[ShareSDK imageWithPath:path] title:@"This is title" url:@"http://mob.com" description:@"This is description" mediaType:SSPublishContentMediaTypeImage];
    //2.调用分享菜单分享
    [ShareSDK showShareActionSheet:nil shareList:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        //如果分享成功
        if (state == SSResponseStateSuccess) {
            NSLog(@"分享成功");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Code4App" message:@"分享成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        //如果分享失败
        if (state == SSResponseStateFail) {
            NSLog(@"分享失败,错误码:%ld,错误描述%@",(long)[error errorCode],[error errorDescription]);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Code4App" message:@"分享失败，请看日记错误描述" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        if (state == SSResponseStateCancel){
            NSLog(@"分享取消");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Code4App" message:@"进入了分享取消状态" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (IBAction)GetUserInfo:(UIButton *)sender {
    ShareType type = 0;
    switch (sender.tag) {
        case 1:
            type = ShareTypeSinaWeibo;
            break;
        case 2:
            type = ShareTypeTencentWeibo;
            break;
        case 3:
            type = ShareTypeRenren;
            break;
        case 4:
            type = ShareTypeQQSpace;
            break;
        case 5:
            type = ShareTypeWeixiSession;
            break;
        case 6:
            type = ShareTypeFacebook;
            break;
        case 7:
            type = ShareTypeTwitter;
        default:
            break;
    }
    [ShareSDK getUserInfoWithType:type authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (result) {
            NSLog(@"授权登陆成功，已获取用户信息");           
            NSString *uid = [userInfo uid];
            NSString *nickname = [userInfo nickname];
            NSString *profileImage = [userInfo profileImage];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Code4App" message:[NSString stringWithFormat:@"授权登陆成功,用户ID:%@,昵称:%@,头像:%@",uid,nickname,profileImage] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            NSLog(@"source:%@",[userInfo sourceData]);
            NSLog(@"uid:%@",[userInfo uid]);
            NSLog(@"获取授权凭证--access_toekn:%@",[[userInfo credential]token]);
            

        }else{
            NSLog(@"分享失败,错误码:%ld,错误描述%@",(long)[error errorCode],[error errorDescription]);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Code4App" message:@"授权失败，请看日记错误描述" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];

}
- (IBAction)CancelAuthWithAll:(UIButton *)sender {
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    [ShareSDK cancelAuthWithType:ShareTypeTencentWeibo];
    [ShareSDK cancelAuthWithType:ShareTypeRenren];
    [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];
    [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
    [ShareSDK cancelAuthWithType:ShareTypeFacebook];
    [ShareSDK cancelAuthWithType:ShareTypeTwitter];
}


- (IBAction)QQSpaceAllowWeb:(UISwitch *)sender {
    //开启QQ空间网页授权开关
    //注意导入头文件<QZoneConnection/ISSQZoneApp.h>
    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    if (sender.on) {
        [app setIsAllowWebAuthorize:YES];
    }else{
        [app setIsAllowWebAuthorize:NO];
    }
    
    
}
- (IBAction)FacebookSpaceAllowWeb:(UISwitch *)sender {
    //开启Facebook网页授权开关
    //注意导入头文件<FacebookConnection/ISSFacebookApp.h>
    id<ISSFacebookApp> facebookApp =(id<ISSFacebookApp>)[ShareSDK getClientWithType:ShareTypeFacebook];
    if (sender.on) {
        [facebookApp setIsAllowWebAuthorize:YES];
    }else{
        [facebookApp setIsAllowWebAuthorize:NO];
    }
    
}


@end
