//
//  FRMailDefine.h
//  FrontierMail
//
//  Created by Kou on 11/07/26.
//  Copyright 2011 The Frontier Project. All rights reserved.
//
#ifndef H_FR_MAIL_DEFINE___
#define H_FR_MAIL_DEFINE___

#import "FRMailType.h"



//----------------------------------------------//
// 認証種別                                       //
//----------------------------------------------//

#define MAIL_AUTH_PLAIN                         "PLAIN"         /**< PLAIN認証 */
#define MAIL_AUTH_LOGIN                         "LOGIN"         /**< LOGIN認証 */
#define MAIL_AUTH_APOP                          "APOP"          /**< APOP認証 */
#define MAIL_AUTH_CRAMMD5                       "CRAM-MD5"      /**< CRAM-MD5認証 */
#define MAIL_AUTH_DIGESTMD5                     "DIGEST-MD5"    /**< DIGEST-MD5認証 */




//----------------------------------------------//
// ヘッダ項目名                                    //
//----------------------------------------------//

/**
 * ヘッダ項目名 : Content-Disposition
 */
#define HEADER_CONTENT_DISPOSITION              "Content-Disposition"




//----------------------------------------------//
// Content-Type                                 //
//----------------------------------------------//

// 文書
#define CONTENT_TYPE_TEXT_PLAIN                 "text/plain"                        /**< プレーンテキスト (text/plain) */
#define CONTENT_TYPE_HTML                       "text/html"                         /**< HTML文書 (text/html) */
#define CONTENT_TYPE_TSV                        "text/tab-separated-values"         /**< TSVファイル (text/tab-separated-values) */
#define CONTENT_TYPE_CSS                        "text/css"                          /**< スタイルシート (text/css) */
#define CONTENT_TYPE_HDML                       "text/x-hdml"                       /**< HDML文書 (text/x-hdml) */
#define CONTENT_TYPE_MSWORD                     "application/msword"                /**< ワード文書 (application/msword) */
#define CONTENT_TYPE_MSEXCEL                    "application/vnd.ms-excel"          /**< エクセルシート (application/vnd.ms-excel) */
#define CONTENT_TYPE_MSPOWERPOINT               "application/vnd.ms-powerpoint"     /**< パワーポイント (application/vnd.ms-powerpoint) */
#define CONTENT_TYPE_PDF                        "application/pdf"                   /**< PDF文書 (application/pdf) */

// 画像ファイル
#define CONTENT_TYPE_JPEG                       "image/jpeg"                        /**< JPEG画像 (image/jpeg) */
#define CONTENT_TYPE_GIF                        "image/gif"                         /**< GIF画像 (image/gif) */
#define CONTENT_TYPE_PNG                        "image/png"                         /**< PNG画像 (image/png) */
#define CONTENT_TYPE_TIFF                       "image/tiff"                        /**< TIFF画像 (image/tiff) */
#define CONTENT_TYPE_BMP                        "image/bmp"                         /**< BMP画像 (image/bmp) */

// 音声ファイル
#define CONTENT_TYPE_AU                         "audio/basic"                       /**< AUオーディオファイル (audio/basic) */
#define CONTENT_TYPE_WAVE                       "audio/x-wav"                       /**< WAVEオーディオファイル (audio/x-wav) */
#define CONTENT_TYPE_AIFF                       "audio/aiff"                        /**< AIFFオーディオファイル (audio/x-aiff) */
#define CONTENT_TYPE_MP4                        "audio/mp4"                         /**< MP4オーディオファイル (audio/mp4) */
#define CONTENT_TYPE_MIDI                       "audio/midi"                        /**< MIDIオーディオファイル (audio/midi) */
#define CONTENT_TYPE_AUDIO_MPEG                 "audio/mpeg"                        /**< MPEGオーディオファイル (audio/mpeg) */
#define CONTENT_TYPE_AUDIO_3GPP                 "audio/3gpp"                        /**< 3GPP音声ファイル (audio/3gpp) */
#define CONTENT_TYPE_AUDIO_3GPP2                "audio/3gpp2"                       /**< 3GPP2音声ファイル (audio/3gpp2) */
#define CONTENT_TYPE_AUDIO_OGG                  "audio/ogg"                         /**< OGG音声ファイル (audio/ogg) */

// 動画ファイル
#define CONTENT_TYPE_WMV                        "video/x-ms-wmv"                    /**< WMVファイル (video/x-ms-wmv) */
#define CONTENT_TYPE_FLASH                      "application/x-shockwave-flash"     /**< FLASHファイル (application/x-shockwave-flash) */
#define CONTENT_TYPE_VIDEO_MPEG                 "video/mpeg"                        /**< MPEG動画ファイル (video/mpeg) */
#define CONTENT_TYPE_VIDEO_3GPP                 "video/3gpp"                        /**< 3GPP動画ファイル (video/3gpp) */
#define CONTENT_TYPE_VIDEO_3GPP2                "video/3gpp2"                       /**< 3GPP2動画ファイル (video/3gpp2) */
#define CONTENT_TYPE_VIDEO_OGG                  "video/ogg"                         /**< OGG動画ファイル (video/ogg) */

