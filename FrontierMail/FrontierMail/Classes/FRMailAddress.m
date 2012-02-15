//
//  FRMailAddress.m
//  FrontierMail
//
//  Created by Kou on 11/07/26.
//  Copyright 2011 The Frontier Project. All rights reserved.
//

#import "FRMailAddress.h"


/*
 * メールアドレス情報実装部
 */
@implementation FRMailAddress


/*
 * アクセサメソッドの定義
 */
@synthesize name    = mName;
@synthesize address = mAddress;




/**
 * 名前とアドレスを指定して初期化する。
 *
 * @param name      名前
 * @param address   メールアドレス
 * @return 作成したインスタンス
 */
- (FRMailAddress*)initWithName:(NSString*)name 
                       address:(NSString*)address {
    
    // インスタンスを作成する
    self = [super init];
    
    // インスタンス作成に成功した場合
    if (self) {
        
        // 名前とアドレスを設定する
        [self setName:name];
        [self setAddress:address];
        
    }
    
    // 作成したインスタンスを返す
    return self;
    
}


/**
 * 名前とアドレスを指定して一時インスタンスとして初期化する。
 *
 * @param name      名前
 * @param address   メールアドレス
 * @return 作成した一時インスタンス
 */
+ (FRMailAddress*)mailAddressWithName:(NSString*)name 
                              address:(NSString*)address {
    
    return [[[FRMailAddress alloc] initWithName:name address:address] autorelease];
    
}


/**
 * インスタンスを破棄する。
 *
 */
- (void)dealloc {
    
    // メンバ変数を破棄する
    [mName release];
    [mAddress release];
    
    // スーパークラスの解放処理を実行する
    [super dealloc];
    
}



@end
