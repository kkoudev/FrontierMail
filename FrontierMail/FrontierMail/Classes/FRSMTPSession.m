//
//  SMTPSession.m
//  FrontierMail
//
//  Created by Kou on 11/07/26.
//  Copyright 2011 The Frontier Project. All rights reserved.
//

#import "FRMailDefine.h"
#import "FRSMTPSession.h"
#import "FRMailUtils.h"



/*
 * SMTPSessionクラスの実装部
 */
@implementation FRSMTPSession


/*
 * アクセサメソッドの定義を行う
 */
@synthesize hostAddress     = mHostAddress;
@synthesize portNo          = mPortNo;
@synthesize connectionType  = mConnectionType;




/**
 * インスタンスの初期化を行う。
 *
 */
- (id)init {
    
    // インスタンスを生成する
    self = [super init];

    // インスタンスが生成できた場合
    if (self) {

        // SMTPセッション情報を作成する
        mSmtpSession = mailsmtp_new(0, NULL);
        
    }

    // 生成したインスタンスを返す
    return self;
    
}


/**
 * メンバ変数の解放処理を行う。
 *
 */
- (void)dealloc {

    // SMTPセッション情報を解放する
    mailsmtp_free(mSmtpSession);
    
    // 各パラメータを解放する
    [mHostAddress release];
    
    // スーパークラスの解放処理を実行する
    [super dealloc];
    
}


/**
 * 指定アドレスに対して接続処理を行う。
 *
 * @param connectionType    接続種別
 * @param hostAddress       接続先ホストアドレス
 * @param portNo            接続先ポート番号
 * @return 接続開始に成功した場合は true 
 */
- (FRSMTPSession*)initWithConnectionType:(FRSMTPConnectionType)connectionType hostAddress:(NSString*)hostAddress portNo:(int)portNo {
    
    // インスタンスを生成する
    self = [self init];
    
    // インスタンスが生成できた場合
    if (self) {
        
        // 各種情報を初期化する
        mConnectionType = connectionType;
        mHostAddress    = [hostAddress copy];
        mPortNo         = portNo;
        
    }
    
    // 生成したインスタンスを返す
    return self;
    
}


/**
 * 認証情報以外の接続情報を指定して一時インスタンスとして初期化を行う。
 *
 * @param connectionType    接続種別
 * @param hostAddress       接続先ホストアドレス
 * @param portNo            接続先ポート番号
 * @return 作成した一時インスタンス
 */
+ (FRSMTPSession*)smtpWithConnectionType:(FRSMTPConnectionType)connectionType hostAddress:(NSString*)hostAddress portNo:(int)portNo {
    
    return [[[FRSMTPSession alloc] initWithConnectionType:connectionType hostAddress:hostAddress portNo:portNo] autorelease];
    
}


/**
 * 接続を開始する。
 *
 * 認証なしで接続を開始する。
 *
 * @return 接続に成功した場合は true
 */
- (BOOL)connect {

    return [self connect:FRMailAuthPLAIN accountName:nil password:nil];
    
}


/**
 * 認証接続を開始する。
 *
 * PLAIN認証で接続を開始する。
 *
 * @param accountName   アカウント名
 * @param password      パスワード
 * @return 接続に成功した場合は true
 */
