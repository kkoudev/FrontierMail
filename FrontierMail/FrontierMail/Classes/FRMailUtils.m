//
//  FRMailUtils.m
//  FrontierMail
//
//  Created by Kou on 11/07/26.
//  Copyright 2011 The Frontier Project. All rights reserved.
//

#import "FRMailUtils.h"





/**
 * Content-Type文字列参照用配列
 * (FRMimeContentType列挙型と対応する順番で配置すること)
 */
const char*        cStringMimeContentTypes[] = {
    
    // 文書
    CONTENT_TYPE_TEXT_PLAIN,                // プレーンテキスト (text/plain)
    CONTENT_TYPE_HTML,                      // HTML文書 (text/html)
    CONTENT_TYPE_TSV,                       // TSVファイル (text/tab-separated-values) 
    CONTENT_TYPE_CSS,                       // スタイルシート (text/css) 
    CONTENT_TYPE_HDML,                      // HDML文書 (text/x-hdml) 
    CONTENT_TYPE_MSWORD,                    // ワード文書 (application/msword) 
    CONTENT_TYPE_MSEXCEL,                   // エクセルシート (application/vnd.ms-excel) 
    CONTENT_TYPE_MSPOWERPOINT,              // パワーポイント (application/vnd.ms-powerpoint) 
    CONTENT_TYPE_PDF,                       // PDF文書 (application/pdf) 
    
    // 画像ファイル
    CONTENT_TYPE_JPEG,                      // JPEG画像 (image/jpeg)
    CONTENT_TYPE_GIF,                       // GIF画像 (image/gif)
    CONTENT_TYPE_PNG,                       // PNG画像 (image/png)
    CONTENT_TYPE_TIFF,                      // TIFF画像 (image/tiff)
    CONTENT_TYPE_BMP,                       // BMP画像 (image/bmp)
    
    // 音声ファイル
    CONTENT_TYPE_AU,                        // AUオーディオファイル (audio/basic) 
    CONTENT_TYPE_WAVE,                      // WAVEオーディオファイル (audio/x-wav) 
    CONTENT_TYPE_AIFF,                      // AIFFオーディオファイル (audio/x-aiff) 
    CONTENT_TYPE_MP4,                       // MP4オーディオファイル (audio/mp4) 
    CONTENT_TYPE_MIDI,                      // MIDIオーディオファイル (audio/midi)
    CONTENT_TYPE_AUDIO_MPEG,                // MPEGオーディオファイル (audio/mpeg) 
    CONTENT_TYPE_AUDIO_3GPP,                // 3GPP音声ファイル (audio/3gpp)
    CONTENT_TYPE_AUDIO_3GPP2,               // 3GPP2音声ファイル (audio/3gpp2)
    CONTENT_TYPE_AUDIO_OGG,                 // OGG音声ファイル (audio/ogg)

    // 動画ファイル
    CONTENT_TYPE_WMV,                       // WMVファイル (video/x-ms-wmv)
    CONTENT_TYPE_FLASH,                     // FLASHファイル (application/x-shockwave-flash)
    CONTENT_TYPE_VIDEO_MPEG,                // MPEG動画ファイル (video/mpeg)
    CONTENT_TYPE_VIDEO_3GPP,                // 3GPP動画ファイル (video/3gpp)
    CONTENT_TYPE_VIDEO_3GPP2,               // 3GPP2動画ファイル (video/3gpp2)
    CONTENT_TYPE_VIDEO_OGG,                 // OGG動画ファイル (video/ogg)
    
    // 圧縮ファイル形式
    CONTENT_TYPE_ZIP,                       // ZIPファイル (application/x-zip) 
    CONTENT_TYPE_GZIP,                      // GZIPファイル (application/x-gzip) 
    CONTENT_TYPE_TAR,                       // TARファイル (application/x-tar) 
    CONTENT_TYPE_LZH,                       // LZHファイル (application/x-lzh)
    CONTENT_TYPE_JAR,                       // JARファイル (application/java-archive)
    CONTENT_TYPE_CAB,                       // CABファイル (application/cab)
    CONTENT_TYPE_BZ2,                       // BZ2ファイル (application/x-bzip2)
    CONTENT_TYPE_RAR,                       // RARファイル (application/rar)
    CONTENT_TYPE_7Z,                        // 7Zファイル (application/x-7z-compressed)

    // マルチパート形式
    CONTENT_TYPE_MULTIPART_MIXED,           // 複数データ (multipart/mixed) 
    CONTENT_TYPE_MULTIPART_RELATED,         // メッセージリンク (multipart/related) 
    CONTENT_TYPE_MULTIPART_ALTERNATIVE,     // 同一内容他形式表現 (multipart/alternative) 
    CONTENT_TYPE_MULTIPART_DIGEST,          // RFC822メッセージ (multipart/digest) 
    CONTENT_TYPE_MULTIPART_ENCRYPTED,       // 暗号化メッセージ (multipart/encrypted) 
    CONTENT_TYPE_MULTIPART_PARALLEL,        // 複合表示 (multipart/parallel) 
    CONTENT_TYPE_MULTIPART_REPORT,          // エラーメール等のレポート型 (multipart/report) 
    CONTENT_TYPE_MULTIPART_SIGNED,          // S/MIME署名付メッセージ (multipart/signed) 
    
    // アプリケーション形式
    CONTENT_TYPE_OCTET_STREAM,              // バイナリ形式 (application/octet-stream)     
    
};


