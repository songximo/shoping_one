
import preferences from '@ohos.data.preferences';

export class AddressInfo {
  id: string = Date.now().toString() + Math.random().toString(36).slice(-6);
  name: string = '';      // 收货人姓名
  phone: string = '';     // 联系电话
  province: string = '';  // 省
  city: string = '';      // 市
  district: string = '';  // 区
  detail: string = '';    // 详细地址
  isDefault: boolean = false;

  get fullAddress(): string {
    return `${this.province}${this.city}${this.district}${this.detail}`;
  }
}

const STORAGE_KEY = 'address_list';

// 加载地址列表
export async function loadAddresses(): Promise<AddressInfo[]> {
  try {
    const pref = await preferences.getPreferences(getContext(), 'address_data');
    const value = await pref.get(STORAGE_KEY, '[]');
    const json = typeof value === 'string' ? value : JSON.stringify(value);
    return JSON.parse(json) as AddressInfo[];
  } catch (e) {
    console.error('加载地址失败', e);
    return [];
  }
}

// 保存地址列表
export async function saveAddresses(addresses: AddressInfo[]): Promise<void> {
  try {
    const pref = await preferences.getPreferences(getContext(), 'address_data');
    await pref.put(STORAGE_KEY, JSON.stringify(addresses));
    await pref.flush();
  } catch (e) {
    console.error('保存地址失败', e);
  }
}

// 添加地址
export async function addAddress(address: AddressInfo): Promise<void> {
  const list = await loadAddresses();
  list.push(address);
  await saveAddresses(list);
}

// 删除地址（根据 id）
export async function deleteAddress(id: string): Promise<void> {
  let list = await loadAddresses();
  list = list.filter(addr => addr.id !== id);
  await saveAddresses(list);
}

export async function updateAddress(updated: AddressInfo): Promise<void> {
  let list = await loadAddresses();
  const index = list.findIndex(addr => addr.id === updated.id);
  if (index === -1) return;

  if (updated.isDefault) {
    // 如果更新为默认地址，则先将列表中其他所有地址的默认标记取消
    list = list.map(addr => {
      if (addr.id !== updated.id) {
        addr.isDefault = false;
      }
      return addr;
    });
  }
  list[index] = updated;
  await saveAddresses(list);
}

