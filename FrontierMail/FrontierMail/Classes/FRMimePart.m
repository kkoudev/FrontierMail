//
//  FRMimePart.m
//  FrontierMail
//
//  Created by Kou on 11/07/01.
//  Copyright 2011 The Frontier Project. All rights reserved.
//

#import "FRMailDefine.h"
#import "FRMimePart.h"
#import "FRMailUtils.h"


/*
 * MIMEパーツデータ実装部
 */
@implementation FRMimePart


/*
 * アクセサメソッドの定義を行う
 */
@synthesize content             = mContent;
@synthesize contentType         = mContentType;
@synthesize charset             = mCharset;
@synthesize contentId           = mContentId;
@synthesize description         = mDescription;
@synthesize fileName            = mFileName;
@synthesize dispositionType     = mDispositionType;
@synthesize transferEncoding    = mTransferEncoding;




/**
 * インスタンスを初期化する。
 *
 * @return 作成したインスタンス
 */
- (id)init {

    // インスタンスを生成する
    self = [super init];
    
    // インスタンス生成に成功した場合
    if (self) {

        // デフォルト値を設定する
        self.dispositionType    = FRMimeDispositionAttachment;
        self.transferEncoding   = FRMimeTransferEncodingAuto;
        
        // MIMEパーツ一覧を初期化する
        mMimeParts = [[NSMutableArray alloc] init];
        
    }

    // 作成したインスタンスを返す
    return self;
    
}


/** 
 * インスタンスを破棄する。
 *
 */
- (void)dealloc {
        
    // 各メンバ変数を解放する
    [mContent release];
    [mContentType release];
    [mCharset release];
    [mContentId release];
    [mDescription release];
    [mFileName release];
    [mMimeParts release];
    
    // スーパークラスの解放処理を実行する
    [super dealloc];
    
}


/**
 * MIMEパーツデータを一時インスタンスとして初期化する。
 *
 * @return 作成した一時インスタンス
 */
+ (FRMimePart*)mimePart {
    
    return [[[FRMimePart alloc] init] autorelease];
    
}


/**
 * 指定されたMIME種別に応じたContent-Typeを設定する。
 *
 * @param mimeType 設定するMIME種別
 */
- (void)setContentTypeWithMimeType:(FRMimeType)mimeType {
    
    // 現在のContent-Typeを解放する
    [mContentType release];

    // 指定種別に応じたConten-Type文字列を設定する
    mContentType = [FRMailUtils initMimeContentType:mimeType];
    
}


/**
 * 指定されたContent-Typeを文字列設定する。
 *
 * @param contentType 設定するContent-Type文字列
 */
- (void)setContentTypeWithString:(NSString*)contentType {

    // 異なる値の場合
    if (mContentType != contentType) {
    
        // 現在のContent-Typeを解放する
        [mContentType release];
        
        // 指定された文字列をコピーして設定する
        mContentType = [contentType copy];
        
    }
    
}


/**
 * MIMEパーツを追加する。
 *
 * @param mimePart 追加するMIMEパーツ
 */
- (void)addMimePart:(FRMimePart*)mimePart {
    
    // MIMEパーツが nil の場合はアサート
    NSAssert(mimePart != nil, @"The argument is nil.");
    
    // MIMEパーツをMIMEパーツ一覧へ追加する
    [mMimeParts addObject:mimePart];
    
}


/**
 * MIMEパーツ一覧へアクセスするための列挙子を取得する。
 *
 * @return MIMEパーツ一覧へアクセスするための列挙子
 */
- (NSEnumerator*)enumeratorMimeParts {
    
    return [mMimeParts objectEnumerator];
    
}


/**
 * MIMEパーツ数を取得する。
 *
 * @return MIMEパーツ数
 */
- (NSUInteger)mimePartsCount {
    
    return [mMimeParts count];
    
}


/**
 * 指定されたテキストをプレーンテキストとして設定する。
 *
 * @param text      設定するテキストデータ
 */
- (void)setText:(NSString*)text {
    
    [self setText:text charset:@CHARSET_DEFAULT];
    
}


/**
 * 指定されたテキストをプレーンテキストとして設定する。
 *
 * @param text      設定するテキストデータ
 * @param charset   テキストの文字コード
 */
- (void)setText:(NSString*)text charset:(NSString*)charset {
    
    // 文字コードとContent-Typeを設定する
    [self setCharset:charset];
    [self setContentTypeWithMimeType:FRMimeTypeTextPlain];
    
    // テキストをバイトデータに変換する
    const char*     stringBytes = [text cStringUsingEncoding:[FRMailUtils charsetToStringEncoding:mCharset]];

    // テキストのバイトデータを設定する
    [self setContent:[[NSData alloc] initWithBytes:stringBytes length:strlen(stringBytes)]];
    
}


/**
 * 指定されたテキストをHTMLテキストとして設定する。
 *
 * @param text      設定するテキストデータ
 */
- (void)setHtmlText:(NSString*)text {
    
    [self setHtmlText:text charset:@CHARSET_DEFAULT];
    
}


/**
 * 指定されたテキストをHTMLテキストとして設定する。
 *
 * @param text          設定するテキストデータ
 * @param charset       テキストの文字コード
 */
- (void)setHtmlText:(NSString*)text charset:(NSString*)charset {
    
    // 文字コードとContent-Typeを設定する
    [self setCharset:charset];
    [self setContentTypeWithMimeType:FRMimeTypeHtml];
    
    // テキストをバイトデータに変換する
    const char*     stringBytes = [text cStringUsingEncoding:[FRMailUtils charsetToStringEncoding:mCharset]];
    
    // テキストのバイトデータを設定する
    [self setContent:[[NSData alloc] initWithBytes:stringBytes length:strlen(stringBytes)]];
    
}


@end
