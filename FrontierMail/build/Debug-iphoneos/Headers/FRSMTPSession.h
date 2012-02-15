//
//  SMTPSession.h
//  FrontierMail
//
//  Created by Kou on 11/07/26.
//  Copyright 2011 The Frontier Project. All rights reserved.
//
#ifndef H_FR_SMTP_SESSION___
#define H_FR_SMTP_SESSION___

#import <Foundation/Foundation.h>
#include <libetpan/libetpan.h>
#import "FRMailType.h"
#import "FRMailMessage.h"



/**
 * SMTP接続種別を定義する列挙型。
 *
 * @author Koichi Nagaoka
 */
typedef enum _FRSMTPConnectionType {

    FRSMTPConnectionNormal,     ///< 通常接続
    FRSMTPConnectionSSL,        ///< SSL接続
    FRSMTPConnectionTLS,        ///< TLS接続
    
} FRSMTPConnectionType;




/**
 * SMTPセッションクラス。
 *
 * @author Koichi Nagaoka
 */
@interface FRSMTPSession : NSObject {
    
@private
    
    mailsmtp*               mSmtpSession;       ///< SMTPセッション情報
    NSString*               mHostAddress;       ///< 接続先ホストアドレス
    int                     mPortNo;            ///< ポート番号
    FRSMTPConnectionType    mConnectionType;    ///< 接続種別
    
}

@property (copy, nonatomic, readwrite) NSString* hostAddress;
@property (nonatomic, readwrite) int portNumber;
@property (nonatomic, readwrite) FRSMTPConnectionType connectionType;


/**
 * 認証情報以外の接続情報を指定して初期化を行う。
 *
 * @param connectionType    接続種別
 * @param hostAddress       接続先ホストアドレス
 * @param portNo            接続先ポート番号
 * @return 作成したインスタンス
 */
- (FRSMTPSession*)initWithConnectionInfo:(FRSMTPConnectionType)type hostAddress:(NSString*)hostAddress portNo:(int)portNo;


/**
 * 認証情報以外の接続情報を指定して一時インスタンスとして初期化を行う。
 *
 * @param connectionType    接続種別
 * @param hostAddress       接続先ホストアドレス
 * @param portNo            接続先ポート番号
 * @return 作成した一時インスタンス
 */
+ (FRSMTPSession*)smtpWithConnectionInfo:(FRSMTPConnectionType)connectionType hostAddress:(NSString*)hostAddress portNo:(int)portNo;


/**
 * 接続を開始する。
 *
 * 認証なしで接続を開始する。
 *
 * @return 接続に成功した場合は true
 */
- (BOOL)connect;


/**
 * 認証接続を開始する。
 *
 * PLAIN認証で接続を開始する。
 *
 * @param accountName   アカウント名
 * @param password      パスワード
 * @return 接続に成功した場合は true
 */
- (BOOL)connect:(NSString*)accountName password:(NSString*)password;


/**
 * 認証接続を開始する。
 *
 * 指定された認証種別で接続を開始する。
 *
 * @param authType      認証種別
 * @param accountName   アカウント名
 * @param password      パスワード
 * @return 接続に成功した場合は true
 */
- (BOOL)connect:(FRMailAuthType)authType accountName:(NSString*)accountName password:(NSString*)password;


/**
 * 指定されたメールメッセージを送信する。
 *
 * @param mailMessage   送信するメールメッセージ
 * @return 送信に成功した場合は true
 */ 
- (BOOL)sendMailMessage:(FRMailMessage*)mailMessage;





@end


#endif