import { cert } from "@kit.DeviceCertificateKit"
import { Goods } from "../../models/Goods"
import { router } from "@kit.ArkUI"

@Component
export struct FourthComp{

  @Link goodsItemList: Goods[]

  build(){
    Row(){
      Flex({wrap:FlexWrap.Wrap,alignContent:FlexAlign.Center}){
        ForEach(
          this.goodsItemList,
          (item:Goods)=>{
            Column({ space:5 }){
              Image(item.image)
                .width('100%').height(120).borderRadius(10)
                .interpolation(ImageInterpolation.High)
              Text(item.shangpu).fontSize(16)
              Column(){
                Text(item.content).fontColor('#EA442F').fontSize(12).margin({left:5})
                Text(item.remark).fontColor('#6B6B6B').fontSize(12).margin({left:5})
              }.width('100%').justifyContent(FlexAlign.Start)
            }.width('44%').margin(10)
            .onClick(()=>{
              router.pushUrl({url:item.url})
            })
          }
        )
      }.width('100%')
    }.width('100%').height('100%')
  }
}