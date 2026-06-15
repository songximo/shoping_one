// import { FavoriteShop } from "../../models/FavoriteShop";
import { isFavorite, toggleFavorite } from "../../utils/favoriteUtils";
import { promptAction, router } from "@kit.ArkUI";
import { Goods } from "../../models/Goods";
import { Shops} from "../../models/Shops"

@Component
export struct NavComp{
  @Consume currentShop: Shops;  // 从父组件注入
  @State isFav: boolean = false;

  aboutToAppear() {
    this.checkFavorite();
  }

  async checkFavorite() {
    // this.isFav = await isFavorite(this.currentShop.id);
    if (!this.currentShop.shopid) return;
    this.isFav = await isFavorite(this.currentShop.shopid);
  }

  async toggleFavorite() {
    if (!this.currentShop.shopid) return;
    const newState = await toggleFavorite(this.currentShop);
    this.isFav = newState;
    promptAction.showToast({
      message: this.isFav ? '已收藏' : '已取消收藏'
    });
  }

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
      // 返回和搜索
      Row(){
        // 返回按钮
        Row() {
          Image($r('app.media.ic_public_arrow_left'))
            .width(22).height(22)
        }
        .width(44).height(44)   //点击区域
        .justifyContent(FlexAlign.Center)
        .onClick(() => router.back())

        //搜索按钮
        Row({space:10}){
          Image($r('app.media.ic_public_input_search')).width(22).aspectRatio(1)
            .fillColor('#666666')
          Text('请输入商品名').fontSize(16).fontColor('#666666')
        }.height(30).backgroundColor('#F5F5F6').width(200).borderRadius(22)
        .margin({left:10})

        Row({space:15}){
          Image($r('app.media.zaixianlianxi'))
            .width(22).aspectRatio(1).fillColor('#575757')
          Image(this.isFav ? $r('app.media.guanzhu_selected') : $r('app.media.guanzhu'))
            .width(22).aspectRatio(1).fillColor('#575757')
            .onClick(() => this.toggleFavorite())
          Image($r('app.media.more'))
            .width(22).aspectRatio(1).fillColor('#575757')
        }.layoutWeight(1)  //占据剩余宽度
        .height(26).justifyContent(FlexAlign.End)
      }.justifyContent(FlexAlign.Center).width('100%')

      Row({space:10}){
        this.navItemBuilder(true,'点单')
        this.navItemBuilder(false,'评价','1399')
        this.navItemBuilder(false,'商家','地址')
      }.width('100%').height(40).border({color:'#e4e4e4',width:{bottom:0.5}}).margin({top:10})
    }
    .width('100%')
    .height(40)
    .backgroundColor('#ffffff')
    .padding(15)
  }
}
