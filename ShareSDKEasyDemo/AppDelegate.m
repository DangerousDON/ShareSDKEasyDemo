//
//  AppDelegate.m
//  ShareSDKEasyDemo
//
//  Created by DonelAccount on 14/12/27.
//  Copyright (c) 2014年 Code4App co.Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import <RennSDK/RennSDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.初始化ShareSDK应用,字符串"4a88b2fb067c"换成你申请的ShareSDK应用的Appkey，这个key来源于ShareSDK官网上申请获得
    [ShareSDK registerApp:@"3df7a36158b2"];
    
    //2. 初始化社交平台
    [self initializePlat];
    NSLog(@"sharesdkVer:%@",[ShareSDK version]);
    return YES;
}

- (void)initializePlat
{
    //初始化新浪，在新浪微博开放平台上申请应用
    [ShareSDK connectSinaWeiboWithAppKey:@"568898243" appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3" redirectUri:@"http://www.sharesdk.cn" weiboSDKCls:[WeiboSDK class]];
    //上面的方法会如果需要在授权的时候设定scope,或者需要跳到新浪的客户分享的话，需要导入WeiboSDK.
    
    //下面这方法，一般情况下均可使用。
    //[ShareSDK connectSinaWeiboWithAppKey:<#(NSString *)#> appSecret:<#(NSString *)#> redirectUri:<#(NSString *)#>]
/**---------------------------------------------------------**/
    
    //初始化腾讯微博，请在腾讯微博开放平台申请,腾讯微博客户端已经不支持，现在腾讯微博只可以使用网页授权
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650" appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c" redirectUri:@"http://www.sharesdk.cn"];
    
/**---------------------------------------------------------**/
    //初始化人人网，在人人网开放平台上申请
    [ShareSDK connectRenRenWithAppId:@"226427" appKey:@"fc5b8aed373c4c27a05b712acba0f8c3" appSecret:@"f29df781abdd4f49beca5a2194676ca4" renrenClientClass:[RennClient class]];
/**---------------------------------------------------------**/
    //初始化微信，微信开放平台上注册应用
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
                           appSecret:@"64020361b8ec4c99936c0e3999a9f249"
                           wechatCls:[WXApi class]];
    
    //如果在分享菜单中想取消微信收藏，可以初始化微信及微信朋友圈，取代上面整体初始化的方法
    //微信好友[ShareSDK connectWeChatSessionWithAppId:<#(NSString *)#> appSecret:<#(NSString *)#> wechatCls:<#(__unsafe_unretained Class)#>]
    //微信朋友圈[ShareSDK connectWeChatTimelineWithAppId:<#(NSString *)#> appSecret:<#(NSString *)#> wechatCls:<#(__unsafe_unretained Class)#>]
/**---------------------------------------------------------**/
    //初始化QQ,QQ空间，使用同样的key，请在腾讯开放平台上申请，注意导入头文件：
    /**
     #import <TencentOpenAPI/QQApiInterface.h>
     #import <TencentOpenAPI/TencentOAuth.h>
    **/
    
    //连接QQ应用
    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    //连接QQ空间应用
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
/**---------------------------------------------------------**/
    //初始化Facebook,在https://developers.facebook.com上注册应用
    [ShareSDK connectFacebookWithAppKey:@"107704292745179"
                              appSecret:@"38053202e1a5fe26c80c753071f0b573"];
/**---------------------------------------------------------**/
    //初始化Twitter,在https://dev.twitter.com上注册应用
    [ShareSDK connectTwitterWithConsumerKey:@"LRBM0H75rWrU9gNHvlEAA2aOy"
                             consumerSecret:@"gbeWsZvA9ELJSdoBzJ5oLKX0TU09UOwrzdGfo9Tg7DjyGuMe8G"
                                redirectUri:@"http://mob.com"];
    
/**---------------------------------------------------------**/
    //连接邮件
    //[ShareSDK connectMail];
    //连接短信
    //[ShareSDK connectSMS];
}

//添加两个回调方法,return的必须要ShareSDK的方法。如果要支持微信支付，请通过回调返回的url来判断
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "C4A.ShareSDKEasyDemo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ShareSDKEasyDemo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ShareSDKEasyDemo.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
