// D:\SanDown\PBL\shopping\entry\src\main\ets\component\my\QuickAccessModule.ets

import { router } from '@kit.ArkUI';
import { promptAction } from '@kit.ArkUI';

// 菜单项接口定义
interface MenuItem {
  id: number;
  icon: Resource;
  title: string;
  subtitle?: string;
  showArrow?: boolean;
  showDivider?: boolean;
  badge?: number;
}

@Component
export struct QuickAccessModule {
  // 消费父组件提供的导航栈
  @Consume('appPathStack') appPathStack: NavPathStack;

  // 菜单数据
  private menuItems: MenuItem[] = [
    {
      id: 1,
      icon: $r('app.media.wodedingdan'),
      title: '我的订单',
      subtitle: '查看全部订单',
      showArrow: true,
      showDivider: true
    },
    {
      id: 2,
      icon: $r('app.media.wodeshoucang'),
      title: '我的收藏',
      subtitle: '查看全部',
      showArrow: true,
      showDivider: true
      // badge: 3
    },
    {
      id: 3,
      icon: $r('app.media.shouhuodizhi'),
      title: '收货地址',
      subtitle: '管理收货地址',
      showArrow: true,
      showDivider: true
    },
    // {
    //   id: 4,
    //   icon: $r('app.media.icon'),
    //   title: '优惠券',
    //   showArrow: true,
    //   showDivider: true,
    //   badge: 5
    // },
    {
      id: 5,
      icon: $r('app.media.kefu'),
      title: '联系客服',
      showArrow: true,
      showDivider: false
    }
  ];

  // 处理菜单项点击
  private handleMenuClick(item: MenuItem): void {
    switch (item.id) {
      case 1: // 我的订单
        router.pushUrl({ url: 'pages/my/OrderPage' });
        break;
      case 2: // 我的收藏
        router.pushUrl({ url: 'pages/my/FavoritePage' });
        break;
      case 3: // 收货地址
        router.pushUrl({ url: 'pages/my/AddressPage' });
        break;
      // case 4: // 优惠券
      //   router.pushUrl({ url: 'pages/CouponPage' });
      //   break;
      case 5: // 联系客服
        this.showContactDialog();
        break;
      default:
        break;
    }
  }

  // 显示联系客服对话框
  private showContactDialog(): void {
    AlertDialog.show({
      title: '联系客服',
      message: '客服电话：123-456-7890\n工作时间：9:00-18:00',
      primaryButton: {
        value: '取消',
        action: () => {}
      },
      secondaryButton: {
        value: '拨打电话',
        action: () => {
          promptAction.showToast({ message: '请复制到电话本拨打' });
        }
      }
    });
  }

  build() {
    Column() {
      ForEach(this.menuItems, (item: MenuItem) => {
        this.buildMenuItem(item);
      });
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(8)
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

      // 副标题
      if (item.subtitle) {
        Text(item.subtitle)
          .fontSize(14)
          .fontColor('#999999')
          .margin({ right: 8 });
      }

      // 徽章
      if (item.badge && item.badge > 0) {
        Text(item.badge.toString())
          .fontSize(12)
          .fontColor(Color.White)
          .backgroundColor('#FF4444')
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .borderRadius(10)
          .margin({ right: 8 });
      }

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
}