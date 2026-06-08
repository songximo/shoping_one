@Entry
@Component
struct XichaPage {
  @State message: string = 'Hello World';

  build() {
    Row(){
      Stack({alignContent:Alignment.Bottom}){
        //导航和商品搜索
        Column(){
          Stack({alignContent:Alignment.Top}){
            //导航搜索
            // NavComp()
            //商品展示
            // ShowGoods()
          }
        }.height('100%')
        //底部组件
      }
    }
    .height('100%').width('100%').backgroundColor('red')
  }
}