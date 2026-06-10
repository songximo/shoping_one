// D:\SanDown\PBL\shopping\entry\src\main\ets\component\my\UserProfileModule.ets

import { router } from '@kit.ArkUI';

// 用户信息接口定义
export interface UserInfo {
  avatar: Resource | string;
  nickname: string;
  phone: string;
  isVip: boolean;
  vipLevel?: number;
}

@Component
export struct UserProfileModule {
  // 用户信息状态
  @State userInfo: UserInfo = {
    avatar: $r('app.media.youke'),
    nickname: '游客',
    phone: '',
    isVip: false,
    vipLevel: 0
  };

  // 是否已登录
  @State isLoggedIn: boolean = false;

  aboutToAppear(): void {
    this.loadUserInfo();
  }

  // 加载用户信息
  private loadUserInfo(): void {
    // TODO: 从本地存储或网络加载用户信息
    // 模拟已登录状态
    this.isLoggedIn = true;
    this.userInfo = {
      avatar: $r('app.media.yonghu'),
      nickname: '张三',
      phone: '138****8888',
      isVip: true,
      vipLevel: 6
    };
  }

  build() {
    Column() {
      Row() {
        // 头像
        Image(this.userInfo.avatar)
          .width(60)
          .height(60)
          .borderRadius(30)
          .objectFit(ImageFit.Cover)
          .onClick(() => {
            if (this.isLoggedIn) {
              router.pushUrl({ url: 'pages/ProfilePage' });
            }
          });

        // 用户信息
        Column() {
          Text(this.userInfo.nickname)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333');

          if (this.isLoggedIn) {
            Row() {
              if (this.userInfo.isVip) {
                Text(`VIP${this.userInfo.vipLevel}`)
                  .fontSize(12)
                  .fontColor(Color.Orange)
                  .backgroundColor(Color.Black)
                  .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                  .borderRadius(4);
              }

              Text(this.userInfo.phone)
                .fontSize(14)
                .fontColor('#999999')
                .margin({ left: 8 });
            }
            .margin({ top: 6 });
          } else {
            Text('点击登录')
              .fontSize(14)
              .fontColor('#007DFF')
              .margin({ top: 6 })
              .onClick(() => {
                router.pushUrl({ url: 'pages/LoginPage' });
              });
          }
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 16 })
        .layoutWeight(1);

        // 右箭头
        if (this.isLoggedIn) {
          Image($r('app.media.ic_public_arrow_right'))
            .width(20)
            .height(20)
            .fillColor('#CCCCCC')
            .onClick(() => {
              router.pushUrl({ url: 'pages/ProfilePage' });
            });
        }
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FAE35A')
      .borderRadius(8);
    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 12 });
  }
}