import { NavComp } from '../../component/yidiandian/NavComp';
import { ShowGoodsComp } from '../../component/yidiandian/ShowGoodsComp';
import { FooterComp } from '../../component/yidiandian/FooterComp'
import { CartComp } from '../../component/yidiandian/CartComp';
import { CartItemData } from '../../models/CartDataItem';
import { KEY } from '../../utils';
import { router } from '@kit.ArkUI';

PersistentStorage.PersistProp(KEY,'[]')//退出应用再次进入购物车内商品仍然存在
@Entry
@Component
struct YidiandianPage {
  @State showCart: boolean = false

  //从AppStorage中获取购物车数据
  @StorageProp(KEY)
  @Watch('onChangeCart') //监听购物车变化，如果有变化调用onChangeCart()
  cartItemListJson: string = '[]'

  @State cartItemList: CartItemData[] = JSON.parse(this.cartItemListJson)

  onChangeCart(){
    this.cartItemList = JSON.parse(this.cartItemListJson)
    if(this.cartItemList.length === 0){
      this.showCart = false
    }
  }

  build() {
    Row(){
      Stack({alignContent:Alignment.Bottom}){
        //导航和商品搜索
        Column(){
          Stack({alignContent:Alignment.Top}){
            //导航搜索
            NavComp()
            //商品展示
            ShowGoodsComp()
          }
        }.height('100%')

        // 返回按钮
        Row() {
          Row() {
            Image($r('app.media.ic_public_arrow_left'))
              .width(22).height(22)
          }
          .width(44).height(44)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            console.info("独立返回按钮被点击");
            router.back();
          })
        }
        .position({ x: 0, y: 0 })
        .width('100%')
        .height(44)  // 与顶部栏高度匹配

        if (this.showCart){
          //购物车组件
          // CartComp({cartItemList:$cartItemList,showCart:$showCart})
          CartComp({cartItemList:$cartItemList})
        }

        //底部组件
        FooterComp({showCart:$showCart,cartItemList:$cartItemList})
      }
    }
    .height('100%').layoutWeight(1)
  }
}
