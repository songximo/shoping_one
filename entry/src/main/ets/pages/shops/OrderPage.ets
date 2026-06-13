//OrderPage.ets
import { router, promptAction } from '@kit.ArkUI';
import { CartItemData } from '../../models/CartDataItem'
import { AddressInfo } from '../../models/AddressData'
import { clearCart, getSelectAddress, goSelectAddress } from '../../utils'

@Entry
@Component
struct OrderPage {
  @State cartList: CartItemData[] = []
  @State totalPrice: number = 0
  @State totalCount: number = 0
  @State selectAddr: AddressInfo | null = null

  async aboutToAppear() {
    // 仅首次加载订单参数
    const params = router.getParams() as Record<string, Object>
    if (params && this.totalPrice === 0) {
      this.totalPrice = params.totalPrice as number
      this.totalCount = params.totalCount as number
      if (params.cartData) {
        this.cartList = JSON.parse(params.cartData as string)
      }
    }
    // 每次页面进入都拉取地址
    // this.selectAddr = await getSelectAddress()
    // 初次加载也获取地址（如果已有缓存）
    await this.refreshAddress()
  }
  // 每次页面显示时刷新地址（从地址页返回后生效）
  async onPageShow() {
    await this.refreshAddress()
  }

  async refreshAddress() {
    this.selectAddr = await getSelectAddress()
  }

  submitOrder() {
    if (!this.selectAddr) {
      promptAction.showDialog({ message: '请先选择收货地址' })
      return
    }
    promptAction.showDialog({ message: '下单成功！' })
    clearCart()
    router.back()
  }

  build() {
    Column() {
      // 顶部导航
      Row() {
        Image($r('app.media.ic_public_arrow_left'))
          .width(24).height(24)
          .onClick(() => router.back())
        Text('订单确认')
          .fontSize(18)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor(Color.White)
      .padding({ left: 15, right: 15 })

      // 收货地址区域
      Column() {
        Row() {
          Text('收货地址')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .layoutWeight(1)

          Button('选择地址')
            .width(100)
            .height(32)
            .backgroundColor('#007AFF')
            .fontColor(Color.White)
            .borderRadius(16)
            .onClick(() => {
              goSelectAddress()
            })
        }
        .width('100%')

        if (this.selectAddr) {
          Column({ space: 6 }) {
            Row({ space: 10 }) {
              Text(this.selectAddr.name).fontSize(15)
              Text(this.selectAddr.phone).fontSize(15)
              if (this.selectAddr.isDefault) {
                Text('默认')
                  .fontSize(12)
                  .fontColor(Color.White)
                  .backgroundColor('#FF5722')
                  .padding({ left: 4, right: 4 })
                  .borderRadius(4)
              }
            }
            Text(this.selectAddr.fullAddress)
              .fontSize(14)
              .fontColor('#666')
          }
          .width('100%')
          .margin({ top: 8 })
        } else {
          Text('暂未选择收货地址')
            .fontSize(14)
            .fontColor('#999')
            .margin({ top: 8 })
        }
      }
      .width('100%')
      .padding(15)
      .backgroundColor(Color.White)
      .margin({ top: 10 })

      // 商品清单
      Column() {
        Text('商品清单')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .margin({ bottom: 10 })

        List({ space: 10 }) {
          ForEach(this.cartList, (item: CartItemData) => {
            ListItem() {
              Row({ space: 12 }) {
                Image(item.image)
                  .width(60)
                  .height(60)
                  .borderRadius(6)

                Column({ space: 4 }) {
                  Text(item.name)
                    .fontSize(14)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                  Text(`¥${item.discount}`)
                    .fontSize(14)
                    .fontColor('#F84D2C')
                  Text(`数量：${item.count}`)
                    .fontSize(12)
                    .fontColor('#999')
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Text(`¥${(item.discount * item.count).toFixed(2)}`)
                  .fontSize(14)
              }
              .width('100%')
              .padding(8)
              .backgroundColor('#F9F9F9')
              .borderRadius(6)
            }
          })
        }
      }
      .width('100%')
      .padding(15)
      .backgroundColor(Color.White)
      .margin({ top: 10 })
      .layoutWeight(1)

      // 金额合计
      Column() {
        Row() {
          Text('商品总数：').fontSize(14).layoutWeight(1)
          Text(`${this.totalCount} 件`).fontSize(14)
        }
        .width('100%')

        Row() {
          Text('实付金额：').fontSize(14).layoutWeight(1)
          Text(`¥${this.totalPrice}`)
            .fontSize(16)
            .fontColor('#F84D2C')
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .margin({ top: 6 })
      }
      .width('100%')
      .padding(15)
      .backgroundColor(Color.White)

      // 提交订单按钮
      Button('提交订单')
        .width('90%')
        .height(44)
        .margin(20)
        .backgroundColor('#F84D2C')
        .onClick(() => this.submitOrder())
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}