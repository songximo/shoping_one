import { UserProfileModule } from '../component/my/UserProfileModule';
import { QuickAccessModule } from '../component/my/QuickAccessModule';
import { CommonServicesModule } from '../component/my/CommonServicesModule';

@Component
export struct MyPage {
  @Provide('appPathStack') appPathStack: NavPathStack = new NavPathStack();

  private scroller: Scroller = new Scroller();

  build() {
    Scroll(this.scroller) {
      Column() {
        UserProfileModule()
        QuickAccessModule()
        CommonServicesModule()
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
    .height("100%")
    .width('100%')
    .align(Alignment.Top)
    // .backgroundColor('#FAE35A')
  }
}




//
//
// import { router } from '@kit.ArkUI';
// import { promptAction } from '@kit.ArkUI';
//
// // 用户信息接口定义
// interface UserInfo {
//   avatar: Resource | string;
//   nickname: string;
//   phone: string;
//   isVip: boolean;
//   vipLevel?: number;
// }
//
// // 菜单项接口定义
// interface MenuItem {
//   id: number;
//   icon: Resource;
//   title: string;
//   subtitle?: string;
//   showArrow?: boolean;
//   showDivider?: boolean;
//   badge?: number; // 徽章数字
// }
//
// @Entry
// @Component
// export struct MyPage {
//   // 用户信息状态
//   @State userInfo: UserInfo = {
//     avatar: $r('app.media.icon'),
//     nickname: '游客',
//     phone: '',
//     isVip: false,
//     vipLevel: 0
//   };
//
//   // 是否已登录
//   @State isLoggedIn: boolean = false;
//
//   // 菜单数据
//   private menuItems: MenuItem[] = [
//     {
//       id: 1,
//       icon: $r('app.media.icon'),
//       title: '我的订单',
//       subtitle: '查看全部订单',
//       showArrow: true,
//       showDivider: true
//     },
//     {
//       id: 2,
//       icon: $r('app.media.icon'),
//       title: '我的收藏',
//       showArrow: true,
//       showDivider: true,
//       badge: 3
//     },
//     {
//       id: 3,
//       icon: $r('app.media.icon'),
//       title: '收货地址',
//       subtitle: '管理收货地址',
//       showArrow: true,
//       showDivider: true
//     },
//     {
//       id: 4,
//       icon: $r('app.media.icon'),
//       title: '优惠券',
//       showArrow: true,
//       showDivider: true,
//       badge: 5
//     },
//     {
//       id: 5,
//       icon: $r('app.media.icon'),
//       title: '联系客服',
//       showArrow: true,
//       showDivider: false
//     }
//   ];
//
//   private settingItems: MenuItem[] = [
//     {
//       id: 6,
//       icon: $r('app.media.icon'),
//       title: '设置',
//       showArrow: true,
//       showDivider: true
//     },
//     {
//       id: 7,
//       icon: $r('app.media.icon'),
//       title: '关于我们',
//       showArrow: true,
//       showDivider: false
//     }
//   ];
//
//   aboutToAppear(): void {
//     // 模拟加载用户信息
//     this.loadUserInfo();
//   }
//
//   // 加载用户信息
//   private loadUserInfo(): void {
//     // TODO: 从本地存储或网络加载用户信息
//     // 这里模拟已登录状态
//     this.isLoggedIn = true;
//     this.userInfo = {
//       avatar: $r('app.media.icon'),
//       nickname: '张三',
//       phone: '138****8888',
//       isVip: true,
//       vipLevel: 6
//     };
//   }
//
//   // 处理菜单项点击
//   private handleMenuClick(item: MenuItem): void {
//     switch (item.id) {
//       case 1: // 我的订单
//         router.pushUrl({ url: 'pages/OrderPage' });
//         break;
//       case 2: // 我的收藏
//         router.pushUrl({ url: 'pages/FavoritePage' });
//         break;
//       case 3: // 收货地址
//         router.pushUrl({ url: 'pages/AddressPage' });
//         break;
//       case 4: // 优惠券
//         router.pushUrl({ url: 'pages/CouponPage' });
//         break;
//       case 5: // 联系客服
//         this.showContactDialog();
//         break;
//       case 6: // 设置
//         router.pushUrl({ url: 'pages/SettingPage' });
//         break;
//       case 7: // 关于我们
//         router.pushUrl({ url: 'pages/AboutPage' });
//         break;
//       default:
//         break;
//     }
//   }
//
//   // 显示联系客服对话框
//   private showContactDialog(): void {
//     AlertDialog.show({
//       title: '联系客服',
//       message: '客服电话：400-123-4567\n工作时间：9:00-18:00',
//       primaryButton: {
//         value: '取消',
//         action: () => {}
//       },
//       secondaryButton: {
//         value: '拨打电话',
//         action: () => {
//           // TODO: 实现拨打电话功能
//           promptAction.showToast({ message: '拨打电话功能待实现' });
//         }
//       }
//     });
//   }
//
//   // 处理退出登录
//   private handleLogout(): void {
//     AlertDialog.show({
//       title: '提示',
//       message: '确定要退出登录吗？',
//       primaryButton: {
//         value: '取消',
//         action: () => {}
//       },
//       secondaryButton: {
//         value: '确定',
//         action: () => {
//           this.isLoggedIn = false;
//           this.userInfo = {
//             avatar: $r('app.media.icon'),
//             nickname: '游客',
//             phone: '',
//             isVip: false
//           };
//           promptAction.showToast({ message: '已退出登录' });
//           // TODO: 清除本地存储的用户信息
//         }
//       }
//     });
//   }
//
//   build() {
//     Column() {
//       // 用户信息区域
//       this.buildUserInfoSection();
//
//       // 功能菜单区域
//       this.buildMenuSection();
//
//       // 设置区域
//       this.buildSettingSection();
//
//       // 退出登录按钮
//       if (this.isLoggedIn) {
//         this.buildLogoutButton();
//       }
//     }
//     .width('100%')
//     .height('100%')
//     .backgroundColor('#F5F5F5');
//   }
//
//   // 用户信息区域
//   @Builder
//   private buildUserInfoSection() {
//     Column() {
//       Row() {
//         // 头像
//         Image(this.userInfo.avatar)
//           .width(60)
//           .height(60)
//           .borderRadius(30)
//           .objectFit(ImageFit.Cover)
//           .onClick(() => {
//             if (this.isLoggedIn) {
//               router.pushUrl({ url: 'pages/ProfilePage' });
//             }
//           });
//
//         // 用户信息
//         Column() {
//           Text(this.userInfo.nickname)
//             .fontSize(20)
//             .fontWeight(FontWeight.Bold)
//             .fontColor('#333333');
//
//           if (this.isLoggedIn) {
//             Row() {
//               if (this.userInfo.isVip) {
//                 Text(`VIP${this.userInfo.vipLevel}`)
//                   .fontSize(12)
//                   .fontColor('#FFD700')
//                   .backgroundColor('#FFF8E1')
//                   .padding({ left: 6, right: 6, top: 2, bottom: 2 })
//                   .borderRadius(4);
//               }
//
//               Text(this.userInfo.phone)
//                 .fontSize(14)
//                 .fontColor('#999999')
//                 .margin({ left: 8 });
//             }
//             .margin({ top: 6 });
//           } else {
//             Text('点击登录')
//               .fontSize(14)
//               .fontColor('#007DFF')
//               .margin({ top: 6 })
//               .onClick(() => {
//                 router.pushUrl({ url: 'pages/LoginPage' });
//               });
//           }
//         }
//         .alignItems(HorizontalAlign.Start)
//         .margin({ left: 16 })
//         .layoutWeight(1);
//
//         // 右箭头
//         if (this.isLoggedIn) {
//           Image($r('app.media.icon'))
//             .width(20)
//             .height(20)
//             .fillColor('#CCCCCC')
//             .onClick(() => {
//               router.pushUrl({ url: 'pages/ProfilePage' });
//             });
//         }
//       }
//       .width('100%')
//       .padding(16)
//       .backgroundColor(Color.White)
//       .borderRadius(8);
//     }
//     .width('100%')
//     .padding({ left: 12, right: 12, top: 12 });
//   }
//
//   // 功能菜单区域
//   @Builder
//   private buildMenuSection() {
//     Column() {
//       ForEach(this.menuItems, (item: MenuItem) => {
//         this.buildMenuItem(item);
//       });
//     }
//     .width('100%')
//     .backgroundColor(Color.White)
//     .borderRadius(8)
//     .margin({ top: 12, left: 12, right: 12 });
//   }
//
//   // 设置区域
//   @Builder
//   private buildSettingSection() {
//     Column() {
//       ForEach(this.settingItems, (item: MenuItem) => {
//         this.buildMenuItem(item);
//       });
//     }
//     .width('100%')
//     .backgroundColor(Color.White)
//     .borderRadius(8)
//     .margin({ top: 12, left: 12, right: 12 });
//   }
//
//   // 菜单项构建器
//   @Builder
//   private buildMenuItem(item: MenuItem) {
//     Row() {
//       // 图标
//       Image(item.icon)
//         .width(24)
//         .height(24)
//         .fillColor('#666666');
//
//       // 标题
//       Text(item.title)
//         .fontSize(16)
//         .fontColor('#333333')
//         .margin({ left: 12 })
//         .layoutWeight(1);
//
//       // 副标题
//       if (item.subtitle) {
//         Text(item.subtitle)
//           .fontSize(14)
//           .fontColor('#999999')
//           .margin({ right: 8 });
//       }
//
//       // 徽章
//       if (item.badge && item.badge > 0) {
//         Text(item.badge.toString())
//           .fontSize(12)
//           .fontColor(Color.White)
//           .backgroundColor('#FF4444')
//           .padding({ left: 6, right: 6, top: 2, bottom: 2 })
//           .borderRadius(10)
//           .margin({ right: 8 });
//       }
//
//       // 右箭头
//       if (item.showArrow) {
//         Image($r('app.media.icon'))
//           .width(16)
//           .height(16)
//           .fillColor('#CCCCCC');
//       }
//     }
//     .width('100%')
//     .height(56)
//     .padding({ left: 16, right: 16 })
//     .onClick(() => {
//       this.handleMenuClick(item);
//     });
//
//     // 分割线
//     if (item.showDivider) {
//       Divider()
//         .width('100%')
//         .height(0.5)
//         .color('#E5E5E5')
//         .margin({ left: 52 });
//     }
//   }
//
//   // 退出登录按钮
//   @Builder
//   private buildLogoutButton() {
//     Button('退出登录')
//       .width('90%')
//       .height(44)
//       .fontSize(16)
//       .fontColor('#FF4444')
//       .backgroundColor(Color.White)
//       .borderRadius(8)
//       .margin({ top: 24 })
//       .onClick(() => {
//         this.handleLogout();
//       });
//   }
// }