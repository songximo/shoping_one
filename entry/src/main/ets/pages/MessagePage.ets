//1.4 消息右拉

import { Message, messageList } from '../models/MessageInfo'
import { Title } from '../component/message/Title'
import { MessageList } from '../component/message/MessageList'

@Entry
@Component
export struct MessagePage {

  @Link messageList: Message[]  //与MessageList.ets对应
  @Link noReadMsg: number
  @State filterText: string = ''
  // @State messageList: Message[] = messageList
  // @State noReadMsg: number = 0

  aboutToAppear(): void {
    this.noReadMsg = this.calculateNoRead()
  }
  calculateNoRead(): number {
    let count = 0
    this.messageList.forEach((item: Message) => {
      count += item.messageInfoList.filter(msg => msg.status == 1).length
    })
    return count
  }

  markAllAsRead(): void {
    this.messageList.forEach((item: Message, index: number) => {
      if (item.noReadNum > 0) {
        const msg: Message = new Message(
          item.category ?? 0,
          item.sender,
          item.image,
          [...item.messageInfoList]
        )
        msg.noReadNum = item.noReadNum ?? 0

        const newList = msg.messageInfoList.map(msgItem => {
          msgItem.status = 2
          return msgItem
        })
        msg.messageInfoList = newList
        msg.noReadNum = 0
        this.messageList[index] = msg
      }
    })
    this.noReadMsg = 0
  }

  build() {
    Column() {
      Title({
        noReadMsg: $noReadMsg,
        onMarkAllRead: () => {
          this.markAllAsRead()
        }
      })

      MessageList({
        // messageList: this.messageList,
        // noReadMsg: this.noReadMsg
        messageList: $messageList,
        noReadMsg: $noReadMsg
      })
    }
    .width('100%')
    .height('100%')
  }
}
