
import preferences from '@ohos.data.preferences';
import { Shops } from '../models/Shops';

const FAVORITE_KEY = 'favorite_shops';

// 加载收藏列表
export async function loadFavorites(): Promise<Shops[]> {
  try {
    const pref = await preferences.getPreferences(getContext(), 'favorite_data');
    const value = await pref.get(FAVORITE_KEY, '[]');
    const json = typeof value === 'string' ? value : JSON.stringify(value);
    return JSON.parse(json) as Shops[];
  } catch (e) {
    console.error('加载收藏失败', e);
    return [];
  }
}

// 保存收藏列表
async function saveFavorites(shops: Shops[]): Promise<void> {
  try {
    const pref = await preferences.getPreferences(getContext(), 'favorite_data');
    await pref.put(FAVORITE_KEY, JSON.stringify(shops));
    await pref.flush();
  } catch (e) {
    console.error('保存收藏失败', e);
  }
}

// 添加收藏
export async function addFavorite(shop: Shops): Promise<void> {
  const list = await loadFavorites();
  if (!list.some(s => s.shopid === shop.shopid)) {
    list.push(shop);
    await saveFavorites(list);
  }
}

// 移除收藏
export async function removeFavorite(shopid: number): Promise<void> {
  let list = await loadFavorites();
  list = list.filter(s => s.shopid !== shopid);
  await saveFavorites(list);
}

// 检查是否已收藏
export async function isFavorite(shopid: number): Promise<boolean> {
  const list = await loadFavorites();
  return list.some(s => s.shopid === shopid);
}

// 切换收藏状态
export async function toggleFavorite(shop: Shops): Promise<boolean> {
  const exists = await isFavorite(shop.shopid!);
  if (exists) {
    await removeFavorite(shop.shopid!);
    return false;
  } else {
    await addFavorite(shop);
    return true;
  }
}
