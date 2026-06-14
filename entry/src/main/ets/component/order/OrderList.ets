
//订单不同状态
// component/order/OrderList.ets
import { router, promptAction } from '@kit.ArkUI';
import { CartItemData } from '../../models/CartDataItem';
import { OrderInfo, OrderStatus, loadOrders, updateOrderStatus, deleteOrder } from '../../models/OrderListData';

@Component
export struct OrderList {
  @Prop status: OrderStatus | null = null;
  @State orders: OrderInfo[] = [];

  aboutToAppear() {
    this.refreshOrders();
  }

  async refreshOrders() {
    let list = await loadOrders();
    if (this.status !== null) {
      list = list.filter(o => o.status === this.status);
    }
    // 强制刷新：先置空，再赋值（用 setTimeout 避免同步问题）
    this.orders = [];
    setTimeout(() => {
      this.orders = list;
    }, 0);
  }

  async cancelOrder(order: OrderInfo) {
    AlertDialog.show({
      title: '取消订单',
      message: '确定要取消该订单吗？',
      primaryButton: { value: '取消', action: () => {} },
      secondaryButton: {
        value: '确定',
        fontColor: '#FF3B30',
        action: async () => {
          await updateOrderStatus(order.id, OrderStatus.Cancelled);
          await this.refreshOrders();
          promptAction.showToast({ message: '订单已取消' });
        }
      }
    });
  }

  async Complete(order: OrderInfo) {
    AlertDialog.show({
      title: '确认收货',
      message: '是否确认收货？确认后订单将变为已完成。',
      primaryButton: { value: '取消', action: () => {} },
      secondaryButton: {
        value: '确定',
        fontColor: '#F84D2C',
        action: async () => {
          await updateOrderStatus(order.id, OrderStatus.Completed);
          await this.refreshOrders();
          promptAction.showToast({ message: '确认收货，订单已完成' });
        }
      }
    });
  }

  //删除单独
  async deleteOrder(order: OrderInfo) {
    AlertDialog.show({
      title: '删除订单',
      message: '确定要删除该订单吗？删除后不可恢复。',
      primaryButton: { value: '取消', action: () => {} },
      secondaryButton: {
        value: '确定',
        fontColor: '#FF3B30',
        action: async () => {
          await deleteOrder(order.id);
          await this.refreshOrders();
          promptAction.showToast({ message: '订单已删除' });
        }
      }
    });
  }

  async payOrder(order: OrderInfo) {
    // promptAction.showToast({ message: '支付功能待实现' });
    AlertDialog.show({
      title: '确认支付',
      message: '是否确认支付？',
      primaryButton: { value: '取消', action: () => {} },
      secondaryButton: {
        value: '确定',
        fontColor: '#F84D2C',
        action: async () => {
          await updateOrderStatus(order.id, OrderStatus.PendingReceipt);
          await this.refreshOrders();
          promptAction.showToast({ message: '订单已支付' });
        }
      }
    });
  }



  @Builder
  OrderItemBuilder(order: OrderInfo) {
    Column() {
      Row() {
        Text(`订单号：${order.orderId.slice(-8)}`).fontSize(14).fontColor('#666')
        Blank()
        Text(this.getStatusText(order.status))
          .fontSize(14)
          .fontColor(order.status === OrderStatus.PendingPayment ? '#F84D2C' : '#999')
      }
      .width('100%').margin({ bottom: 8 })

      // 商品列表
      Column() {
        if (order.items.length === 0) {
          Text('暂无商品').fontSize(12).fontColor('#999')
        } else {
          ForEach(order.items.slice(0, 2), (item: CartItemData, index: number) => {
            Row({ space: 12 }) {
              Image(item.image).width(50).height(50).borderRadius(6)
              Column({ space: 2 }) {
                Text(item.name).fontSize(14).maxLines(1)
                Text(`x${item.count}`).fontSize(12).fontColor('#999')
              }
              .alignItems(HorizontalAlign.Start).layoutWeight(1)
              Text(`¥${((item.discount ?? 0) * (item.count ?? 0)).toFixed(2)}`)
                .fontSize(14).fontColor('#F84D2C')
            }
            .width('100%').padding({ top: 4, bottom: 4 })
          }, (item: CartItemData, index: number) => item.id?.toString() ?? index.toString())
        }
        if (order.items.length > 2) {
          Text(`等${order.items.length}件商品`).fontSize(12).fontColor('#999').margin({ top: 4 })
        }
      }

      Row() {
        Text(`共${order.totalCount}件商品 合计：`).fontSize(14).fontColor('#666')
        Text(`¥${order.totalPrice.toFixed(2)}`).fontSize(16).fontWeight(FontWeight.Bold).fontColor('#F84D2C')
      }
      .width('100%').justifyContent(FlexAlign.End).margin({ top: 8, bottom: 8 })

      // 操作按钮
      Row({ space: 12 }) {
        if (order.status === OrderStatus.PendingPayment) {
          Button('取消订单').fontSize(14).fontColor(Color.Black).backgroundColor(Color.Transparent).border({ width: 1, color: '#ccc' })
            .borderRadius(4).padding({ left: 12, right: 12 }).onClick(() => this.cancelOrder(order))
          Button('去付款').fontSize(14).backgroundColor('#F84D2C').fontColor(Color.White)
            .borderRadius(4).padding({ left: 12, right: 12 }).onClick(() => this.payOrder(order))
        } else if (order.status === OrderStatus.PendingReceipt) {
          Button('确认收货').fontSize(14).backgroundColor('#F84D2C').fontColor(Color.White)
            .borderRadius(4).padding({ left: 12, right: 12 })
            .onClick(() => this.Complete(order))
        } else if (order.status === OrderStatus.Completed) {
          Button('再次购买').fontSize(14).fontColor(Color.Black).backgroundColor(Color.Transparent).border({ width: 1, color: '#ccc' })
            .borderRadius(4).onClick(() => promptAction.showToast({ message: '再次购买功能待实现' }))
          Button('删除订单').fontSize(14).fontColor(Color.Black).backgroundColor(Color.Transparent).border({ width: 1, color: '#ccc' })
            .borderRadius(4).onClick(() => this.deleteOrder(order))
        } else if (order.status === OrderStatus.Cancelled) {
          Button('删除订单').fontSize(14).fontColor(Color.Black).backgroundColor(Color.Transparent).border({ width: 1, color: '#ccc' })
            .borderRadius(4).onClick(() => this.deleteOrder(order))
        }
      }
      .width('100%').justifyContent(FlexAlign.End).margin({ top: 8 })
    }
    .width('100%').padding(12).backgroundColor(Color.White).borderRadius(8).margin({ bottom: 12 })
  }

  private getStatusText(status: OrderStatus): string {
    switch (status) {
      case OrderStatus.PendingPayment: return '待付款';
      case OrderStatus.PendingReceipt: return '待收货';
      case OrderStatus.Completed: return '已完成';
      case OrderStatus.Cancelled: return '已取消';
      default: return '';
    }
  }

  build() {
    Scroll() {
      Column() {
        if (this.orders.length === 0) {
          Text('暂无订单').fontSize(16).fontColor('#999').margin({ top: 50 }).width('100%').textAlign(TextAlign.Center)
        } else {
          ForEach(this.orders, (order: OrderInfo) => {
            this.OrderItemBuilder(order)
          }, (order: OrderInfo) => order.id + '_' + order.status)  // ✅ 加入 status
        }
      }
      .padding(12).width('100%')
    }
    .layoutWeight(1).backgroundColor('#F5F5F5')
  }
}