/**
 * 認証文字列参照用配列
 * (FRMailAuthTypeと対応する順番で配置すること)
 */
const char*         cStringAuthTypes[] = {
    
    MAIL_AUTH_PLAIN,        // PLAIN認証
    MAIL_AUTH_LOGIN,        // LOGIN認証
    MAIL_AUTH_APOP,         // APOP認証
    MAIL_AUTH_CRAMMD5,      // CRAM-MD5認証
    MAIL_AUTH_DIGESTMD5,    // DIGEST-MD5認証
    
};




/**
 * メールライブラリ内ユーティリティークラス実装部
 */
@implementation FRMailUtils


/**
 * 指定されたMIME種別をContent-Type文字列として取得する。
 *
 * @param mimeType MIME種別
 * @return 指定されたMIME種別に対応するContent-Type文字列
 */
+ (NSString*)initMimeContentType:(FRMimeType)mimeType {

    return [[NSString alloc] initWithCString:cStringMimeContentTypes[mimeType] encoding:NSASCIIStringEncoding];
    
}


/**
 * 指定された文字コードを文字列エンコーディング定数を変換する。
 *
 * @param charset 文字コード
 * @return 文字列エンコーディング定数
 */
+ (NSStringEncoding)charsetToStringEncoding:(NSString*)charset {
    
    // ISO-2022-JPの場合
    if ([charset caseInsensitiveCompare:@CHARSET_ISO_2022_JP] == NSOrderedSame) {
        
        // 対応する文字コード定数を返す
        return NSISO2022JPStringEncoding;
        
    // Shift_JISの場合
    } else if ([charset caseInsensitiveCompare:@CHARSET_SHIFT_JIS] == NSOrderedSame) {
        
        // 対応する文字コード定数を返す
        return NSShiftJISStringEncoding;       
        
    // EUC-JPの場合
    } else if ([charset caseInsensitiveCompare:@CHARSET_EUC_JP] == NSOrderedSame) {
        
        // 対応する文字コード定数を返す
        return NSJapaneseEUCStringEncoding;       
        
    // UTF-8の場合
    } else if ([charset caseInsensitiveCompare:@CHARSET_UTF_8] == NSOrderedSame) {
        
        // 対応する文字コード定数を返す
        return NSUTF8StringEncoding;
        
    // UTF-16の場合
    } else if ([charset caseInsensitiveCompare:@CHARSET_UTF_16] == NSOrderedSame) {
        
        // 対応する文字コード定数を返す
        return NSUTF16StringEncoding;
        
    // UTF-16LEの場合
    } else if ([charset caseInsensitiveCompare:@CHARSET_UTF_16LE] == NSOrderedSame) {

        // 対応する文字コード定数を返す
        return NSUTF16LittleEndianStringEncoding;
        
    // UTF-16BEの場合
    } else if ([charset caseInsensitiveCompare:@CHARSET_UTF_16BE] == NSOrderedSame) {
        
        // 対応する文字コード定数を返す
        return NSUTF16BigEndianStringEncoding;
        
    // その他
    } else {
        
        // ASCII文字コード定数を返す
        return NSASCIIStringEncoding;
        
    }
    
}


