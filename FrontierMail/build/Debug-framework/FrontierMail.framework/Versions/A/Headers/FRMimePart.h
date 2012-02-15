//
//  FRMimePart.h
//  FrontierMail
//
//  Created by Kou on 11/07/26.
//  Copyright 2011 The Frontier Project. All rights reserved.
//
#ifndef H_FR_MIME_PART___
#define H_FR_MIME_PART___

#import <Foundation/Foundation.h>
#include <libetpan/libetpan.h>




/**
 * MIME Content-Type種別列挙型。
 *
 * @author Koichi Nagaoka
 */
typedef enum _FRMimeType {

    // 文書
    FRMimeTypeTextPlain = 0,            ///< プレーンテキスト (text/plain)
    FRMimeTypeHtml,                     ///< HTML文書 (text/html)
    FRMimeTypeTSV,                      ///< TSVファイル (text/tab-separated-values) 
    FRMimeTypeCSS,                      ///< スタイルシート (text/css) 
    FRMimeTypeHDML,                     ///< HDML文書 (text/x-hdml) 
    FRMimeTypeMSWord,                   ///< ワード文書 (application/msword) 
    FRMimeTypeMSExcel,                  ///< エクセルシート (application/vnd.ms-excel) 
    FRMimeTypeMSPowerPoint,             ///< パワーポイント (application/vnd.ms-powerpoint) 
    FRMimeTypePDF,                      ///< PDF文書 (application/pdf) 
    
    // 画像ファイル
    FRMimeTypeJPEG,                     ///< JPEG画像 (image/jpeg)
    FRMimeTypeGIF,                      ///< GIF画像 (image/gif)
    FRMimeTypePNG,                      ///< PNG画像 (image/png)
    FRMimeTypeTIFF,                     ///< TIFF画像 (image/tiff)
    FRMimeTypeBMP,                      ///< BMP画像 (image/bmp)
    
    // 音声ファイル
    FRMimeTypeAU,                       ///< AUオーディオファイル (audio/basic)
    FRMimeTypeWAVE,                     ///< WAVEオーディオファイル (audio/x-wav)
    FRMimeTypeAIFF,                     ///< AIFFオーディオファイル (audio/x-aiff)
    FRMimeTypeMP4,                      ///< MP4オーディオファイル (audio/mp4)
    FRMimeTypeMIDI,                     ///< MIDIオーディオファイル (audio/midi)
    FRMimeTypeAudioMPEG,                ///< MPEGオーディオファイル (audio/mpeg)
    FRMimeTypeAudio3GPP,                ///< 3GPP音声ファイル (audio/3gpp)
    FRMimeTypeAudio3GPP2,               ///< 3GPP2音声ファイル (audio/3gpp2)
    FRMimeTypeAudioOGG,                 ///< OGG音声ファイル (audio/ogg)
    
    // 動画ファイル
    FRMimeTypeWMV,                      ///< WMVファイル (video/x-ms-wmv)
    FRMimeTypeFlash,                    ///< FLASHファイル (application/x-shockwave-flash)
    FRMimeTypeVideoMPEG,                ///< MPEG動画ファイル (video/mpeg)
    FRMimeTypeVideo3GPP,                ///< 3GPP動画ファイル (video/3gpp)
    FRMimeTypeVideo3GPP2,               ///< 3GPP2動画ファイル (video/3gpp2)
    FRMimeTypeVideoOGG,                 ///< OGG動画ファイル (video/ogg)
     
    // 圧縮ファイル
    FRMimeTypeZIP,                      ///< ZIPファイル (application/x-zip)
    FRMimeTypeGZIP,                     ///< GZIPファイル (application/x-gzip)
    FRMimeTypeTAR,                      ///< TARファイル (application/x-tar)
    FRMimeTypeLZH,                      ///< LZHファイル (application/x-lzh)
    FRMimeTypeJAR,                      ///< JARファイル (application/java-archive)
    FRMimeTypeCAB,                      ///< CABファイル (application/cab)
    FRMimeTypeBZ2,                      ///< BZ2ファイル (application/x-bzip2)
    FRMimeTypeRAR,                      ///< RARファイル (application/rar)
    FRMimeType7Z,                       ///< 7Zファイル (application/x-7z-compressed)
    
    // マルチパート
    FRMimeTypeMultipartMixed,           ///< 複数データ (multipart/mixed)
    FRMimeTypeMultipartRelated,         ///< メッセージリンク (multipart/related)
    FRMimeTypeMultipartAlternative,     ///< 同一内容他形式表現 (multipart/alternative)
    FRMimeTypeMultipartDigest,          ///< RFC822メッセージ (multipart/digest)
    FRMimeTypeMultipartEncrypted,       ///< 暗号化メッセージ (multipart/encrypted)
    FRMimeTypeMultipartParallel,        ///< 複合表示 (multipart/parallel)
    FRMimeTypeMultipartReport,          ///< エラーメール等のレポート型 (multipart/report)
    FRMimeTypeMultipartSigned,          ///< S/MIME署名付メッセージ (multipart/signed)
    
    // 汎用
    FRMimeTypeOctetStream,              ///< バイナリ形式 (application/octet-stream)
    
} FRMimeType;


