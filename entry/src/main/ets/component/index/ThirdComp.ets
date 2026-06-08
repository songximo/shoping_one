import { Goods, youxuanList } from "../../models/Goods"
@Component
export struct ThirdComp {

  @Link goodsList: Goods[]
  @Link tuangouGoods: Goods

  build() {
    GridRow({
      columns:2,
      direction: GridRowDirection.Row
    }){
      //优选
      GridCol(){
        Column({ space:5 }){
          Row({ space:5 }){
            Text('优选').fontSize(18).fontWeight(FontWeight.Bold)
            Text('明日达超市').fontSize(14).fontWeight(FontWeight.Bold)
              .backgroundColor('#EC7731')
              .fontColor('#FFFFFF')
          }.width('100%').margin({left:10,top:10})
          //takeawayListBuilder()
          GridRow({
            columns:2,
            gutter:{ x: 3},
            direction:GridRowDirection.Row
          }){
            ForEach(this.goodsList,(item:Goods) => {
              GridCol(){
                Column({space:5}){
                  Image(item.image)
                    .width(50).aspectRatio(1)
                  Row(){
                    Text(`￥ ${item.price}.`).fontColor('#EA442F').fontSize(16).margin({bottom:5})
                    Text('99').fontColor('#EA442F').fontSize(12)
                    // Text(item.remark).fontColor('#6B6B6B').fontSize(12).margin({left:5})
                  }.width('100%').justifyContent(FlexAlign.Center)
                }.height(90).width('100%')
              }
            })
          }.width('100%').height('100%')
        }.width('92%').height(210).backgroundColor('#FFFFFF')
        .margin({left:10}).borderRadius(10)

      }
      //特价团购
      GridCol(){
        Column({ space:5 }){
          Row({ space:5 }){
          Text('特价团购').fontSize(18).fontWeight(FontWeight.Bold)
          Text('天天有低价').fontSize(14).fontWeight(FontWeight.Bold)
            .backgroundColor('#ED7060')
            .fontColor('#FFFFFF')
        }.width('100%').margin({left:10,top:10})
        //takeAwayListBuilder()
        Column({ space:5 }){
          Image(this.tuangouGoods.image)
            .width('100%').height(120).borderRadius(10)
            .interpolation(ImageInterpolation.High)
          Text(this.tuangouGoods.content).fontSize(16)
          Row(){
            Text('￥').fontColor('#ED442F').fontSize(12).margin({left:10})
            Text(`${this.tuangouGoods.price}`).fontColor('#ED442F').fontSize(16).margin({left:5})
            Text(this.tuangouGoods.remark).fontSize('#6B6B6B').fontSize(12).margin({left:5})
          }.width('100%').justifyContent(FlexAlign.Center)
        }.layoutWeight(1).width('100%')

      }.width('100%').height(210).backgroundColor('#FFFFFF')
      .margin({right:10}).borderRadius(10)
    }
    }.width('100%').height(220).margin({top:10})
  }
}