/**
 * 指定されたMIME情報からコンテンツエンコーディングを取得する。
 *
 * @param mimePart  MIME情報
 * @return MIMEコンテンツエンコーディング定数
 */
+ (int)mimeToContentTransferEncoding:(FRMimePart*)mimePart {
    
    FRMimeTransferEncoding  encoding = [mimePart transferEncoding];     // コンテンツエンコーディング種別を取得する

    // 自動エンコーディングの場合
    if (encoding == FRMimeTransferEncodingAuto) {
        
        NSString*   charset = [mimePart charset];   // 文字コードを取得する

        // nilの場合
        if (charset == nil) {
            
            // Base64エンコーディングを返す
            return MAILMIME_MECHANISM_BASE64;
            
        }
        
        // ISO-2022-JPの場合
        // またはUS-ASCIIの場合
        // またはEUC-JPの場合
        if (([charset caseInsensitiveCompare:@CHARSET_ISO_2022_JP] == NSOrderedSame)
            || ([charset caseInsensitiveCompare:@CHARSET_US_ASCII] == NSOrderedSame)
            || ([charset caseInsensitiveCompare:@CHARSET_EUC_JP] == NSOrderedSame)
            ) {
            
            // 7bitエンコーディングを返す
            return MAILMIME_MECHANISM_7BIT;
            
            // その他
        } else {
            
            // Base64エンコーディングを返す
            return MAILMIME_MECHANISM_BASE64;
            
        }    
        
    } else {

        // 設定されているエンコーディングを返す
        return encoding;
        
    }
    
}


/**
 * 指定された文字列をMIMEヘッダ対応文字列形式へ変換する。
 *
 * @param string    変換する文字列
 * @return 変換した文字列
 */
+ (const char*)cStringEncodingMimeHeader:(NSString*)string {
    
    // ASCII変換が可能な場合
    if ([string canBeConvertedToEncoding:NSASCIIStringEncoding]) {
        
        // そのままASCII変換して返す
        return [string cStringUsingEncoding:NSASCIIStringEncoding];
        
    } else {
        
        // ISO-2022-JP文字列として扱い、Base64文字列へエンコードする
        const char* strSource = [string cStringUsingEncoding:NSISO2022JPStringEncoding];
        char*       strBase64 = encode_base64(strSource, strlen(strSource));
        
        // 文字列をMIMEヘッダ非ASCII文字列表現形式へ変換する
        NSString*   retString = [NSString stringWithFormat:@FORMAT_HEADER_TEXT, 
                                            [NSString stringWithCString:strBase64
                                                               encoding:NSASCIIStringEncoding]];
        
        // 作業用エンコード文字列を解放する
        free(strBase64);
        
        // ASCII文字列として返す
        return [retString cStringUsingEncoding:NSASCIIStringEncoding];
        
    }
    
}


/**
 * 指定された文字列をMIMEヘッダ対応文字列形式へ変換する。
 *
 * @param string    変換する文字列
 * @return 変換した文字列
 */
+ (NSString*)stringEncodingMimeHeader:(NSString*)string {
    
    const char*     encodedHeader = [self cStringEncodingMimeHeader:string];
    
    // 変換に失敗した場合
    if (encodedHeader == NULL) {
        
        // nilを返す
        return nil;
        
    }

    // NSStringへ変換して返す
    return [NSString stringWithCString:encodedHeader encoding:NSASCIIStringEncoding];
    
}


/**
 * HELOメッセージをホストへ送信する。
 *
 * @param smtpSession SMTPセッション情報
 * @return 結果コード
 */
+ (int)helo:(struct mailsmtp*)smtpSession {
    
    // SMTPセッション情報が定義されていなければアサート
    NSAssert(smtpSession != NULL, @"SMTP Session is null");
    
    // サーバとの接続が確立されていない場合
    if (smtpSession->stream == NULL) {
        
        // ストリームエラーコードを返す
        return MAILSMTP_ERROR_STREAM;
        
    }
    
    // HELOメッセージを通知する
    return mailsmtp_helo(smtpSession);
    
}


/**
 * EHLOメッセージをホストへ送信する。
 *
 * @param smtpSession SMTPセッション情報
 * @return 結果コード
 */