- (BOOL)connect:(NSString*)accountName password:(NSString*)password {
    
    return [self connect:FRMailAuthPLAIN accountName:accountName password:password];
    
}


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
- (BOOL)connect:(FRMailAuthType)authType accountName:(NSString*)accountName password:(NSString*)password {
    
    // 各メンバ変数値をローカルへキャッシュする
    NSString*               hostAddress     = [[mHostAddress copy] autorelease];  // 接続先ホストアドレス
    int                     portNo          = mPortNo;                            // ポート番号
    FRSMTPConnectionType    connectionType  = mConnectionType;                    // 接続種別
    BOOL                    isUseAuth;                                            // 認証を行うかどうか
    
    
    // 接続先サーバアドレスが定義されていない場合
    if (hostAddress == nil) {
        
        // 失敗
        return false;
        
    }
    
    
    // 認証を行うかどうかを取得する
    isUseAuth = (accountName != nil && password != nil);
    
    
    int     retCode;    // 接続結果
    
    // 接続種類別処理
    switch (connectionType) {
            
            // SSL接続
        case FRSMTPConnectionSSL:
            
            // SSLで指定されたホストへ接続する
            retCode = mailsmtp_ssl_connect(mSmtpSession, [hostAddress cStringUsingEncoding:NSUTF8StringEncoding], portNo);
            break;
            
            
            // TLS接続
        case FRSMTPConnectionTLS:
            
            // 指定されたホストへ接続する
            retCode = mailsmtp_socket_connect(mSmtpSession, [hostAddress cStringUsingEncoding:NSUTF8StringEncoding], portNo);
            
            // 接続失敗した場合
            if (retCode != MAILSMTP_NO_ERROR) {
                
                // エラーコードをログ出力
                NSLog(@"SMTP Connection Error [code = %d]", retCode);
                
                // 失敗
                return false;
                
            }
            
            
            // EHLOメッセージを送信する
            retCode = [FRMailUtils ehlo:mSmtpSession];
            
            // 開始に失敗した場合
            if (retCode != MAILSMTP_NO_ERROR) {
                
                // エラーコードをログ出力
                NSLog(@"SMTP First EHLO Error [code = %d]", retCode);
                
                // 失敗
                return false;
                
            }
            
            
            // TLSを開始する
            retCode = mailesmtp_starttls(mSmtpSession);
            
            // TLS開始に成功した場合
            if (retCode == MAILSMTP_NO_ERROR) {
                
                mailstream_low*     streamLow;      // 低レイヤストリーム
                int                 fileDescriptor; // 低レイヤファイルディスクリプタ
                mailstream_low*     streamLowTls;   // TLS用低レイヤストリーム
                
                // 低レイヤストリームを取得する
                streamLow = mailstream_get_low(mSmtpSession->stream);
                
                // 低レイヤファイルディスクリプタを取得する
                fileDescriptor = mailstream_low_get_fd(streamLow);
                
                // TLS用低レイヤストリームを取得する
                streamLowTls = mailstream_low_tls_open(fileDescriptor);
                
                // 古いストリームを解放し、TLS用ストリームを設定する
                mailstream_low_free(streamLow);
                mailstream_set_low(mSmtpSession->stream, streamLowTls);
                
            } else {
                
                // エラーコードをログ出力
                NSLog(@"SMTP STARTTLS Error [code = %d]", retCode);
                
                // 失敗
                return false;
                
            }
            
            
            // EHLOメッセージをもう一度送信する
            retCode = [FRMailUtils ehlo:mSmtpSession];
            
            // 開始に失敗した場合
            if (retCode != MAILSMTP_NO_ERROR) {
                
                // エラーコードをログ出力
                NSLog(@"SMTP Second EHLO Error [code = %d]", retCode);
                
                // 失敗
                return false;
                
            }
            break;
            
            
            // 通常接続
        default:
            
            // 指定されたホストへ接続する
            retCode = mailsmtp_socket_connect(mSmtpSession, [hostAddress cStringUsingEncoding:NSUTF8StringEncoding], portNo);
            break;
            
    }
    
    // SMTP認証を行う場合
    if (isUseAuth) {
        
        // IPポートデータを取得する
        NSString*   ipPort = [FRMailUtils stringFillIpPortByMailStream:mSmtpSession->stream];
        
        // 各文字列のアドレスを取得する
        const char* cHostAddress = [hostAddress cStringUsingEncoding:NSASCIIStringEncoding];
        const char* cAccountName = [accountName cStringUsingEncoding:NSASCIIStringEncoding];
        const char* cPassword    = [password cStringUsingEncoding:NSASCIIStringEncoding];
        const char* cIPPort      = [ipPort cStringUsingEncoding:NSASCIIStringEncoding];
        const char* cAuthName    = [[FRMailUtils stringAuthByAuthType:authType] cStringUsingEncoding:NSASCIIStringEncoding];
        
        // 認証を開始する
        retCode = mailesmtp_auth_sasl(
                                      mSmtpSession, 
                                      cAuthName, 
                                      cHostAddress,
                                      cIPPort,
                                      cIPPort,
                                      cAccountName,
                                      cAccountName,
                                      cPassword, 
                                      cHostAddress
                                      );
        
        // 認証に失敗した場合
        if (retCode != MAILSMTP_NO_ERROR) {
            
            // エラーコードをログ出力
            NSLog(@"SMTP Auth Error [code = %d]", retCode);
            
            // 失敗
            return false;
            
        }
        
    }
    
    
    // 成功
    return true;
    
}


/**
 * 指定されたメールメッセージを送信する。
 *
 * @param mailMessage   送信するメールメッセージ
 * @return 送信に成功した場合は true
 */ 
- (BOOL)sendMailMessage:(FRMailMessage*)mailMessage {
    
    // 指定されたメッセージが nil の場合
    if (mailMessage == nil) {
        
        // 送信失敗
        return false;
        
    }
    
    int     retCode;    // 返却結果
    
    // FROMアドレスを設定する
    retCode = mailsmtp_mail(mSmtpSession, [[[mailMessage fromAddress] address] cStringUsingEncoding:NSASCIIStringEncoding]);
    
    // FROMアドレスの設定に失敗した場合
    if (retCode != MAILSMTP_NO_ERROR) {
        
        // 送信失敗
        return false;
        
    }
    
    // TOアドレスを設定する
    if (![FRMailUtils setRecipients:mSmtpSession addresses:[mailMessage enumeratorToAddresses]]) {
        
        // 送信失敗
        return false;
        
    }
    
    // CCアドレスを設定する
    if (![FRMailUtils setRecipients:mSmtpSession addresses:[mailMessage enumeratorCcAddresses]]) {
        
        // 送信失敗
        return false;
        
    }
    
    // BCCアドレスを設定する
    if (![FRMailUtils setRecipients:mSmtpSession addresses:[mailMessage enumeratorBccAddresses]]) {
        
        // 送信失敗
        return false;
        
    }
    
    
    // DATAコマンドを通知する
    retCode = mailsmtp_data(mSmtpSession);
    
    // 通知に失敗した場合
    if (retCode != MAILSMTP_NO_ERROR) {
        
        // 設定失敗
        return false;
        
    }
    
    // 送信データを取り出す
    NSData*     sendData = [[mailMessage stringMime] dataUsingEncoding:NSASCIIStringEncoding];

    // データを送信する
    retCode = mailsmtp_data_message(mSmtpSession, [sendData bytes], [sendData length]);

   
    // 送信成功したかどうかを返す
    return retCode == MAILSMTP_NO_ERROR;
    
}



@end
