//
//  FRMimeMessage.h
//  FrontierMail
//
//  Created by Kou on 11/07/26.
//  Copyright 2011 The Frontier Project. All rights reserved.
//
#ifndef H_FR_MIME_MESSAGE___
#define H_FR_MIME_MESSAGE___

#import <Foundation/Foundation.h>
#include <libetpan/libetpan.h>
#import "FRMailAddress.h"
#import "FRMimePart.h"


/**
 * メールメッセージデータクラス。
 *
 * @author Kou
 */
@interface FRMailMessage : NSObject {
    
@private
    
    FRMailAddress*      mFromAddress;       ///< FROMアドレス
    NSMutableArray*     mToAddresses;       ///< TOアドレス一覧 (FRMailAddress*)
    NSMutableArray*     mCcAddresses;       ///< CCアドレス一覧 (FRMailAddress*)
    NSMutableArray*     mBccAddresses;      ///< BCCアドレス一覧 (FRMailAddress*)
    NSMutableArray*     mReplyToAddresses;  ///< ReplyToアドレス一覧 (FRMailAddress*)
    NSDate*             mSentDate;          ///< 送信日時
    NSDate*             mReceivedDate;      ///< 受信日時
    NSString*           mSubject;           ///< メールの件名
    FRMimePart*         mMimePart;          ///< メールのMIMEパーツデータ
    
}

/**
 * FROMアドレス
 */
@property (retain, nonatomic, readwrite)    FRMailAddress*  fromAddress;

/**
 * 送信日時
 */
@property (copy, nonatomic, readwrite)      NSDate*         sentDate;

/**
 * 受信日時
 */
@property (copy, nonatomic, readwrite)      NSDate*         receivedDate;

/**
 * メールの件名
 */
@property (copy, nonatomic, readwrite)      NSString*       subject;

/**
 * メールのMIMEパーツデータ
 */
@property (retain, nonatomic, readwrite)    FRMimePart*     mimePart;




/**
 * メールメッセージを一時インスタンスとして作成する。
 *
 * @return 作成した一時インスタンス
 */
+ (FRMailMessage*)mailMessage;


/**
 * TOアドレスを追加する。
 *
 * @param address 追加するTOアドレス
 */
- (void)addToAddress:(FRMailAddress*)address;


/**
 * CCアドレスを追加する。
 *
 * @param address 追加するCCアドレス
 */
- (void)addCcAddress:(FRMailAddress*)address;


/**
 * BCCアドレスを追加する。
 *
 * @param address 追加するBCCアドレス
 */
- (void)addBccAddress:(FRMailAddress*)address;


/**
 * TOアドレス一覧へアクセスするための列挙子を取得する。
 *
 * @return TOアドレス一覧へアクセスするための列挙子
 */
- (NSEnumerator*)enumeratorToAddresses;


/**
 * CCアドレス一覧へアクセスするための列挙子を取得する。
 *
 * @return CCアドレス一覧へアクセスするための列挙子
 */
- (NSEnumerator*)enumeratorCcAddresses;


/**
 * BCCアドレス一覧へアクセスするための列挙子を取得する。
 *
 * @return BCCアドレス一覧へアクセスするための列挙子
 */
- (NSEnumerator*)enumeratorBccAddresses;


/**
 * ReplyToアドレスを追加する。
 *
 * @param address 追加するReplyToアドレス
 */
- (void)addReplyToAddress:(FRMailAddress*)address;


/**
 * MIME情報文字列を取得する。
 *
 * @return MIME情報文字列
 */
- (NSString*)stringMime;


@end


#endif