+ (int)ehlo:(struct mailsmtp*)smtpSession {
    
    // SMTPセッション情報が定義されていなければアサート
    NSAssert(smtpSession != NULL, @"SMTP Session is null");
    
    // サーバとの接続が確立されていない場合
    if (smtpSession->stream == NULL) {
        
        // ストリームエラーコードを返す
        return MAILSMTP_ERROR_STREAM;
        
    }
    
    // EHLOメッセージをホストへ送信する
    return mailesmtp_ehlo(smtpSession);
    
}


/**
 * 指定されたアドレス一覧を送信先アドレスとして設定する。
 *
 * @param smtpSession   SMTPセッション情報
 * @param addresses     送信先アドレスに設定するアドレス一覧 (FRMailAddress*)
 * @return 設定に成功した場合は true
 */
+ (BOOL)setRecipients:(struct mailsmtp*)smtpSession addresses:(NSEnumerator*)addresses {
    
    // SMTPセッション情報が定義されていなければアサート
    NSAssert(smtpSession != NULL, @"SMTP Session is null");
    
    // メソッド実行用ポインタを取得する
    SEL     selector = @selector(cStringUsingEncoding:);
    IMP     imp      = [NSString instanceMethodForSelector:selector];
    
    // アドレス一覧分繰り返す
    for (FRMailAddress* address in addresses) {
        
        // 送信先アドレスを設定する
        int retCode = mailsmtp_rcpt(smtpSession, 
                                    (const char*)imp([address address], 
                                                     selector, 
                                                     NSASCIIStringEncoding)
                                    );
        
        // 設定に失敗した場合
        if (retCode != MAILSMTP_NO_ERROR) {
            
            // 設定失敗
            return false;
            
        }
        
    }
    
    
    // 設定成功
    return true;
    
}


/**
 * 指定されたメールストリームからIPポートデータを作成する。
 *
 * @param stream 元となるメールストリームデータ
 * @return 作成したIPポートデータの文字列
 */
+ (NSString*)stringFillIpPortByMailStream:(mailstream*)stream {
    
    // 元となるメールストリームデータが null の場合はアサーション
    NSAssert(stream != NULL, @"The argument is NULL.");
    
    
    mailstream_low*     streamLow       = mailstream_get_low(stream);       // 低レイヤストリームを取得する
    int                 fileDescriptor  = mailstream_low_get_fd(streamLow); // 低レイヤファイルディスクリプタを取得する
    struct sockaddr_in  sockAddress;                                        // 接続先のアドレス
    socklen_t           sockLength;                                         // 接続先アドレス長
    int                 retCode;                                            // 結果コード
    
    
    // 接続先バイナリアドレスを取得する
    retCode = getpeername(fileDescriptor, (struct sockaddr*)&sockAddress, &sockLength);
    
    // 取得に失敗した場合
    if (retCode < 0) {
        
        // 失敗
        return false;
        
    }
    

    char    fillIpPort[IP_ADDRESS_LENGTH]   = {0};    // IPポートデータ 
    char    strAddress[IP_ADDRESS_LENGTH]   = {0};    // 変換後のアドレス文字列

    // 取得したバイナリアドレスを文字列形式へ変換する
    inet_ntop(AF_INET, &sockAddress.sin_addr, strAddress, sizeof(strAddress));
    
    // 指定されたバッファへアドレスとポート番号を設定する
    sprintf(fillIpPort, FORMAT_IP_PORT, strAddress, ntohs(sockAddress.sin_port));
    
    
    // NSStringへ変換して結果を返す
    return [NSString stringWithCString:fillIpPort encoding:NSASCIIStringEncoding];
    
}


/**
 * 指定されたメール認証種別を文字列形式で取得する。
 *
 * @param type 文字列へ変換するメール認証種別
 * @return 文字列へ変換したメール認証種別
 */
+ (NSString*)stringAuthByAuthType:(FRMailAuthType)type {
    
    // 変換した文字列を返す
    return [NSString stringWithCString:cStringAuthTypes[type] encoding:NSASCIIStringEncoding];
    
}


/**
 * 指定されたMIMEパーツを元にMIMEシングルパート情報を作成する。
 *
 * @param mimePart 元となるMIMEパーツ
 * @return 作成したMIMEシングルパート情報
 */
