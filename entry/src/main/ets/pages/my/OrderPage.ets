
//订单不同状态
// pages/OrderPage.ets
import { router } from '@kit.ArkUI';
import { OrderStatus } from '../../models/OrderListData';
import { OrderList } from '../../component/order/OrderList';

@Entry
@Component
struct OrderPage {
  @State currentTab: number = 0;
  private tabs: string[] = ['全部', '待付款', '待收货', '已完成', '已取消'];

  // // 根据 tab 索引获取对应的订单状态
  // private getStatusByTab(tab: number): OrderStatus | null {
  //   switch (tab) {
  //     case 1: return OrderStatus.PendingPayment;
  //     case 2: return OrderStatus.PendingReceipt;
  //     case 3: return OrderStatus.Completed;
  //     case 4: return OrderStatus.Cancelled;
  //     default: return null;
  //   }
  // }

  build() {
    Column() {
      // 顶部导航
      Row() {
        Image($r('app.media.ic_public_arrow_left'))
          .width(24).height(24)
          .onClick(() => router.back())
        Text('我的订单')
          .fontSize(20).fontWeight(FontWeight.Bold)
          .layoutWeight(1).textAlign(TextAlign.Center)
      }
      .width('100%').height(56).padding({ left: 15, right: 15 }).backgroundColor(Color.White)

      // 分类切换
      Row({ space: 0 }) {
        ForEach(this.tabs, (tab: string, idx: number) => {
          Text(tab)
            .fontSize(16)
            .fontWeight(this.currentTab === idx ? FontWeight.Bold : FontWeight.Normal)
            .fontColor(this.currentTab === idx ? '#F84D2C' : '#666')
            .layoutWeight(1).textAlign(TextAlign.Center)
            .padding({ top: 12, bottom: 12 })
            .border({ width: { bottom: this.currentTab === idx ? 2 : 0 }, color: '#F84D2C' })
            .onClick(() => { this.currentTab = idx; })
        })
      }
      .width('100%').backgroundColor(Color.White)

      // 订单列表区域
      if (this.currentTab === 0) {
        OrderList({ status: null })
      } else if (this.currentTab === 1) {
        OrderList({ status: OrderStatus.PendingPayment })
      } else if (this.currentTab === 2) {
        OrderList({ status: OrderStatus.PendingReceipt })
      } else if (this.currentTab === 3) {
        OrderList({ status: OrderStatus.Completed })
      } else if (this.currentTab === 4) {
        OrderList({ status: OrderStatus.Cancelled })
      }
    }
    .width('100%').height('100%').backgroundColor('#F5F5F5')
  }
}
