//
//  FRMailUtils.h
//  FrontierMail
//
//  Created by Kou on 11/07/26.
//  Copyright 2011 The Frontier Project. All rights reserved.
//
#ifndef H_FR_MAIL_UTILS___
#define H_FR_MAIL_UTILS___

#include <libetpan/libetpan.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include "../Library/base64.h"
#import "FRMailType.h"
#import "FRMailAddress.h"
#import "FRMimePart.h"
#import "FRMailDefine.h"


/**
 * メールライブラリ内ユーティリティークラス。
 *
 * @author Kou
 */
@interface FRMailUtils : NSObject {
    
    // 処理なし
    
}


/**
 * 指定されたMIME種別をContent-Type文字列として取得する。
 *
 * @param mimeType MIME種別
 * @return 指定されたMIME種別に対応するContent-Type文字列
 */
+ (NSString*)initMimeContentType:(FRMimeType)mimeType NS_RETURNS_RETAINED;


/**
 * 指定された文字コードを文字列エンコーディング定数へ変換する。
 *
 * @param charset 文字コード
 * @return 文字列エンコーディング定数
 */
+ (NSStringEncoding)charsetToStringEncoding:(NSString*)charset;


/**
 * 指定されたMIME情報からコンテンツエンコーディングを取得する。
 *
 * @param mimePart  MIME情報
 * @return MIMEコンテンツエンコーディング定数
 */
+ (int)mimeToContentTransferEncoding:(FRMimePart*)mimePart;


/**
 * 指定された文字列をMIMEヘッダ対応文字列形式へ変換する。
 *
 * @param string    変換する文字列
 * @return 変換した文字列
 */
+ (const char*)cStringEncodingMimeHeader:(NSString*)string;


/**
 * 指定された文字列をMIMEヘッダ対応文字列形式へ変換する。
 *
 * @param string    変換する文字列
 * @return 変換した文字列
 */
+ (NSString*)stringEncodingMimeHeader:(NSString*)string;
    

/**
 * HELOメッセージをホストへ送信する。
 *
 * @param smtpSession SMTPセッション情報
 * @return 結果コード
 */
+ (int)helo:(struct mailsmtp*)smtpSession;


/**
 * EHLOメッセージをホストへ送信する。
 *
 * @param smtpSession SMTPセッション情報
 * @return 結果コード
 */
+ (int)ehlo:(struct mailsmtp*)smtpSession;


/**
 * 指定されたアドレス一覧を送信先アドレスとして設定する。
 *
 * @param smtpSession   SMTPセッション情報
 * @param addresses     送信先アドレスに設定するアドレス一覧 (FRMailAddress*)
 * @return 設定に成功した場合は true
 */
+ (BOOL)setRecipients:(struct mailsmtp*)smtpSession addresses:(NSEnumerator*)addresses;


/**
 * 指定されたメールストリームからIPポートデータを作成する。
 *
 * @param stream 元となるメールストリームデータ
 * @return 作成したIPポートデータの文字列
 */
+ (NSString*)stringFillIpPortByMailStream:(mailstream*)stream;


/**
 * 指定されたメール認証種別を文字列形式で取得する。
 *
 * @param type 文字列へ変換するメール認証種別
 * @return 文字列へ変換したメール認証種別
 */
+ (NSString*)stringAuthByAuthType:(FRMailAuthType)type;


/**
 * 指定されたMIMEパーツを元にMIMEシングルパート情報を作成する。
 *
 * @param mimePart 元となるMIMEパーツ
 * @return 作成したMIMEシングルパート情報
 */
+ (struct mailmime*)initMimeWithMimeSinglePart:(FRMimePart*)mimePart;


/**
 * 指定されたMIMEパーツ一覧を元にMIMEマルチパート情報を作成する。
 *
 * @param contentType   作成するマルチパート情報のContent-Type
 * @param mimeParts     元となるMIMEパーツ一覧 (FRMimePart* を要素に持つ配列)
 * @return 作成したMIMEマルチパート情報
 */
+ (struct mailmime*)initMimeWithMimeMultiPart:(NSString*)contentType mimeParts:(NSEnumerator*)mimeParts;


/**
 * 指定されたMIMEパーツのMIMEパーツ数から適切なMIME情報を作成する。
 *
 * @param mimePart 元となるMIMEパーツ
 * @return 作成したMIME情報
 */
+ (struct mailmime*)initMimeWithMimePart:(FRMimePart*)mimePart;


/**
 * 指定されたメールアドレスをIMFメールボックス一覧へ変換する。
 *
 * @param address メールアドレス
 * @return IMFメールボックス一覧
 */
+ (struct mailimf_mailbox_list*)initImfMailBoxListWithAddress:(FRMailAddress*)address;


/**
 * 指定されたメールアドレス一覧をIMFメールボックス一覧へ変換する。
 *
 * @param addresses メールアドレス一覧 (FRMailAddress* を要素に持つ配列)
 * @return IMFメールボックス一覧
 */
+ (struct mailimf_mailbox_list*)initImfMailBoxListWithAddresses:(NSArray*)addresses;


/**
 * 指定されたメールアドレス一覧をIMFメールアドレス一覧へ変換する。
 *
 * @param addresses メールアドレス一覧 (FRMailAddress* を要素に持つ配列)
 * @return IMFメールアドレス一覧。メールアドレス一覧が空の場合は NULL
 */
+ (struct mailimf_address_list*)initImfMailAddressListWithAddresses:(NSArray*)addresses;
 

/**
 * 指定されたMIME情報を文字列情報へ変換する。
 *
 * @param mimeInfo 元となるMIME情報
 * @return MIME情報文字列
 */
+ (NSString*)stringMimeByMimeInfo:(struct mailmime*)mimeInfo;


/**
 * 指定されたMIMEパーツを元にMIME文字列情報を作成する。
 *
 * @param mimePart 元となるMIMEパーツ
 * @return 作成したMIME文字列情報
 */
+ (NSString*)stringMimeWithMimeSinglePart:(FRMimePart*)mimePart;


/**
 * 指定されたMIMEパーツ一覧を元にMIME文字列情報を作成する。
 *
 * @param contentType   作成するマルチパート情報のContent-Type
 * @param mimeParts     元となるMIMEパーツ一覧 (FRMimePart* を要素に持つ配列)
 * @return 作成したMIME文字列情報
 */
+ (NSString*)stringMimeWithMimeMultiPart:(NSString*)contentType mimeParts:(NSEnumerator*)mimeParts;


/**
 * 指定されたMIMEパーツ一覧のMIMEパーツ数から適切なMIME文字列情報を作成する。
 *
 * @param mimePart 元となるMIMEパーツ
 * @return 作成したMIME文字列情報
 */
+ (NSString*)stringMimeWithMimeParts:(FRMimePart*)mimePart;



@end


#endif