+ (struct mailmime*)initMimeWithMimeSinglePart:(FRMimePart*)mimePart {
    
    struct mailmime*            mimeInfo;               // MIME情報
    struct mailmime_field*      mimeField;              // MIMEのフィールド情報
    struct mailmime_fields*     mimeFields;             // MIMEのフィールド情報一覧
    struct mailmime_content*    mimeContent;            // MIMEのコンテンツ情報
    NSString*                   mimeCharset;            // MIMEの文字コード
    NSString*                   mimeFileName;           // MIMEのファイル名
    NSString*                   mimeContentId;          // MIMEのコンテンツID
    NSString*                   mimeDescription;        // MIMEの説明
    const char*                 mimeContentType;        // MIMEのContent-Type
    FRMimeTransferEncoding      mimeTransferEncoding;   // MIMEのエンコーディング種別
    
    
    // 元となるMIMEパーツが nil の場合はアサーション
    NSAssert(mimePart != nil, @"The argument is nil.");

    
    // MIMEの各種パラメータを取得する
    mimeContentType = ([mimePart contentType] == nil
                        ? CONTENT_TYPE_DEFAULT_MIME_SINGLE_PART
                        : [[mimePart contentType] cStringUsingEncoding:NSASCIIStringEncoding]); // Content-Type
    mimeCharset     = [mimePart charset];                                                       // 文字コード
    mimeContentId   = [mimePart contentId];                                                     // コンテンツID
    mimeDescription = [mimePart description];                                                   // 説明
    mimeFileName    = [mimePart fileName];                                                      // ファイル名
    
    
    // MIMEエンコーディング情報を文字コード情報を元に作成する
    mimeTransferEncoding = [self mimeToContentTransferEncoding:mimePart];
    
    // Content-Typeを指定してコンテンツ情報を作成する
    mimeContent = mailmime_content_new_with_str(mimeContentType);

    
    // エンコーディング指定なしの場合
    if (mimeTransferEncoding == FRMimeTransferEncodingNone) {
        
        // エンコーディングを指定してフィールド情報を作成する
        mimeFields = mailmime_fields_new_empty();
        
    } else {
    
        // エンコーディングを指定してフィールド情報を作成する
        mimeFields = mailmime_fields_new_encoding(mimeTransferEncoding);
        
    }
    
    // 文字コードが指定されている場合
    if (mimeCharset != nil) {
        
        struct mailmime_parameter*  mimeParameter;  // MIMEのパラメータ情報
        const char*                 charset;        // 設定する文字コード
        
        // 文字コードを取得する
        charset = [[mimePart charset] cStringUsingEncoding:NSASCIIStringEncoding];
        
        // 文字コード指定のパラメータを作成する
        mimeParameter = mailmime_parameter_new(strdup(PARAM_NAME_CONTENT_TYPE_CHARSET), 
                                               strdup(charset == NULL ? CHARSET_DEFAULT : charset));
        
        // MIMEパラメータリストへ追加する
        clist_append(mimeContent->ct_parameters, mimeParameter);
        
    }
    
    // コンテンツIDが指定されている場合
    if (mimeContentId != nil) {
        
        // コンテンツIDフィールドを作成する
        mimeField = mailmime_field_new(
                                       MAILMIME_FIELD_ID, 
                                       NULL, 
                                       NULL, 
                                       strdup([mimeContentId cStringUsingEncoding:NSASCIIStringEncoding]), 
                                       NULL, 
                                       0, 
                                       NULL, 
                                       NULL
                                       );
        
        // フィールドの作成に成功した場合
        if (mimeField != NULL) {
            
            // MIMEフィールド一覧へ追加する
            mailmime_fields_add(mimeFields, mimeField);
            
        }
        
    }
    
    // 説明が指定されている場合
    if (mimeDescription != nil) {
        
        // 説明フィールドを作成する
        mimeField = mailmime_field_new(
                                       MAILMIME_FIELD_DESCRIPTION, 
                                       NULL, 
                                       NULL, 
                                       NULL, 
                                       strdup([self cStringEncodingMimeHeader:mimeDescription]), 
                                       0, 
                                       NULL, 
                                       NULL
                                       );
        
        // フィールドの作成に成功した場合
        if (mimeField != NULL) {
            
            // MIMEフィールド一覧へ追加する
            mailmime_fields_add(mimeFields, mimeField);
            
        }
        
    }
    
    // ファイル名が指定されている場合
    if (mimeFileName != nil) {

        struct mailmime_disposition_type*   mimeDispositionType;    // disposition-type項目データ
        struct mailmime_disposition*        mimeDisposition;        // disposition項目データ
        struct mailmime_disposition_parm*   mimeDispositionParm;    // disposition-parm項目データ
        clist*                              params = clist_new();   // コンテンツの処理方法パラメータ一覧
        FRMimeDispositionType               dispositionType;        // Content-Disposition種別

        
        // Content-Disposition種別を取得する
        dispositionType = [mimePart dispositionType];
        
        // disposition-type項目を作成する
        mimeDispositionType = mailmime_disposition_type_new(dispositionType, NULL);
        
        // disposition-parm項目にファイル名を設定して初期化する
        mimeDispositionParm = mailmime_disposition_parm_new(
                                                         MAILMIME_DISPOSITION_PARM_FILENAME, 
                                                         strdup([self cStringEncodingMimeHeader:mimeFileName]), 
                                                         NULL, 
                                                         NULL, 
                                                         NULL, 
                                                         -1, 
                                                         NULL
                                                         );
        
        // パラメータ一覧へ追加する
        clist_append(params, mimeDispositionParm);
        
        // disposition-typeと作成したパラメータを指定して、disposition項目情報を作成する
        mimeDisposition = mailmime_disposition_new(mimeDispositionType, params);
        
        // Content-Dispositionフィールドを作成する
        mimeField = mailmime_field_new(MAILMIME_FIELD_DISPOSITION, NULL, NULL, NULL, NULL, 0, mimeDisposition, NULL);
        
        // フィールドの作成に成功した場合
        if (mimeField != NULL) {
        
            // MIMEフィールド一覧へ追加する
            mailmime_fields_add(mimeFields, mimeField);
            
        } else {
            
            // 作成した情報を解放する
            mailmime_disposition_free(mimeDisposition);
            
        }
        
        // 名前パラメータを作成する
        struct mailmime_parameter*  paramName = mailmime_parameter_new(
                                                                       strdup(PARAM_NAME_CONTENT_TYPE_NAME), 
                                                                       strdup([FRMailUtils cStringEncodingMimeHeader:mimeFileName])
                                                                       );
        
        // 名前パラメータの作成に成功した場合
        if (paramName != NULL) {
            
            // 名前パラメータを追加する
            clist_append(mimeContent->ct_parameters, paramName);
            
        }
        
    }
    

    // コンテンツ情報とフィールドを指定してMIME情報を作成する
    mimeInfo = mailmime_new_empty(mimeContent, mimeFields);

    // MIMEコンテンツデータを取得する
    NSData*     content = [mimePart content];
    
    // MIMEコンテンツデータをボディデータとして設定する
    mailmime_set_body_text(mimeInfo, (char*)[content bytes], [content length]);
    
    
    // 作成したMIME情報を返却する
    return mimeInfo;
    
}


