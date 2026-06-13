
// 结算
//utils.ets
import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { CartItemData } from '../models/CartDataItem'
import { AddressInfo, loadAddresses } from '../models/AddressData'

export const KEY: string = 'cartList'
// 用AppStorage持久保存选中地址ID，不会页面切换丢失
const SELECT_ADDR_ID_KEY = 'select_address_id'

/** 加入购物车 */
export function addCart(goods: CartItemData) {
  let cartStr = AppStorage.get<string>(KEY) || '[]'
  let cartList: CartItemData[] = JSON.parse(cartStr)
  const index = cartList.findIndex(item => item.id === goods.id)
  if (index > -1) {
    cartList[index].count += 1
  } else {
    let newItem = new CartItemData();
    newItem.id = goods.id;
    newItem.name = goods.name;
    newItem.image = goods.image;
    newItem.price = goods.price;
    newItem.discount = goods.discount;
    newItem.count = 1;
    cartList.push(newItem);
  }
  AppStorage.setOrCreate(KEY, JSON.stringify(cartList))
}

/** 减少商品 */
export function delCart(id: number) {
  let cartStr = AppStorage.get<string>(KEY) || '[]'
  let cartList: CartItemData[] = JSON.parse(cartStr)
  const index = cartList.findIndex(item => item.id === id)
  if (index > -1) {
    if (cartList[index].count > 1) {
      cartList[index].count -= 1
    } else {
      cartList.splice(index, 1)
    }
  }
  AppStorage.setOrCreate(KEY, JSON.stringify(cartList))
}

/** 清空购物车 */
export function clearCart() {
  AppStorage.setOrCreate(KEY, '[]')
}

/** 计算总价 */
export function getTotalPrice(list: CartItemData[]): number {
  let total = 0
  list.forEach(item => {
    total += item.discount * item.count
  })
  return parseFloat(total.toFixed(2))
}

/** 计算总件数 */
export function getTotalCount(list: CartItemData[]): number {
  let count = 0
  list.forEach(item => count += item.count)
  return count
}

/** 结算跳订单页 */
export function goCheckout(totalPrice: number, totalCount: number, cartList: CartItemData[]) {
  if (totalCount <= 0) {
    promptAction.showDialog({ message: '购物车暂无商品' })
    return
  }
  router.pushUrl({
    url: 'pages/shops/OrderPage',
    params: {
      totalPrice: totalPrice,
      totalCount: totalCount,
      cartData: JSON.stringify(cartList)
    }
  })
}

//持久化存储选中地址ID
export function setSelectAddressId(id: string) {
  console.log('保存选中地址ID到AppStorage:', id)
  AppStorage.setOrCreate(SELECT_ADDR_ID_KEY, id)
}

export async function getSelectAddress(): Promise<AddressInfo | null> {
  const id = AppStorage.get<string>(SELECT_ADDR_ID_KEY)
  console.log('读取AppStorage选中ID:', id)
  if (!id) return null
  const list = await loadAddresses()
  const target = list.find(item => item.id === id)
  console.log('匹配到地址:', JSON.stringify(target))
  return target ?? null
}

/** 跳转到地址选择页 */
export function goSelectAddress() {
  router.pushUrl({ url: 'pages/my/AddressPage' })
}