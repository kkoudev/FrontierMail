//
//  FRMailMessage.m
//  FrontierMail
//
//  Created by Kou on 11/07/01.
//  Copyright 2011 The Frontier Project. All rights reserved.
//

#import "FRMailDefine.h"
#import "FRMailMessage.h"
#import "FRMailUtils.h"


/*
 * メールメッセージデータクラス実装部
 */
@implementation FRMailMessage


/*
 * アクセサメソッドを定義する
 */
@synthesize fromAddress     = mFromAddress;
@synthesize sentDate        = mSentDate;
@synthesize receivedDate    = mReceivedDate;
@synthesize subject         = mSubject;
@synthesize mimePart        = mMimePart;




/**
 * メンバ変数を初期化する。
 *
 * @return 作成したインスタンス
 */
- (id)init {
    
    // インスタンスを生成する
    self = [super init];
    
    // インスタンスが生成できた場合
    if (self) {
        
        // 各メンバ変数を初期化する
        mToAddresses    = [[NSMutableArray alloc] init];
        mCcAddresses    = [[NSMutableArray alloc] init];
        mBccAddresses   = [[NSMutableArray alloc] init];
        
    }

    // 作成したインスタンスを返す
    return self;
    
}


/**
 * メンバ変数を解放する。
 *
 */
- (void)dealloc {

    // 各変数を解放する
    [mFromAddress release];
    [mToAddresses release];
    [mCcAddresses release];
    [mBccAddresses release];
    [mSentDate release];
    [mReceivedDate release];
    [mSubject release];
    [mMimePart release];
    
    // スーパークラスの解放処理を実行する
    [super dealloc];
    
}


/**
 * メールメッセージを一時インスタンスとして作成する。
 *
 * @return 作成した一時インスタンス
 */
+ (FRMailMessage*)mailMessage {
    
    return [[[FRMailMessage alloc] init] autorelease];
    
}


/**
 * TOアドレスを追加する。
 *
 * @param address 追加するTOアドレス
 */
- (void)addToAddress:(FRMailAddress*)address {
    
    // アドレスが nil の場合はアサート
    NSAssert(address != nil, @"The argument is nil.");
    
    // アドレスをTOアドレス一覧へ追加する
    [mToAddresses addObject:address];
    
}


/**
 * CCアドレスを追加する。
 *
 * @param address 追加するCCアドレス
 */
- (void)addCcAddress:(FRMailAddress*)address {
    
    // アドレスが nil の場合はアサート
    NSAssert(address != nil, @"The argument is nil.");
    
    // アドレスをCCアドレス一覧へ追加する
    [mCcAddresses addObject:address];
    
}


/**
 * BCCアドレスを追加する。
 *
 * @param address 追加するBCCアドレス
 */
- (void)addBccAddress:(FRMailAddress*)address {
    
    // アドレスが nil の場合はアサート
    NSAssert(address != nil, @"The argument is nil.");
    
    // アドレスをBCCアドレス一覧へ追加する
    [mBccAddresses addObject:address];
    
}


/**
 * TOアドレス一覧へアクセスするための列挙子を取得する。
 *
 * @return TOアドレス一覧へアクセスするための列挙子
 */
- (NSEnumerator*)enumeratorToAddresses {
    
    return [mToAddresses objectEnumerator];
    
}


/**
 * CCアドレス一覧へアクセスするための列挙子を取得する。
 *
 * @return CCアドレス一覧へアクセスするための列挙子
 */
- (NSEnumerator*)enumeratorCcAddresses {
    
    return [mCcAddresses objectEnumerator];
    
}


/**
 * BCCアドレス一覧へアクセスするための列挙子を取得する。
 *
 * @return BCCアドレス一覧へアクセスするための列挙子
 */
- (NSEnumerator*)enumeratorBccAddresses {
    
    return [mBccAddresses objectEnumerator];
    
}


/**
 * ReplyToアドレスを追加する。
 *
 * @param address 追加するReplyToアドレス
 */
- (void)addReplyToAddress:(FRMailAddress*)address {
    
    // アドレスが nil の場合はアサート
    NSAssert(address != nil, @"The argument is nil.");
    
    // アドレスをReplyToアドレス一覧へ追加する
    [mReplyToAddresses addObject:address];
    
}


/**
 * MIME情報文字列を取得する。
 *
 * @return MIME情報文字列。MIMEパーツデータがない場合は nil
 */
- (NSString*)stringMime {

    // 設定されているMIMEパーツのMIME情報を作成する
    struct mailmime*                mimeParts = [FRMailUtils initMimeWithMimePart:mMimePart];
    
    
    // 各アドレス情報をIMFシングルフィールドへ設定する
    struct mailimf_mailbox_list*    fromAddresses    = [FRMailUtils initImfMailBoxListWithAddress:mFromAddress];
    struct mailimf_address_list*    toAddresses      = [FRMailUtils initImfMailAddressListWithAddresses:mToAddresses];
    struct mailimf_address_list*    ccAddresses      = [FRMailUtils initImfMailAddressListWithAddresses:mCcAddresses];
    struct mailimf_address_list*    bccAddresses     = [FRMailUtils initImfMailAddressListWithAddresses:mBccAddresses];
    struct mailimf_address_list*    replyToAddresses = [FRMailUtils initImfMailAddressListWithAddresses:mReplyToAddresses];
    const char*                     subject          = [FRMailUtils cStringEncodingMimeHeader:mSubject];
 
    // アドレス情報を格納したIMFフィールド情報を作成する
    struct mailimf_fields*  imfFields = mailimf_fields_new_with_data(
                                                                  fromAddresses, 
                                                                  NULL, 
                                                                  replyToAddresses, 
                                                                  toAddresses, 
                                                                  ccAddresses, 
                                                                  bccAddresses, 
                                                                  NULL, 
                                                                  NULL, 
                                                                  subject == NULL ? NULL : strdup(subject)
                                                                  );
 
    // メッセージMIME情報を作成する
    struct mailmime*    mimeMessage = mailmime_new_message_data(mimeParts);
    
    // IMFフィールド情報を設定する
    mailmime_set_imf_fields(mimeMessage, imfFields);
    
    // MIME情報文字列を作成する
    NSString*           retMimeString = [FRMailUtils stringMimeByMimeInfo:mimeMessage];
    
    // MIME情報を解放する
    mailmime_free(mimeMessage);

    
    // 作成したMIME情報文字列を返す
    return retMimeString;
    
}



@end
