import { CartItemData } from "../../models/CartDataItem"

@Component
export struct FooterComp {
  @Link showCart: boolean

  @Link
  cartItemList: CartItemData[]

  build() {
    Row(){
      Row(){
        Badge({
          value: this.cartItemList.length+'',
          position: BadgePosition.Right,
          style:{
            badgeSize:12
          }
        }){
          Image(this.cartItemList.length==0?$r('app.media.icon_waimai_nogoods'):$r('app.media.icon_waimai0'))
            .width(40).height(40)
            // .margin({left:5})
            // .position({y:-15.9})
            .onClick(()=>{
              this.showCart = !this.showCart
            })
        }.margin({left:20})
        Column(){
          Row({space:5}){
            Text(this.cartItemList.reduce((p,c)=>p+c.discount*c.count,0).toString()).fontSize(20).fontColor('#FFFFFF')
            Text('券后约￥10').fontSize(12)
              .fontColor(this.cartItemList.length==0?'#999':'#FFDD00')
            Image($r('app.media.ic_public_arrow_up_0')).width(12).fillColor(Color.Red)
          }
          Text('免配送费').fontSize(12).fontColor('#FFFFFF')
        }.alignItems(HorizontalAlign.Start).padding({left:10}).layoutWeight(1)
        Row(){
          Text('去结算').fontSize(18)
        }
        .backgroundColor(this.cartItemList.length==0?'#999':'#FFE546')
        .height('100%').width(80)
        .borderRadius({topRight:25,bottomRight:25})
        .justifyContent(FlexAlign.Center)
      }.height(50)
      .width('100%')
      .backgroundColor(Color.Black)
      .borderRadius(25)
    }.width('100%').height(85).padding(15)
  }
}