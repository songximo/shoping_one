//动态查找资源
// utils/ImageMapper.ets
import { shopList } from '../models/Shops';

export function getImageResource(name: string): ResourceStr {
  console.info('getImageResource 输入 name:', name);
  // 在店铺列表中查找匹配的 image 字符串
  // const shop = shopList.find(s => s.image === name);

  // ✅ 通过 imageName 匹配（字符串）
  const shop = shopList.find(s => s.imageName === name);
  if (shop && shop.image) {
    console.info('匹配到店铺:', shop.shangpu, shop.image);
    return shop.image;
  }
  // 针对非店铺消息（如系统消息）的图标映射，可以单独处理或返回默认图标
  // 例如：互动消息、优惠福利等
  switch (name) {
    case 'app.media.ic_huodong': return $r('app.media.ic_huodong');
    case 'app.media.ic_youhuifuli': return $r('app.media.ic_youhuifuli');
    default: return $r('app.media.icon');
  }
}

