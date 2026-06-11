import { router } from "@kit.ArkUI"

@Component
export struct NavComp{

  @Builder
  navItemBuilder(isSelected:boolean,title:string,subTitle:string = ''){
    Column(){
      Text(){
        Span(title).fontSize(16).fontWeight(isSelected?600:300)
          .fontColor(isSelected?'#000':'#999')
        if(subTitle){
          Span(subTitle).fontSize(12).fontColor(isSelected?'#000':'#999')
        }
      }.layoutWeight(1)
      Text()
        .width(20)
        .height(3).backgroundColor(isSelected?'#FFDD00':'transparent')
        .margin(5)
    }
  }

  build() {
   Column({space:10}){
     //返回和搜索
     Row(){
       Image($r('app.media.ic_public_arrow_left')).width(22).aspectRatio(1)
         .onClick(() => router.back())
       Row({space:10}){
         Image($r('app.media.ic_public_input_search')).width(22).aspectRatio(1)
         .fillColor('#666666')
       Text('请输入商品名').fontSize(16).fontColor('#666666')
       }.height(30).backgroundColor('#F5F5F6').width(200).borderRadius(22)
       Row({space:15}){
         Image($r('app.media.zaixianlianxi'))
           .width(22).aspectRatio(1).fillColor('#575757')
         Image($r('app.media.guanzhu'))
           .width(22).aspectRatio(1).fillColor('#575757')
         Image($r('app.media.more'))
           .width(22).aspectRatio(1).fillColor('#575757')
         // Badge({count:5,position:BadgePosition.RightTop,style:{badgeSize:122}}){
         //   Image($r('app.media.more')).width(22).aspectRatio(1).fillColor('#575757')
         // }
       }.layoutWeight(1).height(26).justifyContent(FlexAlign.End)
     }.justifyContent(FlexAlign.Center)
     Row({space:10}){
       this.navItemBuilder(true,'点单')
       this.navItemBuilder(false,'评价','1399')
       this.navItemBuilder(false,'商家','地址')
     }.width('100%').height(40).border({color:'#e4e4e4',width:{bottom:0.5}}).margin({top:5})
   } .width('100%').height(40).backgroundColor('#ffffff').padding(15)
  }
}