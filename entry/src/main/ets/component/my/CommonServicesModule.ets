// D:\SanDown\PBL\shopping\entry\src\main\ets\component\my\CommonServicesModule.ets

import { router } from '@kit.ArkUI';
import { promptAction } from '@kit.ArkUI';

// 菜单项接口定义
interface MenuItem {
  id: number;
  icon: Resource;
  title: string;
  showArrow?: boolean;
  showDivider?: boolean;
}

@Component
export struct CommonServicesModule {
  // 是否已登录
  @State isLoggedIn: boolean = true;

  // 设置菜单数据
  private settingItems: MenuItem[] = [
    // {
    //   id: 6,
    //   icon: $r('app.media.icon'),
    //   title: '设置',
    //   showArrow: true,
    //   showDivider: true
    // },
    {
      id: 7,
      icon: $r('app.media.icon'),
      title: '关于我们',
      showArrow: true,
      showDivider: false
    }
  ];

  // 处理菜单项点击
  private handleMenuClick(item: MenuItem): void {
    switch (item.id) {
      // case 6: // 设置
      //   router.pushUrl({ url: 'pages/SettingPage' });
      //   break;
      case 7: // 关于我们
        router.pushUrl({ url: 'pages/AboutPage' });
        break;
      default:
        break;
    }
  }

  // 处理退出登录
  // private handleLogout(): void {
  //   AlertDialog.show({
  //     title: '提示',
  //     message: '确定要退出登录吗？',
  //     primaryButton: {
  //       value: '取消',
  //       action: () => {}
  //     },
  //     secondaryButton: {
  //       value: '确定',
  //       action: () => {
  //         this.isLoggedIn = false;
  //         promptAction.showToast({ message: '已退出登录' });
  //         // TODO: 清除本地存储的用户信息
  //         // 可以通过事件通知 UserProfileModule 更新状态
  //       }
  //     }
  //   });
  // }

  build() {
    Column() {
      // 设置菜单
      Column() {
        ForEach(this.settingItems, (item: MenuItem) => {
          this.buildMenuItem(item);
        });
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(8);

      // 退出登录按钮
      // if (this.isLoggedIn) {
      //   this.buildLogoutButton();
      // }
    }
    .width('100%')
    .margin({ top: 12, left: 12, right: 12 });
  }

  // 菜单项构建器
  @Builder
  private buildMenuItem(item: MenuItem) {
    Row() {
      // 图标
      Image(item.icon)
        .width(24)
        .height(24)
        .fillColor('#666666');

      // 标题
      Text(item.title)
        .fontSize(16)
        .fontColor('#333333')
        .margin({ left: 12 })
        .layoutWeight(1);

      // 右箭头
      if (item.showArrow) {
        Image($r('app.media.ic_public_arrow_right'))
          .width(16)
          .height(16)
          .fillColor('#CCCCCC');
      }
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .onClick(() => {
      this.handleMenuClick(item);
    });

    // 分割线
    if (item.showDivider) {
      Divider()
        .width('100%')
        .height(0.5)
        .color('#E5E5E5')
        .margin({ left: 52 });
    }
  }

  // 退出登录按钮
  // @Builder
  // private buildLogoutButton() {
  //   Button('退出登录')
  //     .width('90%')
  //     .height(44)
  //     .fontSize(16)
  //     .fontColor(Color.White)
  //     .backgroundColor(Color.Red)
  //     .borderRadius(8)
  //     .margin({ top: 12 })
  //     .onClick(() => {
  //       this.handleLogout();
  //     });
  // }
}