// 圧縮ファイル
#define CONTENT_TYPE_ZIP                        "application/zip"                   /**< ZIPファイル (application/x-zip) */
#define CONTENT_TYPE_GZIP                       "application/x-gzip"                /**< GZIPファイル (application/x-gzip) */
#define CONTENT_TYPE_TAR                        "application/x-tar"                 /**< TARファイル (application/x-tar) */
#define CONTENT_TYPE_LZH                        "application/x-lzh"                 /**< LZHファイル (application/x-lzh) */
#define CONTENT_TYPE_JAR                        "application/java-archive"          /**< JARファイル (application/java-archive) */
#define CONTENT_TYPE_CAB                        "application/cab"                   /**< CABファイル (application/cab) */
#define CONTENT_TYPE_BZ2                        "application/x-bzip2"               /**< BZ2ファイル (application/x-bzip2) */
#define CONTENT_TYPE_RAR                        "application/rar"                   /**< RARファイル (application/rar) */
#define CONTENT_TYPE_7Z                         "application/x-7z-compressed"       /**< 7Zファイル (application/x-7z-compressed) */

// マルチパート
#define CONTENT_TYPE_MULTIPART_MIXED            "multipart/mixed"                   /**< 複数データ (multipart/mixed) */
#define CONTENT_TYPE_MULTIPART_RELATED          "multipart/related"                 /**< メッセージリンク (multipart/related) */
#define CONTENT_TYPE_MULTIPART_ALTERNATIVE      "multipart/alternative"             /**< 同一内容他形式表現 (multipart/alternative) */
#define CONTENT_TYPE_MULTIPART_DIGEST           "multipart/digest"                  /**< RFC822メッセージ (multipart/digest) */
#define CONTENT_TYPE_MULTIPART_ENCRYPTED        "multipart/encrypted"               /**< 暗号化メッセージ (multipart/encrypted) */
#define CONTENT_TYPE_MULTIPART_PARALLEL         "multipart/parallel"                /**< 複合表示 (multipart/parallel) */
#define CONTENT_TYPE_MULTIPART_REPORT           "multipart/report"                  /**< エラーメール等のレポート型 (multipart/report) */
#define CONTENT_TYPE_MULTIPART_SIGNED           "multipart/signed"                  /**< S/MIME署名付メッセージ (multipart/signed) */

// 汎用
#define CONTENT_TYPE_OCTET_STREAM               "application/octet-stream"          /**< バイナリ形式 (application/octet-stream) */




//----------------------------------------------//
// デフォルトContent-Type                         //
//----------------------------------------------//

/**
 * MIMEシングルパートのデフォルトContent-Type
 */
#define CONTENT_TYPE_DEFAULT_MIME_SINGLE_PART   CONTENT_TYPE_OCTET_STREAM

/**
 * MIMEマルチパートのデフォルトContent-Type
 */
#define CONTENT_TYPE_DEFAULT_MIME_MULTI_PART    CONTENT_TYPE_MULTIPART_MIXED




//----------------------------------------------//
// 文字コード                                     //
//----------------------------------------------//

/**
 * 文字コード : US-ASCII
 */
#define CHARSET_US_ASCII                        "US-ASCII"

/**
 * 文字コード : ISO-2022-JP
 */
#define CHARSET_ISO_2022_JP                     "ISO-2022-JP"

/**
 * 文字コード : Shift_JIS
 */
#define CHARSET_SHIFT_JIS                       "Shift_JIS"

/**
 * 文字コード : EUC-JP
 */
#define CHARSET_EUC_JP                          "EUC-JP"

/**
 * 文字コード : UTF-8
 */
#define CHARSET_UTF_8                           "UTF-8"

/**
 * 文字コード : UTF-16
 */
#define CHARSET_UTF_16                          "UTF-16"

/**
 * 文字コード : UTF-16LE
 */
#define CHARSET_UTF_16LE                        "UTF-16LE"

/**
 * 文字コード : UTF-16BE
 */
#define CHARSET_UTF_16BE                        "UTF-16BE"




//----------------------------------------------//
// プロトコル共通                                  //
//----------------------------------------------//

/**
 * IPポートデータのフォーマット
 */
#define FORMAT_IP_PORT                          "%s;%i"




//----------------------------------------------//
// MIME関係                                      //
//----------------------------------------------//

/**
 * デフォルト文字コード
 */
#define CHARSET_DEFAULT                         CHARSET_ISO_2022_JP

/**
 * Content-Typeパラメータ項目名 : 文字コード
 */
#define PARAM_NAME_CONTENT_TYPE_CHARSET         "charset"

/**
 * Content-Typeパラメータ項目名 : 名前
 */
#define PARAM_NAME_CONTENT_TYPE_NAME            "name"

/**
 * ヘッダエンコーディング文字列フォーマット
 */
#define FORMAT_HEADER_TEXT                      "=?" CHARSET_DEFAULT "?B?%@?="




//----------------------------------------------//
// MIME関係                                      //
//----------------------------------------------//

/**
 * Content-Dispositionの添付ファイル名設定値フォーマット
 */
#define CONTENT_DISPOSITION_ATTACHMENT_FORMAT   "attachment; filename=%@"




//----------------------------------------------//
// SMTP関係                                      //
//----------------------------------------------//

/**
 * IPアドレス文字列長
 */
#define IP_ADDRESS_LENGTH                       (128)




#endif