//paymessage.ets
export const EVENT_ORDER_PAY_SUCCESS = 10002;
export const EVENT_ORDER_CANCEL = 10003;

export interface OrderMessageData {
  shangpu: string;      // 商家名称
  // image: ResourceStr;       //商家图标
  imageName: string;
  messageTitle: string;  // 消息标题
  messageContent: string;// 消息内容
}

