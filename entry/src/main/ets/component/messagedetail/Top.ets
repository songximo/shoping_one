import { router } from '@kit.ArkUI';

@Component
export struct Top {
  @Prop sender: string = '';

  build() {
    Row() {
      Image($r('app.media.ic_public_arrow_left'))
        .width(24)
        .height(24)
        .onClick(() => router.back())
      Text(this.sender)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
      Blank().width(24)
    }
    .width('100%')
    .height(50)
    .padding({ left: 12, right: 12, top: 12, bottom: 8 })
    .backgroundColor('#FAE35A')
  }

}

