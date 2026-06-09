import { NavComp } from '../../component/yidiandian/NavComp';
import { ShowGoodsComp } from '../../component/yidiandian/ShowGoodsComp';
import { FooterComp } from '../../component/yidiandian/FooterComp'
import { CartComp } from '../../component/yidiandian/CartComp';
import { CartItemData } from '../../models/CartDataItem';
import { KEY } from '../../utils';

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


