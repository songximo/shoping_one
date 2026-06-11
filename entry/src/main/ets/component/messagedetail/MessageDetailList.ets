
import { MessageInfo } from '../../models/MessageInfo';

@Component
export struct MessageDetailList {
  @Prop messages: MessageInfo[] = [];

  build() {
    Column({ space: 12 }) {
      ForEach(this.messages, (info: MessageInfo, idx: number) => {
        Row() {
          // 对方头像（左边）
          if (!info.isSelf) {
            Image($r('app.media.icon'))
              .width(40).height(40).borderRadius(20)
              .margin({ right: 8 })
          }

          // 消息气泡区域
          Column({ space: 4 }) {
            // 只显示对方的发送者名称
            if (!info.isSelf) {
              Text(info.senderName)
                .fontSize(12).fontColor('#999999')
                .margin({ left: 4, bottom: 2 })
            }
            Column({ space: 2 }) {
              // 对方消息可能显示标题，自己消息不显示
              if (!info.isSelf && info.title) {
                Text(info.title)
                  .fontSize(14).fontWeight(FontWeight.Medium)
              }
              if (info.content) {
                Text(info.content)
                  .fontSize(14).fontColor('#333333')
              }
              Row() {
                Text(info.sendTime).fontSize(10).fontColor('#999999')
              }
              .width('100%')
            }
            .width('70%')
            .padding(10)
            .backgroundColor(info.isSelf ? '#DCF8C6' : '#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 2, color: '#DDDDDD' })
          }

          // 自己头像（右边）
          if (info.isSelf) {
            Image($r('app.media.yonghu'))
              .width(40).height(40).borderRadius(20)
              .margin({ left: 8 })
          }
        }
        .width('100%')
        .justifyContent(info.isSelf ? FlexAlign.End : FlexAlign.Start)
        .padding({ left: 12, right: 12, top: 4, bottom: 4 })
      }, (info: MessageInfo, idx: number) => idx.toString())
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .backgroundColor('#f5f5f5')
  }
}