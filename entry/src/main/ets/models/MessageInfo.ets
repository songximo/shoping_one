//1.4 消息右拉

export class MessageInfo {
  title?: string
  content?: string
  status: number = 0 // 1未读 2已读 3删除
  sendTime: string = ''
  isSelf: boolean = false   // 是否是自己发送的消息
  senderName: string = ''   // 发送者名称
}

export class Message {
  id: string = Math.random().toString(36).slice(-6)
  category?: number // 1商家 2系统
  sender: string
  image: ResourceStr
  messageInfoList: MessageInfo[]
  noReadNum: number
  url?: string

  constructor(category: number, sender: string, image: ResourceStr, messageInfoList: Partial<MessageInfo>[],url?:string,) {
    this.category = category
    this.sender = sender
    this.image = image
    // this.messageInfoList = messageInfoList
    // 将原始数据转换为完整的 MessageInfo，并自动设置 isSelf 和 senderName
    this.messageInfoList = messageInfoList.map(item => {
      const info = new MessageInfo()
      info.title = item.title
      info.content = item.content
      info.status = item.status ?? 0
      info.sendTime = item.sendTime ?? ''
      info.isSelf = false
      info.senderName = sender
      return info
    })
    this.noReadNum = messageInfoList.filter(item => item.status == 1).length
    this.url = url
  }
}

export const messageList: Message[] = [
  new Message(1, '互动消息', $r('app.media.ic_huodong'),
    [
      { title: '订单未支付，请支付订单', content: '优惠奖励秒到账，您的消费体验还未分享',
        status: 1, sendTime: '9:20' },
      { title: '订单已完成，晒评价赢福利', content: '优惠奖励秒到账，您的消费体验还未分享',
        status: 1, sendTime: '9:21' }
    ],"pages/messagedetail/MessageDetailPage"
  ),
  new Message(1, '优惠福利', $r('app.media.ic_youhuifuli'),
    [
      { title: '好评到账通知', status: 2, sendTime: '9:50' },
      { title: '优惠券领取', content: '优惠奖励秒到账，您的消费体验还未分享', status: 2, sendTime: '9:50' }
    ]),
  new Message(2, '一点点', $r('app.media.yidiandian'),
    [
      { title: '好评到账通知', content: '优惠奖励秒到账，您的消费体验还未分享', status: 1, sendTime: '9:50' },
      { title: '成功下单', content: '优惠奖励秒到账，您的消费体验还未分享', status: 1, sendTime: '9:50' }
    ])
]

