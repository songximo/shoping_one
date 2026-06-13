
// 结算
// FooterComp.ets
import { CartItemData } from '../../models/CartDataItem'
import { getTotalCount, getTotalPrice, goCheckout } from '../../utils'

@Component
export struct FooterComp {
  @Link showCart: boolean
  @Link cartItemList: CartItemData[]

  build() {
    Row() {
      // 左侧购物车图标 + 角标
      Badge({
        value: getTotalCount(this.cartItemList).toString(),
        position: BadgePosition.Right,
        style: { badgeSize: 12 }
      }) {
        Image(this.cartItemList.length == 0 ? $r('app.media.icon_waimai_nogoods') : $r('app.media.icon_waimai0'))
          .width(40).height(40)
          .onClick(() => {
            this.showCart = !this.showCart
          })
      }
      .margin({ left: 20 })

      // 合计价格
      Column() {
        Row(){
          Text('合计')
            .fontSize(12)
            .fontColor('#666')
          Text(`¥${getTotalPrice(this.cartItemList)}`)
            .fontSize(16)
            .fontColor('#F84D2C')
            .fontWeight(FontWeight.Bold)
        }
        Text('免配送费')
          .fontSize(12)
          .fontColor('#FFFFFF')
      }
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 10 })
      .layoutWeight(1)


      // 右侧去结算按钮
      Row() {
        Text('去结算')
          .fontSize(18)
      }
      .backgroundColor(this.cartItemList.length == 0 ? '#999' : '#FFE546')
      .height('100%')
      .width(80)
      .borderRadius({ topRight: 25, bottomRight: 25 })
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        let total = getTotalPrice(this.cartItemList)
        let count = getTotalCount(this.cartItemList)
        goCheckout(total, count, this.cartItemList)
      })
    }
    .height(50)
    .width('100%')
    .backgroundColor(Color.Black)
    .borderRadius(25)
    .padding({ left: 0, right: 0 })  // 保持紧凑
    .margin({ top: 0, bottom: 0 })
  }
}

