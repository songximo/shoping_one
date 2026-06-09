@Component
export struct CalcBtn {
  //btn的图片
  iconResource: ResourceStr = ''
  //btn是否带背景颜色
  isPlain: boolean = false
  build() {
    Row(){
      Image(this.iconResource).width(10).aspectRatio(1)
    }.width(16).height(16).borderRadius(8).backgroundColor(this.isPlain?'#fff':'#FEDD00')
    .border(this.isPlain?{width:0.5,color:'FEDD00'}:{})
    .justifyContent(FlexAlign.Center)
  }
}