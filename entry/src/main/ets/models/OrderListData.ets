
//订单不同状态
// models/OrderListData.ets
import preferences from '@ohos.data.preferences';
import { CartItemData } from './CartDataItem';
import { AddressInfo } from './AddressData';

export enum OrderStatus {
  PendingPayment = 0,   // 待付款
  PendingReceipt = 1,  // 待收货
  Completed = 2,        // 已完成
  Cancelled = 3         // 已取消
}

export class OrderInfo {
  id: string = '';
  orderId: string = '';
  createTime: number = 0;
  status: OrderStatus = OrderStatus.PendingPayment;
  totalPrice: number = 0;
  totalCount: number = 0;
  address: AddressInfo = new AddressInfo();
  items: CartItemData[] = [];

  constructor() {
    this.id = Date.now().toString() + Math.random().toString(36).slice(-6);
    this.orderId = this.id;
    this.createTime = Date.now();
  }
}

const STORAGE_KEY = 'order_list';

// 定义存储结构中 address 的接口
interface RawAddress {
  id?: string;
  name?: string;
  phone?: string;
  province?: string;
  city?: string;
  district?: string;
  detail?: string;
  isDefault?: boolean;
}

// 定义存储结构中商品的接口
interface RawOrderItem {
  id?: number;
  name?: string;
  image?: ResourceStr;
  price?: number;
  discount?: number;
  count?: number;
}

// 定义存储结构中订单的接口
interface RawOrder {
  id?: string;
  orderId?: string;
  createTime?: number;
  status?: OrderStatus;
  totalPrice?: number;
  totalCount?: number;
  address?: RawAddress;
  items?: RawOrderItem[];
}

// 加载所有订单
export async function loadOrders(): Promise<OrderInfo[]> {
  try {
    const pref = await preferences.getPreferences(getContext(), 'order_data');
    const value = await pref.get(STORAGE_KEY, '[]');
    const json = typeof value === 'string' ? value : JSON.stringify(value);
    const rawOrders = JSON.parse(json) as RawOrder[];
    const orders: OrderInfo[] = rawOrders.map(raw => {
      const order = new OrderInfo();
      order.id = raw.id ?? order.id;
      order.orderId = raw.orderId ?? order.orderId;
      order.createTime = raw.createTime ?? order.createTime;
      order.status = raw.status ?? OrderStatus.PendingPayment;
      order.totalPrice = raw.totalPrice ?? 0;
      order.totalCount = raw.totalCount ?? 0;

      // 恢复地址
      if (raw.address) {
        const addr = new AddressInfo();
        addr.id = raw.address.id ?? '';
        addr.name = raw.address.name ?? '';
        addr.phone = raw.address.phone ?? '';
        addr.province = raw.address.province ?? '';
        addr.city = raw.address.city ?? '';
        addr.district = raw.address.district ?? '';
        addr.detail = raw.address.detail ?? '';
        addr.isDefault = raw.address.isDefault ?? false;
        order.address = addr;
      } else {
        order.address = new AddressInfo();
      }

      // 恢复商品列表
      order.items = (raw.items ?? []).map(item => {
        const cartItem = new CartItemData();
        cartItem.id = item.id ?? 0;
        cartItem.name = item.name ?? '';
        cartItem.image = item.image ?? $r('app.media.icon');
        cartItem.price = item.price ?? 0;
        cartItem.discount = item.discount ?? 0;
        cartItem.count = item.count ?? 1;
        return cartItem;
      });
      return order;
    });
    orders.sort((a, b) => b.createTime - a.createTime);
    return orders;
  } catch (e) {
    console.error('加载订单失败', e);
    return [];
  }
}

// 保存订单列表
export async function saveOrders(orders: OrderInfo[]): Promise<void> {
  try {
    const pref = await preferences.getPreferences(getContext(), 'order_data');
    await pref.put(STORAGE_KEY, JSON.stringify(orders));
    await pref.flush();
  } catch (e) {
    console.error('保存订单失败', e);
  }
}

// 添加订单
export async function addOrder(order: OrderInfo): Promise<void> {
  const orders = await loadOrders();
  orders.unshift(order);
  await saveOrders(orders);
}

// 更新订单状态（注意：使用 order.id 作为唯一标识）
export async function updateOrderStatus(orderId: string, newStatus: OrderStatus): Promise<void> {
  const orders = await loadOrders();
  const index = orders.findIndex(o => o.id === orderId);
  if (index !== -1) {
    orders[index].status = newStatus;
    await saveOrders(orders);
  }
}

// 删除订单
export async function deleteOrder(orderId: string): Promise<void> {
  let orders = await loadOrders();
  orders = orders.filter(o => o.id !== orderId);
  await saveOrders(orders);
}