/**
 * 指定されたMIMEパーツ一覧を元にMIMEマルチパート情報を作成する。
 *
 * @param contentType   作成するマルチパート情報のContent-Type
 * @param mimeParts     元となるMIMEパーツ一覧 (FRMimePart* を要素に持つ配列)
 * @return 作成したMIMEマルチパート情報
 */
+ (struct mailmime*)initMimeWithMimeMultiPart:(NSString*)contentType mimeParts:(NSEnumerator*)mimeParts {
    
    struct mailmime*    retMimeInfo;        // 返却するMIME情報

    
    // コンテンツタイプが設定されていない場合
    if (contentType == nil) {
        
        // マルチパートMIMEのデフォルトコンテンツタイプでMIME情報を新規作成する
        retMimeInfo = mailmime_multiple_new(CONTENT_TYPE_DEFAULT_MIME_MULTI_PART);
        
    } else {
        
        // 指定されたコンテンツタイプのMIME情報を新規作成する
        retMimeInfo = mailmime_multiple_new([contentType cStringUsingEncoding:NSASCIIStringEncoding]);
        
    }
 
    // 全MIMEパーツ分繰り返し
    for (FRMimePart* mimePart in mimeParts) {
        
        // MIME情報を追加する
        mailmime_add_part(retMimeInfo, [self initMimeWithMimePart:mimePart]);
        
    }
    
    
    // 作成したMIME情報を返却する
    return retMimeInfo;
    
}


