//
//  FrontierMailTests.m
//  FrontierMailTests
//
//  Created by Kou on 11/07/26.
//  Copyright 2011 The Frontier Project. All rights reserved.
//

#import "FrontierMailTests.h"


//------------------------
// テスト用定数
//------------------------

/**
 * FROM名
 */
static NSString*        MAIL_FROM_NAME      = @"FrontierMail";

/**
 * FROMアドレス
 */
static NSString*        MAIL_FROM_ADDRESS   = @"from address";

/**
 * 送信先名称
 */
static NSString*        MAIL_TO_NAME        = @"to name";

/**
 * 送信先アドレス
 */
static NSString*        MAIL_TO_ADDRESS     = @"to address";

/**
 * メール件名
 */
static NSString*        MAIL_SUBJECT        = @"subject";

/**
 * メール本文
 */
static NSString*        MAIL_MESSAGE        = @"message";

/**
 * SMTPホストアドレス
 */
static NSString*        SMTP_HOST           = @"smtp.gmail.com";

/**
 * SMTP接続ポート番号
 */
static NSInteger        SMTP_PORT_NO        = 587;

/**
 * SMTPアカウント名
 */
static NSString*        SMTP_ACCOUNT        = @"SMTP Address";

/**
 * SMTPパスワード
 */
static NSString*        SMTP_PASSWORD       = @"SMTP Password";



/**
 * テストクラス実装部
 */
@implementation FrontierMailTests

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}


/**
 * [SMTPテスト]
 * テキストメールを送信する。
 */
- (void)testSMTPSendPlainText {
    
    // メールメッセージを作成する
    FRMailMessage*  message = [FRMailMessage mailMessage];
    
    // 件名を設定する
    [message setSubject:MAIL_SUBJECT];
    
    // FROM名とアドレスを設定する
    [message setFromAddress:[FRMailAddress mailAddressWithName:MAIL_FROM_NAME address:MAIL_FROM_ADDRESS]];
    
    // 送信先名称とアドレスを設定する
    [message addToAddress:[FRMailAddress mailAddressWithName:MAIL_TO_NAME address:MAIL_TO_ADDRESS]];
    
    // MIMEパーツを作成する
    FRMimePart*     mimeTextPart = [FRMimePart mimePart];
    
    // 本文を設定する
    [mimeTextPart setText:MAIL_MESSAGE];
    
    // メールメッセージへMIME情報を設定する
    [message setMimePart:mimeTextPart];
    
    // SMTPセッションを作成する
    FRSMTPSession*  session = [FRSMTPSession
                               smtpWithConnectionType:FRSMTPConnectionTLS 
                               hostAddress:SMTP_HOST
                               portNo:SMTP_PORT_NO];
    
    // セッションへ接続する
    [session connect:SMTP_ACCOUNT password:SMTP_PASSWORD];
    
    // メールを送信する
    [session sendMailMessage:message];    

}


@end
