import { router, promptAction } from '@kit.ArkUI';
import { Goods } from '../../models/Goods';
import { Shops } from '../../models/Shops';
import { loadFavorites, removeFavorite } from '../../utils/favoriteUtils';

@Entry
@Component
struct FavoritePage {
  @State favoriteList: Shops[] = [];

  aboutToAppear() {
    this.refreshList();
  }

  //页面每次显示时刷新列表
  onPageShow() {
    this.refreshList();
  }

  async refreshList() {
    this.favoriteList = await loadFavorites();
  }

  async removeItem(shop: Shops) {
    AlertDialog.show({
      title: '取消收藏',
      message: `确定要取消收藏“${shop.shangpu}”吗？`,
      primaryButton: { value: '取消', action: () => {} },
      secondaryButton: {
        value: '确定',
        fontColor: '#FF3B30',
        action: async () => {
          await removeFavorite(shop.shopid!);
          await this.refreshList();
          promptAction.showToast({ message: '已取消收藏' });
        }
      }
    });
  }

  @Builder
  ShopItemBuilder(shop: Shops) {
    Row({ space: 12 }) {
      Image(shop.image)
        .width(60)
        .height(60)
        .borderRadius(8)
      Column({ space: 4 }){
        Text(shop.shangpu).fontSize(15).fontWeight(FontWeight.Medium)
        Text(shop.remark).fontSize(12).fontWeight(FontWeight.Medium)
      }.layoutWeight(1).alignItems(HorizontalAlign.Start)

      Button('取消收藏')
        .fontSize(14)
        .backgroundColor(Color.Transparent)
        .fontColor('#FF3B30')
        .border({ width: 1, color: '#ccc' })
        .borderRadius(4)
        .padding({ left: 12, right: 12 })
        .onClick(() => this.removeItem(shop))
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 12 })
    .onClick(() => {
      if (shop.url) router.pushUrl({ url: shop.url });
    })
  }

  build() {
    Column() {
      // 顶部导航
      Row() {
        Image($r('app.media.ic_public_arrow_left'))
          .width(24).height(24)
          .onClick(() => router.back())
        Text('我的收藏')
          .fontSize(20).fontWeight(FontWeight.Bold)
          .layoutWeight(1).textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: 15, right: 15 })
      .backgroundColor(Color.White)

      Scroll() {
        Column() {
          if (this.favoriteList.length === 0) {
            Text('暂无收藏店铺')
              .fontSize(16)
              .fontColor('#999')
              .margin({ top: 50 })
              .width('100%')
              .textAlign(TextAlign.Center)
          } else {
            ForEach(this.favoriteList, (shop: Shops) => {
              this.ShopItemBuilder(shop)
            }
            , (shop: Shops) => shop.shopid?.toString() ?? `shop_${shop.shangpu ?? Math.random()}`)
          }
        }
        .padding(12)
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}