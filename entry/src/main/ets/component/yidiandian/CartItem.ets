import { CartItemData } from "../../models/CartDataItem"
import { addCart, delCart } from "../../utils"
import { CalcBtn } from "../common/Calc"

@Component
export struct CartItem{

  @Prop cartItem: CartItemData

  build() {
    Row({space:15}){
      Image(this.cartItem.image)
        .width(60).aspectRatio(1).borderRadius(6)
      Column({space:15}){
        Text(this.cartItem.name).fontSize(18).fontWeight(600)
          .textOverflow({
            overflow:TextOverflow.Ellipsis
          })
          .maxLines(2)

        Row(){
          Row({space:3}){
            Text('￥'+this.cartItem.discount.toString()).fontSize(18).fontWeight(600).fontColor('#F84D2C')
            Text(this.cartItem.price.toString()).fontSize(10).fontColor('#999').decoration({type:TextDecorationType.LineThrough,color: '#999'})
          }
          Row({space:5}){
            CalcBtn({iconResource:$r('app.media.ic_screenshot_line'),isPlain:true})
              .onClick(()=>{
                delCart(this.cartItem.id)
              })
            Text(this.cartItem.count.toString()).fontSize(16)
            CalcBtn({iconResource:$r('app.media.ic_public_add_filled')})
              .onClick(()=>{
                addCart(this.cartItem)
              })
          }
        }.justifyContent(FlexAlign.SpaceBetween).width('100%')
      }.alignItems(HorizontalAlign.Start).layoutWeight(1)
    }.width('100%').padding({left:15,right:20}).alignItems(VerticalAlign.Top)
  }
}