/**
 * 指定されたMIMEパーツのMIMEパーツ数から適切なMIME情報を作成する。
 *
 * @param mimePart 元となるMIMEパーツ
 * @return 作成したMIME情報
 */
+ (struct mailmime*)initMimeWithMimePart:(FRMimePart*)mimePart {

    const int   mimePartsCount = [mimePart mimePartsCount];     // MIMEパーツ数
    
    // MIMEパーツがシングルパートの場合
    if (mimePartsCount == 0) {

        // MIMEシングルパート情報を作成して返す
        return [self initMimeWithMimeSinglePart:mimePart];
        
    // MIMEパーツがマルチパートの場合
    } else if (mimePartsCount > 0) {
        
        // MIMEマルチパート情報を作成して返す
        return [self initMimeWithMimeMultiPart:[mimePart contentType] mimeParts:[mimePart enumeratorMimeParts]];
        
    // その他
    } else {
        
        // MIME情報を作成できないため NULL を返す
        return NULL;
        
    }
    
}


/**
 * 指定されたメールアドレスをIMFメールボックス一覧へ変換する。
 *
 * @param address メールアドレス
 * @return IMFメールボックス一覧
 */
+ (struct mailimf_mailbox_list*)initImfMailBoxListWithAddress:(FRMailAddress*)address {
    
    NSArray*    addresses = [[[NSArray alloc] initWithObjects:address, nil] autorelease];
    
    // IMFメールボックス一覧を作成して返す
    return [self initImfMailBoxListWithAddresses:addresses];
    
}


/**
 * 指定されたメールアドレス一覧をIMFメールボックス一覧へ変換する。
 *
 * @param addresses メールアドレス一覧 (FRMailAddress* を要素に持つ配列)
 * @return IMFメールボックス一覧
 */
+ (struct mailimf_mailbox_list*)initImfMailBoxListWithAddresses:(NSArray*)addresses {
    
    struct mailimf_mailbox_list*    imfMailBoxList = mailimf_mailbox_list_new_empty();  // メールボックス一覧
    
    // メソッド実行用ポインタを取得する
    SEL     selectorName    = @selector(name);
    SEL     selectorAddress = @selector(address);
    IMP     impName         = [FRMailAddress instanceMethodForSelector:selectorName];
    IMP     impAddress      = [FRMailAddress instanceMethodForSelector:selectorAddress];
    
    // 全メールアドレス分繰り返す
    for (FRMailAddress* address in addresses) {
        
        // メールボックス一覧へアドレスを追加する
        mailimf_mailbox_list_add_mb(
                                    imfMailBoxList, 
                                    strdup([self cStringEncodingMimeHeader:(NSString*)impName(address, selectorName)]),
                                    strdup([self cStringEncodingMimeHeader:(NSString*)impAddress(address, selectorAddress)])
                                    );
        
    }
    
    // 作成したメールボックス一覧を返す
    return imfMailBoxList;
    
}


/**
 * 指定されたメールアドレス一覧をIMFメールアドレス一覧へ変換する。
 *
 * @param addresses メールアドレス一覧 (FRMailAddress* を要素に持つ配列)
 * @return IMFメールアドレス一覧。メールアドレス一覧が空の場合は NULL
 */
+ (struct mailimf_address_list*)initImfMailAddressListWithAddresses:(NSArray*)addresses {
    
    // メールアドレス一覧が空の場合
    if ([addresses count] == 0) {
        
        // NULLを返す
        return NULL;
        
    }
    
    
    struct mailimf_address_list*    imfMailAddressList = mailimf_address_list_new_empty();  // メールアドレス一覧
    
    // メソッド実行用ポインタを取得する
    SEL     selectorName    = @selector(name);
    SEL     selectorAddress = @selector(address);
    IMP     impName         = [FRMailAddress instanceMethodForSelector:selectorName];
    IMP     impAddress      = [FRMailAddress instanceMethodForSelector:selectorAddress];
    
    // 全メールアドレス分繰り返す
    for (FRMailAddress* address in addresses) {
        
        // メールアドレス一覧へアドレスを追加する
        mailimf_address_list_add_mb(
                                    imfMailAddressList, 
                                    strdup([self cStringEncodingMimeHeader:(NSString*)impName(address, selectorName)]),
                                    strdup([self cStringEncodingMimeHeader:(NSString*)impAddress(address, selectorAddress)])
                                    );
        
    }
    
    // 作成したメールアドレス一覧を返す
    return imfMailAddressList;
    
}


