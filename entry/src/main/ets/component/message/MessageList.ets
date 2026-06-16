
//1.4右拉操作
//MessageList.ets
import { Message, MessageInfo, messageList } from '../../models/MessageInfo'
import { router } from '@kit.ArkUI'
import { getImageResource } from '../../utils/imageMapper'
import { shopList } from '../../models/Shops'


//显示月日时间
function formatDisplayTime(timeStr: string): string {
  if (timeStr.includes('-') || timeStr.includes('/')) {
    // 尝试解析完整日期时间字符串 "YYYY-MM-DD HH:MM" 或 "YYYY/MM/DD HH:MM"
    let date: Date;
    if (timeStr.includes('/')) {
      const parts = timeStr.split(' ');
      const datePart = parts[0].replace(/\//g, '-');
      const timePart = parts[1];
      date = new Date(`${datePart}T${timePart}:00`);
    } else {
      date = new Date(timeStr.replace(' ', 'T') + ':00');
    }
    if (!isNaN(date.getTime())) {
      const month = (date.getMonth() + 1).toString().padStart(2, '0');
      const day = date.getDate().toString().padStart(2, '0');
      const hours = date.getHours().toString().padStart(2, '0');
      const minutes = date.getMinutes().toString().padStart(2, '0');
      return `${month}/${day} ${hours}:${minutes}`;
    }
  }
  // 如果只有 "HH:MM" 格式，原样返回
  return timeStr;
}

@Component
export struct MessageList {
  @Link messageList: Message[]  //与MessagePage.ets对应
  @Link noReadMsg: number
  // @State messageList: Message[] = messageList
  // @State noReadMsg: number = 0

  // 重新计算总未读消息数（所有会话中 status==1 的 MessageInfo 数量）
  private updateTotalUnread(): void {
    let total = 0
    for (const msg of this.messageList) {
      total += msg.messageInfoList.filter(info => info.status === 1).length
    }
    this.noReadMsg = total
  }

  // 检查当前会话是否有未读消息（必须存在）
  private hasUnread(item: Message): boolean {
    return item.messageInfoList.some(info => info.status === 1)
  }

  // 将整个会话标记为已读（所有 MessageInfo.status = 2）
  private markAsRead(item: Message): void {
    // 深拷贝并修改当前会话的所有消息状态为已读
    const newInfoList = item.messageInfoList.map(info => {
      const newInfo = new MessageInfo()
      newInfo.title = info.title
      newInfo.content = info.content
      newInfo.sendTime = info.sendTime
      newInfo.status = 2
      return newInfo
    })

    const index = this.messageList.findIndex(msg => msg.id === item.id)
    if (index !== -1) {
      const updatedMsg = new Message(
        item.category ?? 0,
        item.sender,
        item.image,
        newInfoList
      )
      updatedMsg.id = item.id
      updatedMsg.url = item.url;
      this.messageList[index] = updatedMsg
      this.updateTotalUnread()
    }
  }
  // 将整个会话标记为未读：只将最新的一条消息设为未读，其余设为已读，确保未读数为1
  private markAsUnread(item: Message): void {
    const len = item.messageInfoList.length
    const newInfoList = item.messageInfoList.map((info, idx) => {
      const newInfo = new MessageInfo()
      newInfo.title = info.title
      newInfo.content = info.content
      newInfo.sendTime = info.sendTime
      // 最后一条（最新）设为未读，其余设为已读
      newInfo.status = (idx === len - 1) ? 1 : 2
      return newInfo
    })
    const index = this.messageList.findIndex(msg => msg.id === item.id)
    if (index !== -1) {
      const updatedMsg = new Message(
        item.category ?? 0,
        item.sender,
        item.image,
        newInfoList
      )
      updatedMsg.id = item.id
      updatedMsg.url = item.url;
      this.messageList[index] = updatedMsg
      this.updateTotalUnread()
    }
  }

  // 删除整个会话
  private deleteItem(item: Message): void {
    const index = this.messageList.findIndex(msg => msg.id === item.id)
    if (index !== -1) {
      this.messageList.splice(index, 1)
      this.updateTotalUnread()
    }
  }

  // 辅助方法：根据消息会话获取头像资源
  private getAvatarRes(item: Message): ResourceStr {
    // 优先根据商家名称从 shopList 中查找图标
    const shop = shopList.find(s => s.shangpu === item.sender);
    if (shop) {
      return shop.image;
    }
    // 系统消息等使用 imageName 映射
    return getImageResource(item.imageName);
  }


  // 右滑菜单构建器
  @Builder
  SwipeMenuBuilder(item: Message) {
    Row() {
      // 标为已读按钮
      Button() {
        Column() {
          Text('已读').fontSize(12).fontColor(Color.White)
        }
      }
      .type(ButtonType.Normal)
      .backgroundColor('#007AFF')
      .width(70)
      .height('100%')
      .onClick(() => {
        this.markAsRead(item)
      })

      // 标为未读按钮
      Button() {
        Column() {
          Text('未读').fontSize(12).fontColor(Color.White)
        }
      }
      .type(ButtonType.Normal)
      .backgroundColor('#FF9500')
      .width(70)
      .height('100%')
      .onClick(() => {
        this.markAsUnread(item)
      })

      // 删除按钮
      Button() {
        Column() {
          Text('删除').fontSize(12).fontColor(Color.White)
        }
      }
      .type(ButtonType.Normal)
      .backgroundColor('#FF3B30')
      .width(70)
      .height('100%')
      .onClick(() => {
        this.deleteItem(item)
      })
    }
    .height('100%')
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      List({ space: 25 }) {
        ForEach(
          this.messageList,
          (item: Message) => {
            ListItem() {
              // 原有的消息行布局
              Row({ space: 10 }) {
                Row({ space: 10 }) {
                  // 头像和未读角标
                  if (item.messageInfoList.filter(info => info.status == 1).length > 0) {
                    Badge({
                      value: item.messageInfoList.filter(info => info.status == 1).length + '',
                      position: BadgePosition.RightTop,
                      style: { badgeSize: 15 }
                    }) {
                      Image(this.getAvatarRes(item))
                        .width(50).aspectRatio(1).borderRadius(8)
                    }
                    .width(55).height(55).margin({ bottom: 4 })
                  } else {
                    Image(this.getAvatarRes(item))
                      .width(50).aspectRatio(1).borderRadius(8)
                  }

                  // 消息内容
                  Column({ space: 5 }) {
                    Text(item.sender)
                      .fontColor(item.category == 1 ? '#6E3800' : '#000000')
                    Text(item.category == 1
                      ? (item.messageInfoList[item.messageInfoList.length - 1].content ?? '')
                      : '')
                      .fontSize(14).fontColor('#7b7b7b')
                      .textOverflow({ overflow: TextOverflow.Ellipsis }).maxLines(1)
                  }
                  .alignItems(HorizontalAlign.Start).width(200)
                }
                // 时间
                Column() {
                  // Text(item.messageInfoList[item.messageInfoList.length - 1].sendTime)
                  Text(formatDisplayTime(item.messageInfoList[item.messageInfoList.length - 1].sendTime))
                }
                .height(50).width(80).justifyContent(FlexAlign.Start)
              }
              .width('100%')
              .margin({ left: 15 })
              .justifyContent(FlexAlign.SpaceBetween)
            }
            // 添加右滑菜单（向右滑动出现）
            .swipeAction({
              end: {
                builder: () => { this.SwipeMenuBuilder(item) },
                actionAreaDistance: 210   // 菜单占据宽度210（3个按钮各70）
              }
            })
            .onClick(() => {
              console.info("===== 点击了消息项 =====");
              if (this.hasUnread(item)) {
                console.info("存在未读消息，执行标记已读");
                this.markAsRead(item);
              }
              const currentItem = this.messageList.find(msg => msg.id === item.id);
              console.info("currentItem 是否存在:", currentItem ? "是" : "否");
              if (currentItem) {
                console.info("currentItem.url 值:", currentItem.url);
              }
              if (currentItem && currentItem.url) {
                console.info("准备跳转到:", currentItem.url);
                router.pushUrl({
                  url: currentItem.url,
                  params: { message: JSON.stringify(currentItem) }
                  // params: { sender: currentItem.sender }   // 只传商家名称
                }).catch((err: Error) => {
                  console.error(`跳转失败: ${err.message}`);
                });
              } else {
                console.info("条件不满足，不跳转");
              }
            })
          },
          (item: Message) => item.id + '_' + item.messageInfoList.filter(info => info.status === 1).length
        )
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor('#ffffff')
      .divider({ color: '#f4f4f4', strokeWidth: 0.5, startMargin: 60 })
    }
    .padding({ top: 20 })
    .width('100%')
    .layoutWeight(1)
  }
}
