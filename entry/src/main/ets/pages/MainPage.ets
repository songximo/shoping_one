import { TabbarItem, tabbarItemList } from '../models/TabbarItem'
import { promptAction } from '@kit.ArkUI'
import { Index } from './Index'

@Entry
@Component
struct MainPage {

  //使用Tabs控制页面跳转
  @State selectIndex: number = 0
  controller: TabsController = new TabsController()
  @State tabbarItemList: TabbarItem[] = tabbarItemList



  build() {
    Tabs({barPosition:BarPosition.End,index:this.selectIndex,controller:this.controller}){
      TabContent(){
        //点击页签显示的内容
        Index()
      }.tabBar(this.tabbarBuilder(this.tabbarItemList[0],0))//TabContent的样式和内容
      TabContent(){
        //点击页签显示的内容
        Text('优选')
      }.tabBar(this.tabbarBuilder(this.tabbarItemList[1],1))
      TabContent(){
        //点击页签显示的内容
        Text('消息')
      }.tabBar(this.tabbarBuilder(this.tabbarItemList[2],2))
      TabContent(){
        //点击页签显示的内容
        Text('我的')
      }.tabBar(this.tabbarBuilder(this.tabbarItemList[3],3))
    }.onChange((index: number)=>{
      this.selectIndex = index
      promptAction.showToast({message:"当前页面为："+index})
    })
  }

  @Builder
  tabbarBuilder(item:TabbarItem,index:number){
    Column(){
      if(index!=0 || this.selectIndex != index){
        Image(this.selectIndex==index?item.icon_selected:item.icon_normal).width(28).aspectRatio(1).margin({top:5,bottom:1})
        Text(item.title).width('100%').height(14).fontSize(10).fontWeight(500)
          .textAlign(TextAlign.Center)
          .margin({bottom:7})
      }else{
        Image(item.icon_selected).width(35).aspectRatio(1).margin({top:5,bottom:1})
      }


    }
  }

}