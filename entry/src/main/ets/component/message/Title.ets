//1.4 消息右拉

import { Prompt } from '@kit.ArkUI'
@Component
export struct Title {
  @Link noReadMsg: number
  onMarkAllRead: () => void = () => {}

  build() {
    Column() {
      Row({ space: 15 }) {
        Text() {
          Span('消息').fontSize(25).fontWeight(600)
          if (this.noReadMsg > 0) {
            Span(` (${this.noReadMsg})`).fontSize(15)
          }
        }

        Row() {
          Image($r('app.media.icon_message_read'))
            .width(15)
            .aspectRatio(1)
            .fillColor('#7D7D7D')
          Text('全部已读')
            .fontSize(15)
            .fontColor('#7b7b7b')
        }
        .alignItems(VerticalAlign.Bottom)
        .onClick(() => {
          this.onMarkAllRead()
        })

        Text('设置')
          .fontSize(15)
          .layoutWeight(1)
          .textAlign(TextAlign.End)
      }
      .width('100%')
      .padding({ top: 15, left: 15, right: 15 })
      .height(50)
      .backgroundColor('#f4f4f4')

      // 搜索栏
      Row() {
        Row() {
          Image($r('app.media.ic_public_input_search'))
            .width(24)
            .aspectRatio(1)
            .fillColor('#7b7b7b')
          Text('搜索')
            .fontSize(17)
            .fontColor('#7b7b7b')
        }
        .borderRadius(14)
        .backgroundColor('#FFFFFF')
        .width('100%')
        .height(33)
      }
      .width('100%')
      .height(55)
      .backgroundColor('#f4f4f4')
      .padding({ top: 8, left: 15, right: 15 })
    }
  }
}