/**
 * 指定されたMIME情報を文字列情報へ変換する。
 *
 * @param mimeInfo 元となるMIME情報
 * @return MIME情報文字列
 */
+ (NSString*)stringMimeByMimeInfo:(struct mailmime*)mimeInfo {
    
    NSString*       retMimeString;      // 返却するMIME情報文字列
    MMAPString*     mapString;          // メモリマップ文字列
    int             writeCount = 0;     // 書き込みブロックカウント
    int             retResult;          // 処理結果
    
    
    // メモリマップ文字列を新規作成する
    mapString = mmap_string_new("");
    
    // MIME情報をメモリマップ文字列として書き込む
    mailmime_write_mem(mapString, &writeCount, mimeInfo);
    
    // 通常文字列への参照情報を取得する
    retResult = mmap_string_ref(mapString);
    
    // 取得に失敗した場合はアサーション
    NSAssert(retResult == 0, @"Error cannot refer a string of the MMAPString.");
    
    // 返却するMIME情報文字列を作成する
    retMimeString = [[[NSString alloc] initWithBytes:mapString->str
                                       length:mapString->len
                                       encoding:NSASCIIStringEncoding] autorelease];
    
    // メモリマップ文字列を破棄する
    mmap_string_free(mapString);
    
    
    // 作成したMIME情報文字列を返却する
    return retMimeString;
    
}


/**
 * 指定されたMIMEパーツを元にMIME文字列情報を作成する。
 *
 * @param mimePart 元となるMIMEパーツ
 * @return 作成したMIME文字列情報
 */
+ (NSString*)stringMimeWithMimeSinglePart:(FRMimePart*)mimePart {
    
    // MIME情報を作成する
    struct mailmime*    mimeInfo   = [self initMimeWithMimeSinglePart:mimePart];
    
    // MIME情報文字列を作成する
    NSString*           mimeString = [self stringMimeByMimeInfo:mimeInfo];
    
    // MIME情報を解放する
    mailmime_free(mimeInfo);
    
    
    // 作成したMIME情報文字列を返却する
    return mimeString;
    
}


/**
 * 指定されたMIMEパーツ一覧を元にMIME文字列情報を作成する。
 *
 * @param contentType   作成するマルチパート情報のContent-Type
 * @param mimeParts     元となるMIMEパーツ一覧 (FRMimePart* を要素に持つ配列)
 * @return 作成したMIME文字列情報
 */
+ (NSString*)stringMimeWithMimeMultiPart:(NSString*)contentType mimeParts:(NSEnumerator*)mimeParts {
    
    // MIME情報を作成する
    struct mailmime*    mimeInfo   = [self initMimeWithMimeMultiPart:contentType mimeParts:mimeParts];
    
    // MIME情報文字列を作成する
    NSString*           mimeString = [self stringMimeByMimeInfo:mimeInfo];
    
    // MIME情報を解放する
    mailmime_free(mimeInfo);
    
    
    // 作成したMIME情報文字列を返却する
    return mimeString;
    
}


/**
 * 指定されたMIMEパーツ一覧のMIMEパーツ数から適切なMIME文字列情報を作成する。
 *
 * @param mimePart 元となるMIMEパーツ
 * @return 作成したMIME文字列情報
 */
+ (NSString*)stringMimeWithMimeParts:(FRMimePart*)mimePart {
    
    // MIME情報を作成する
    struct mailmime*    mimeInfo   = [self initMimeWithMimePart:mimePart];
    
    // MIME情報文字列を作成する
    NSString*           mimeString = [self stringMimeByMimeInfo:mimeInfo];
    
    // MIME情報を解放する
    mailmime_free(mimeInfo);
    
    
    // 作成したMIME情報文字列を返却する
    return mimeString;
    
}


@end
