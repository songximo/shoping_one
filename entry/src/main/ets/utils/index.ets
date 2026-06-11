import { CartItemData } from "../models/CartDataItem"
import { Goods } from "../models/Goods"
export const KEY = 'cart_key'

//加入购物车的方法
export const addCart = (food:Goods| CartItemData)=>{
  //1.从AppStorage中获取购物车数据，如果没有购物车，就给一个空数组字符串 '[]'
  const json = AppStorage.Get<string>(KEY) || '[]'
  //2.将json字符串转换成CartItemData数组
  const  cartItemList = JSON.parse(json) as CartItemData[]
  //3.从购物车列表中获取对应添加的食品 两种可能：一种存在该食品，一种不存在
  const f = cartItemList.find(item=>item.id===food.id)
  if(f){//购物车中存在该食品
    f.count ++
  }else {//不存在该食品
    //3.1获取参数中food对应的属性值
    // const {id,name,price,discount,image} = food
    const id = food.id ?? 0; // 兜底：undefined 转 0
    const name = food.name;
    const price = food.price ?? 0;
    const discount = food.discount ?? 0; // ✅ 声明discount变量并兜底
    const image = food.image;
    // const  cartFood: CartItemData = {id,name,price,discount,image,count:1}
    const cartFood: CartItemData = {
      id: id,
      name: name,
      price: price,
      discount: discount,
      image: image,
      count: 1
    }
    //3.2将添加的商品放入到购物车商品数组中
    cartItemList.push(cartFood)
  }
  //4.将购物车重新放入到AppStorage中
  AppStorage.Set(KEY,JSON.stringify(cartItemList))
}

//删除购物车（通过购物车商品id从购物车删除商品）
export const delCart = (id:number)=>{
  //1.从AppStorage中获取购物车
  const json = AppStorage.Get<string>(KEY) || '[]'

  //2.将json字符串转换成CartItemData数组
  let cartItemList = JSON.parse(json) as CartItemData[]

  //3.从购物车列表中获取对应添加的食品 两种可能：一种存在该食品，一种不存在
  const f = cartItemList.find(item=>item.id===id)
  if (f && f.count>=1) {
    f.count --
    if(f.count==0){//如果count==0，就是删除该食品
      cartItemList = cartItemList.filter(item=>item!==f)
    }
  }

  //4.将购物车食品数组放入到AppStorage中
  AppStorage.Set(KEY,JSON.stringify(cartItemList))
}

//清空购物车
export const clearCart = ()=>{
  AppStorage.Set(KEY,'[]')
}