import { UserProfileModule } from '../component/my/UserProfileModule';
import { QuickAccessModule } from '../component/my/QuickAccessModule';
import { CommonServicesModule } from '../component/my/CommonServicesModule';

@Component
export struct MyPage {
  @Provide('appPathStack') appPathStack: NavPathStack = new NavPathStack();

  private scroller: Scroller = new Scroller();

  build() {
    Scroll(this.scroller) {
      Column() {
        UserProfileModule()
        QuickAccessModule()
        CommonServicesModule()
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
    .height("100%")
    .width('100%')
    .align(Alignment.Top)
    // .backgroundColor('#FAE35A')
  }
}

