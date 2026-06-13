
// 结算
// ShowGoodsComp.ets
import { Category,categoryList } from "../../models/Category"
import { promptAction } from "@kit.ArkUI"
import { Goods } from "../../models/Goods"
import { CalcBtn } from "../common/Calc"
import { addCart } from "../../utils"
import { CartItemData } from "../../models/CartDataItem"

@Component
export struct ShowGoodsComp {

  categoryList: Category[] = categoryList

  @State
  menuSelectedIndex:number = 0

  @Builder
  goodsBuilder(item:Goods){
    Row(){
      Column(){
        Image(item.image).width(100).aspectRatio(1).borderRadius(6)
      }.height('100%').justifyContent(FlexAlign.Start).margin({left:10,right:10})

      Column({space:3}){
        Text(item.name).fontSize(500)
          .fontSize(16).fontWeight(500)
          .textOverflow({overflow:TextOverflow.Ellipsis})
          .maxLines(2)
        Row(){
          Text(item.remark).fontSize(10).fontColor('#FF8000').backgroundColor('#FFFFFF')
          // Image($r('app.media.ic_public_arrow_right')).width(12).aspectRatio(1).fillColor('#FF8000')
        }
        Text(`月售 ${item.month_sale}`).fontSize(10).fontColor('#858687')
        if(item.zhekou){
          Row(){
            Text(item.zhekou).fontColor('#F84D2C').fontSize(10)
          }.width(90).height(20).borderRadius(8).border({color:'red'})
        }
        Row(){
          Text(){
            Span('￥').fontSize(10).fontWeight(400).fontColor('#F84D2C')
            Span(item.discount?.toString()).fontWeight(600).fontSize(16)
              .fontColor('#F84D2C')
            // Span('.9').fontSize(10).fontWeight(400).fontColor('#F84D2C').margin({left:5})
            Span(` ￥${item.price} `).fontSize(10).decoration({type:TextDecorationType.LineThrough,color:'#858687'})
              .fontColor('#858687').margin({left:10})
          }
          CalcBtn({iconResource:$r('app.media.ic_public_add_filled')})
            .onClick(()=>{
              let cartItem = new CartItemData();
              cartItem.id = item.id ?? 0;
              cartItem.name = item.name ?? '';
              cartItem.image = item.image ?? '';
              cartItem.price = item.price ?? 0;
              cartItem.discount = item.discount ?? 0;
              addCart(cartItem);
              promptAction.showToast({message:'加入购物车成功'})
            })


        }.width('100%').justifyContent(FlexAlign.SpaceBetween)
        if(item.daoshou){
          Row(){
            Text('到手预估').fontSize(10).fontColor('#F84D2C')
            Row(){
              Text(`￥ ${item.discount}`).fontSize(10).fontColor('#fff')
            }.backgroundColor('#FF691B').height(20).width(50)
            .borderRadius({topRight:25,bottomRight:25})
            .justifyContent(FlexAlign.Center)
          }.width(90).height(20).backgroundColor('FFF4F3').padding(5).borderRadius({topRight:25,bottomRight:25})
          .justifyContent(FlexAlign.SpaceBetween)
        }

      }.layoutWeight(1).height('100%')
      .alignItems(HorizontalAlign.Start)
    }.width('100%').height(130).backgroundColor('#fff')
    .alignItems(VerticalAlign.Top)
  }

  build() {
    Row(){
      //左侧菜单
      Column(){
        ForEach(
          this.categoryList,
          (item:Category,index:number)=>{
            Text(item.name).fontSize(14).fontWeight(600)
              .width('100%').height(50)
              .textAlign(TextAlign.Center)
              .backgroundColor(this.menuSelectedIndex==index?'#FFFFFF':'transparent')
              .borderRadius(this.menuSelectedIndex==index?0:8)
              .onClick(()=>{
                this.menuSelectedIndex = index
                promptAction.showToast({message:this.menuSelectedIndex+''})
              })
          }
          ,(item: Category) => item.id.toString()  // ✅ 添加 key
        )
      }.width(90).height('100%').margin({left:10}).backgroundColor('#e4e4e4')
      .justifyContent(FlexAlign.Start)
      //右侧商品展示
      List(){
        ListItem(){
          Text(this.categoryList[this.menuSelectedIndex].name)
            .fontSize(16).fontWeight(500)
        }.margin(10)
        ForEach(
          this.categoryList[this.menuSelectedIndex].foods,
          (item:Goods)=>{
            ListItem(){
              this.goodsBuilder(item)
            }
          }
          ,(item: Goods) => item.id?.toString() ?? item.name   // ✅ 添加 key
        )
      }.height('100%').layoutWeight(1)
    }.width('100%').layoutWeight(1).padding({top:95,bottom:40,right:10})
  }
}

