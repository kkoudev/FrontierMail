# FrontierMailについて
FrontierMailはiOSでメール機能を実装するためのライブラリです。
AndroidにはJavaMailという高機能なメールライブラリがあるため
簡単にメール機能をアプリケーションへ実装することが出来ますが、
iOSにおいては標準メーラーを介する機能しか用意されていないため、
自前でサーバーへコマンドを叩いてメールを受信or送信する必要があります。

本ライブラリはそのような複雑な処理を全てラッピングし、
JavaMailのように(またはそれ以上に)
iOSにおいて簡単にメール機能を実装できることを目指したライブラリとなります。

## 利用可能な機能
現バージョンでは以下の機能のみをサポートしています。
今後、対応プロトコルを増やしていく予定です。

・SMTP送信
・MIMEパート作成 (ファイル添付、デコメールの構築も可能)

## 使い方
FrontierMail/build/Debug-framework/FrontierMail.framework
libEtPan/build-mac/build/Debug-framework/libetpan.framework

上記ファイル２つのFramwork Bundleを
XcodeでFrameworkとして取り込んで下さい。
その後、以下のファイルをインポートすることで利用可能になります。

#import <FrontierMail/FrontierMail.h>

## 詳しい使い方や問い合わせなど
こちらのブログで使い方を随時記載しております。
http://mobileapplication.blog.fc2.com/

## [Changelog](CHANGELOG.md)

## [License](LICENSE)
