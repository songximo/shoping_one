import { CartItemData } from "../../models/CartDataItem"
import { clearCart } from "../../utils"
import { CartItem } from "./CartItem"

@Component
export struct CartComp {

  @Link
  cartItemList: CartItemData[]

  // @Link
  // showCart: boolean


  //购物车 加入购物车 商品信息
  //id，price，image，count，discount

  //加入购物车
  //1.从AppStorage中获取购物车
  //2.将选择商品加入购物车中 如果有该商品则数量+1
  //3.将购物车保存到AppStorage中 并可以进行持久化

  //删除购物车中的商品
  //1.从AppStorage中获取购物车
  //2.从购物车中删除商品或商品数量-1 如果购物车商品数量为0 删除该商品
  //3.将购物车保存到AppStorage中 并可以进行持久化

  //清空购物车
  build() {
    Column(){
      Column(){
       Row(){
         Text('购物车').fontSize(14)
         Row({space:2}){
           Image($r('app.media.ic_public_delete'))
             .width(14).aspectRatio(1).fillColor('#999')
           Text('清空购物车').fontSize(14).fontColor('@999')
         }.onClick(()=>{
           clearCart()
           // this.showCart = false
         })
       }.width('100%').height(40).padding({left:15,right:15})
        .border({width:{bottom:0.5},color:'#e4e4e4'})
        .justifyContent(FlexAlign.SpaceBetween)
         //购物车列表
         List({space:15}){
           ForEach(
             this.cartItemList,
             (item:CartItemData)=>{
               ListItem(){
                 CartItem({cartItem:item})
               }
             }
           )
         }.divider({strokeWidth:0.5,color:'#e4e4e4',startMargin:100,endMargin:15})
        .margin({top:15})
       }.width('100%')
        .backgroundColor('#fff').padding({bottom:100})
        .borderRadius({topLeft:16,topRight:16})
    }.width('100%').height('100%').backgroundColor('rgba(0,0,0,0.5')
     .justifyContent(FlexAlign.End)
  }
}