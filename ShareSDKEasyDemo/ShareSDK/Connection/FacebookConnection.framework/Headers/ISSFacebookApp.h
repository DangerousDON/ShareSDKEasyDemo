///#begin zh-cn
//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
///#end
///#begin en
//
//  Created by ShareSDK.cn on 13-1-14.
//  website:http://www.ShareSDK.cn
//  Support E-mail:support@sharesdk.cn
//  WeChat ID:ShareSDK   （If publish a new version, we will be push the updates content of version to you. If you have any questions about the ShareSDK, you can get in touch through the WeChat with us, we will respond within 24 hours）
//  Business QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
///#end

#import <Foundation/Foundation.h>
#import <ShareSDKCoreService/ShareSDKCoreService.h>
#import "SSFacebookUser.h"
#import "SSFacebookErrorInfo.h"
#import "SSFacebookPost.h"
#import "ISSFacebookAddFriendDialog.h"
#import <ShareSDK/ShareSDKPlugin.h>

///#begin zh-cn
/**
 *	@brief	显示添加好友对话框
 */
///#end
///#begin en
/**
 *	@brief	Add Friend Dialog diaplay handler.
 */
///#end
typedef void(^SSFacebookShowAddFriendDialog) (UIViewController *viewController);

///#begin zh-cn
/**
 *	@brief	关闭添加好友对话框
 */
///#end
///#begin en
/**
 *	@brief	Add Friend Dialog close handler.
 */
///#end
typedef void(^SSFacebookCloseAddFriendDialog) (UIViewController *viewController);

///#begin zh-cn
/**
 *	@brief	Facebook应用协议
 */
///#end
///#begin en
/**
 *	@brief	Facebook App Protocol
 */
///#end
@protocol ISSFacebookApp <ISSPlatformApp>

///#begin zh-cn
/**
 *	@brief	获取应用Key
 *
 *	@return	应用Key
 */
///#end
///#begin en
/**
 *	@brief	Get App key.
 *
 *	@return	App key.
 */
///#end
- (NSString *)appKey;

///#begin zh-cn
/**
 *	@brief	获取应用密钥
 *
 *	@return	应用密钥
 */
///#end
///#begin en
/**
 *	@brief	Get app secret.
 *
 *	@return	App secret.
 */
///#end
- (NSString *)appSecret;

///#begin zh-cn
/**
 *	@brief	获取SSO回调地址
 *
 *	@return	SSO回调地址
 */
///#end
///#begin en
/**
 *	@brief	Get SSO Login callback URL.
 *
 *	@return	URL string.
 */
///#end
- (NSString *)ssoCallbackUrl;

///#begin zh-cn
/**
 *	@brief	设置是否打开网页授权，默认值为NO。
 *
 *	@return	YES为打开网页授权开关，NO为关闭
 */
///#end
///#begin en
/**
 *	@brief  whether to allow Facebook to authorize through Web（the default value is NO）
 *
 *	@return YES means allow to authorize through Web,NO means no allow
 */
///#end
- (void)setIsAllowWebAuthorize:(BOOL)isAllowWebAuthorize;

///#begin zh-cn
/**
 *	@brief	获取是否打开网页授权开关的值
 *
 *	@return	YES为打开网页授权开关，NO为关闭
 */
///#end
///#begin en
/**
 *	@brief	Get the value of isAllowWebAuthorize
 *
 *	@return YES means allow to authorize through Web,NO means no allow
 */
///#end
- (BOOL)isAllowWebAuthorize;

///#begin zh-cn
/**
 *	@brief	设置添加好友对话框处理器
 *
 *	@param 	showHandler 	显示处理器
 *  @param  closeHandler    关闭处理器
 */
///#end
///#begin en
/**
 *	@brief	Set add friend dialog Handler.
 *
 *	@param 	showHandler 	Display handler.
 *  @param  closeHandler    Close handler.
 */
///#end
- (void)setAddFriendDialogWithShowHandler:(SSFacebookShowAddFriendDialog)showHandler
                             closeHandler:(SSFacebookCloseAddFriendDialog)closeHandler;
							 
///#begin zh-cn
/**
 *	@brief	设置添加好友对话框委托
 *
 *	@param 	delegate 	委托
 */
///#end
///#begin en
/**
 *	@brief	Set add friend dialog delegate.
 *
 *	@param 	delegate 	Delegate object.
 */
///#end
- (void)setAddFriendDialogDelegate:(id<ISSViewDelegate>)delegate;

///#begin zh-cn
/**
 *	@brief	发布消息
 *
 *	@param 	message 	消息
 *  @param  result      返回回调
 */
///#end
///#begin en
/**
 *	@brief	Send message
 *
 *	@param 	message 	Message content.
 *  @param  result      Result handler.
 */
///#end
- (void)feedWithMessage:(NSString *)message
                 result:(SSShareResultEvent)result;

///#begin zh-cn				 
/**
 *	@brief	发布消息
 *
 *	@param 	message 	消息
 *	@param 	source 	附件图片
 *  @param  result  返回回调
 */
///#end
///#begin en
/**
 *	@brief	Send message.
 *
 *	@param 	message 	Message content.
 *	@param 	source 	Image attachment object.
 *  @param  result  Result handler.
 */
///#end
- (void)feedWithMessage:(NSString *)message
                 source:(id<ISSCAttachment>)source
                 result:(SSShareResultEvent)result;
				 
///#begin zh-cn
/**
 *	@brief	获取文章信息
 *
 *	@param 	postId 	文章ID
 */
///#end
///#begin en
/**
 *	@brief	Get post information.
 *
 *	@param 	postId 	Post id.
 */
///#end
- (void)getPostWithId:(NSString *)postId
               result:(void(^)(BOOL result, id post, CMErrorInfo *error))result;


@end
