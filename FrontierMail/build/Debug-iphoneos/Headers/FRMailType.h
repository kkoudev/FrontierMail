//
//  FRMailType.h
//  FrontierMail
//
//  Created by Kou on 11/07/26.
//  Copyright 2011 The Frontier Project. All rights reserved.
//
#ifndef H_FR_MAIL_TYPE___
#define H_FR_MAIL_TYPE___


//----------------------------------------------//
// 各種種別定義                                    //
//----------------------------------------------//

/**
 * メール認証種別。
 *
 * @author Koichi Nagaoka
 */
typedef enum _FRMailAuthType {
    
    FRMailAuthPLAIN,        ///< PLAIN認証
    FRMailAuthLOGIN,        ///< LOGIN認証
    FRMailAuthAPOP,         ///< APOP認証
    FRMailAuthCRAMMD5,      ///< CRAM-MD5認証
    FRMailAuthDIGESTMD5,    ///< DIGEST-MD5認証
    
} FRMailAuthType;


#endif