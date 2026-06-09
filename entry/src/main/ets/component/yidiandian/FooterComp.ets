import { CartItemData } from "../../models/CartDataItem"

@Component
export struct FooterComp {
  @Link showCart: boolean

  @Link
  cartItemList: CartItemData[]

  // 声明状态变量存储总价
  @State totalPrice: number = 0

  // 计算总价的方法
  // private calcTotalPrice() {
  //   if (!this.cartItemList || this.cartItemList.length === 0) {
  //     this.totalPrice = 0;
  //     return;
  //   }
  //   const totalFen = this.cartItemList.reduce((prev, curr) => {
  //     const price = curr.discount ?? curr.price ?? 0;
  //     const count = curr.count ?? 0;
  //     return prev + Math.round(price * 100) * count;
  //   }, 0);
  //   this.totalPrice = totalFen / 100;
  // }
  // // 组件初始化时计算
  // aboutToAppear() {
  //   this.calcTotalPrice();
  // }

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
            // 修复：整数规避浮点精度问题 + 固定2位小数展示
            // Text(this.totalPrice.toFixed(2))
            //   .fontSize(20).fontColor('#FFFFFF')
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