/**
 * Content-Transfer-Encoding項目種別列挙型。
 *
 * @author Koichi Nagaoka
 */
typedef enum _FRMimeTransferEncoding {
    
    FRMimeTransferEncodingNone              = MAILMIME_MECHANISM_ERROR - 1,         ///< エンコーディング指定なし
    FRMimeTransferEncodingAuto              = MAILMIME_MECHANISM_ERROR,             ///< 自動エンコーディング
    FRMimeTransferEncoding7Bit              = MAILMIME_MECHANISM_7BIT,              ///< 7bitエンコーディング
    FRMimeTransferEncoding8Bit              = MAILMIME_MECHANISM_8BIT,              ///< 8bitエンコーディング
    FRMimeTransferEncodingQuotedPrintable   = MAILMIME_MECHANISM_QUOTED_PRINTABLE,  ///< Quoted-printableエンコーディング
    FRMimeTransferEncodingBase64            = MAILMIME_MECHANISM_BASE64,            ///< Base64エンコーディング
    FRMimeTransferEncodingBinary            = MAILMIME_MECHANISM_BINARY,            ///< Binaryエンコーディング
    
} FRMimeTransferEncoding;


/**
 * Content-Disposition項目種別列挙型。
 *
 * @author Koichi Nagaoka
 */
typedef enum _FRMimeDispositionType {
    
    FRMimeDispositionInline      = MAILMIME_DISPOSITION_TYPE_INLINE,        ///< インライン表示
    FRMimeDispositionAttachment  = MAILMIME_DISPOSITION_TYPE_ATTACHMENT,    ///< ファイル添付
    
} FRMimeDispositionType;




/**
 * MIMEパーツデータ。
 *
 * @author Koichi Nagaoka
 */
@interface FRMimePart : NSObject {
    
@private
    
    NSData*                 mContent;           ///< コンテンツデータ
    NSString*               mContentType;       ///< コンテンツタイプ
    NSString*               mCharset;           ///< 利用する文字コード  
    NSString*               mContentId;         ///< コンテンツID
    NSString*               mDescription;       ///< 説明
    NSString*               mFileName;          ///< ファイル名
    FRMimeDispositionType   mDispositionType;   ///< Content-Disposition動作種別
    FRMimeTransferEncoding  mTransferEncoding;  ///< Content-Transfer-Encoding種別
    NSMutableArray*         mMimeParts;         ///< MIMEパートデータ一覧 (FRMimePart*)
    
}

@property (retain, nonatomic, readwrite)    NSData*                 content;
@property (copy, nonatomic, readwrite)      NSString*               contentType;
@property (copy, nonatomic, readwrite)      NSString*               charset;
@property (copy, nonatomic, readwrite)      NSString*               contentId;
@property (copy, nonatomic, readwrite)      NSString*               description;
@property (copy, nonatomic, readwrite)      NSString*               fileName;
@property (nonatomic, readwrite)            FRMimeDispositionType   dispositionType;
@property (nonatomic, readwrite)            FRMimeTransferEncoding  transferEncoding;




/**
 * MIMEパーツデータを一時インスタンスとして初期化する。
 *
 * @return 作成した一時インスタンス
 */
+ (FRMimePart*)mimePart;


/**
 * 指定されたMIME種別に応じたContent-Typeを設定する。
 *
 * @param mimeType 設定するMIME種別
 */
- (void)setContentTypeByMimeType:(FRMimeType)mimeType;


/**
 * 設定されているContent-Type文字列を取得する。
 *
 * @return Content-Type文字列
 */
- (NSString*)contentType;


/**
 * MIMEパーツを追加する。
 *
 * @param mimePart 追加するMIMEパーツ
 */
- (void)addMimePart:(FRMimePart*)mimePart;


/**
 * MIMEパーツ一覧へアクセスするための列挙子を取得する。
 *
 * @return MIMEパーツ一覧へアクセスするための列挙子
 */
- (NSEnumerator*)enumeratorMimeParts;


/**
 * MIMEパーツ数を取得する。
 *
 * @return MIMEパーツ数
 */
- (NSUInteger)mimePartsCount;


/**
 * 指定されたテキストをプレーンテキストとして設定する。
 *
 * @param text      設定するテキストデータ
 */
- (void)setText:(NSString*)text;


/**
 * 指定されたテキストをプレーンテキストとして設定する。
 *
 * @param text          設定するテキストデータ
 * @param charset       テキストの文字コード
 */
- (void)setText:(NSString*)text charset:(NSString*)charset;


/**
 * 指定されたテキストをHTMLテキストとして設定する。
 *
 * @param text      設定するテキストデータ
 */
- (void)setHtmlText:(NSString*)text;


/**
 * 指定されたテキストをHTMLテキストとして設定する。
 *
 * @param text          設定するテキストデータ
 * @param charset       テキストの文字コード
 */
- (void)setHtmlText:(NSString*)text charset:(NSString*)charset;




@end


#endif
