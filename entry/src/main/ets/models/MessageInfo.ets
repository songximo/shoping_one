export class MessageInfo{
  title?: string
  content?: string
  status: number = 0 //1未读 2已读 3删除：物理删除1,2/逻辑删除
  sendTime: string =''
}

export class  Message{
  id: string = Math.random().toString(36).slice(-6)
  category?: number //商家和系统消息 1商家 2系统
  sender: string //发送方
  image: ResourceStr
  messageInfoList: MessageInfo[]
  noReadNum: number //未读消息

  constructor(catehory:number,sender:string,image:ResourceStr,messageInfoList:MessageInfo[]) {
    this.category = catehory
    this.sender = sender
    this.image = image
    this.messageInfoList = messageInfoList
    this.noReadNum = messageInfoList.filter(item=>item.status==1).length


  }

}

export const messageList:Message[] = [
  new Message(1,'互动消息',$r('app.media.ic_huodong'),
    [
      {
        title: '订单未支付，请支付订单',
        content: '优惠奖励秒到账，您的消费体验还未分享',
        status: 1,
        sendTime: '9：20'
      },
      {
        title: '订单已完成，晒评价赢福利',
        content: '优惠奖励秒到账，您的消费体验还未分享',
        status: 1,
        sendTime: '9：21'
      }
    ]),
  new Message(1,'优惠福利',$r('app.media.ic_youhuifuli'),
    [
      {
        title: '好评到账通知',
        // content: '优惠奖励秒到账，您的消费体验还未分享',
        status: 2,
        sendTime: '9：50'
      },
      {
        title: '优惠券领取',
        content: '优惠奖励秒到账，您的消费体验还未分享',
        status: 2,
        sendTime: '9：50'
      }
    ])

]