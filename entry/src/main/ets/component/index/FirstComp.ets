interface SwiperItem {
  id: number;
  imageUrl: Resource;
}

@Component
export struct FirstComp {

  @State swiperList: string[] = ['瑞幸咖啡','肯德基','霸王茶姬']
  build(){
    Column() {
      //1.定位信息
      Row(){
        Image($r('app.media.ic_public_gps')).width(18).aspectRatio(1)
        Text('电子科技大学成都学院').fontSize(18)
      }.margin({top:10,left:15}).width('100%')

      //2.搜索栏
      Row(){
        Stack({alignContent:Alignment.End}){
          Swiper(){
            //1.输入框
            ForEach(
              this.swiperList,
              (item:string)=>{
                TextInput({text:item}).width('85%')
                  .backgroundColor('#FFFFFF')
                  .height(40)
              }
            )
          }.autoPlay(true)//是否自动播放
          .loop(true)//是否循环
          .vertical(true)//是否纵向滑动
          .indicator(false)//是否显示导航顶
          .interval(5000)//间隔时间
          //2.按钮，总是在文本框上面
          Button('搜索')
            .fontColor(Color.Black)
            .width(80).margin(5).backgroundColor('#FAE35A')
            .height(30)
        }
        Image($r('app.media.ic_public_scan')).width(40).aspectRatio(1).fillColor('#363636')
      }.margin({top:10,left:15}).width('100%')

    }.width('100%')
    .height(95)
    .backgroundColor('#FAE35A')
  }

}