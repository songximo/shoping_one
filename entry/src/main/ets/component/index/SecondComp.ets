import { TakeawayItem, takeawayList,secondtakeawayList } from "../../models/TakeawayItem"

@Component
export struct SecondComp{

  @State takeawayList: TakeawayItem[] = takeawayList

  @State secondTakeawayList: TakeawayItem[][] = secondtakeawayList

  @Builder
  takeawayItemBuilder(takeawayList:TakeawayItem[]){
    GridRow({
      columns:5,//一行几个
      gutter:{x:5,y:10},
      direction: GridRowDirection.Row
    }){
      //循环数组
      ForEach(
        takeawayList,
        (item:TakeawayItem)=>{
          GridCol(){
            Column(){
              Image(item.itemImage).width(40).height(50).interpolation(ImageInterpolation.High)
              Text(item.itemName).fontSize(14)
            }.height(60)
          }
        }
      )

    }.width('100%')
    .height(150)
  }



  build() {
    Column() {
      //外卖专区
      Column(){
      Column(){
        Row(){
          Image($r('app.media.waimai1')).width(110).interpolation(ImageInterpolation.High)
            .borderRadius({topLeft:10})
          Text('最快30分钟送达').fontSize(16)
        }.width('100%').margin({bottom:8})
        this.takeawayItemBuilder(this.takeawayList)
      }.width('95%').height(135).margin(5).backgroundColor('#FFFFFF')
      .borderRadius(10).justifyContent(FlexAlign.Start)
    }.width('100%').height(150).backgroundColor('#FAE35A')
      //跑马灯图表
      Swiper(){
        ForEach(
          this.secondTakeawayList,
          (item: TakeawayItem[])=>{
            this.takeawayItemBuilder(item)
          }
        )
      }.loop(false)
      .borderRadius(10)
      .width('95%').height(180).margin({left:5,right:5}).backgroundColor('#FFFFFF')
      .padding({top:5})
      // .indicatorStyle({color:Color.White,selectedColor:Color.Yellow})//换页图标颜色
    }.height(320)
    .width('100%')
    // .background('red')

  }
}