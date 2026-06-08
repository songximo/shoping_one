import { FirstComp } from "../component/index/FirstComp";
import { SecondComp } from "../component/index/SecondComp";
import { ThirdComp } from "../component/index/ThirdComp";
import { Goods, goodsItem1, goodsItem2, youxuanList, youxuanList1 } from "../models/Goods";
import { FourthComp } from "../component/index/FourthComp";
import { promptAction } from "@kit.ArkUI";

@Entry
@Component
export struct Index {

  @State isRefreshing: boolean = false

  @State goodsItemList: Goods[] = goodsItem1
  @State goodsItemList2: Goods[] = goodsItem2

  @State youxuanList1: Goods[] = youxuanList1

  @State goodsList: Goods[] = youxuanList

  @State tuangouGoods: Goods = {
    name: 'huoguo',
    image: $r('app.media.huoguo'),
    content: '[特惠双人餐]',
    price:78.8,
    remark: '5.9折'
  }

  build() {
    Refresh({refreshing:$$this.isRefreshing,offset:30,friction:70}){
      Stack({alignContent:Alignment.Top}){
        List(){
          ListItem(){
            Column(){
              //2.分类信息图标栏
              SecondComp()
              //3.优选推荐
              ThirdComp({goodsList:$goodsList,tuangouGoods:$tuangouGoods})
              //4.推荐商品商铺展示
              FourthComp({goodsItemList:$goodsItemList})
            }
          }
        }
        .height('100%')
        .width('100%')
        .margin({top:90})
        .onReachEnd(()=>{
          this.goodsItemList = [...this.goodsItemList,...this.goodsItemList2]
          promptAction.showToast({message:'上拉加载'+this.goodsItemList.length})
        })
        //1.定位消息和搜索栏
        FirstComp()
      }
    }.onStateChange((status:RefreshStatus)=>{
      if(status==RefreshStatus.Refresh){
        this.goodsList = youxuanList1
        this.tuangouGoods = {
          name: 'mixue',
          image: $r('app.media.mixue1'),
          content: '蜜雪冰城 柠檬水',
          price: 1.9,
          remark: '3.8折'
        }
        //刷新完成后，结束刷新状态
        this.isRefreshing = false
      }
    })
  }
}