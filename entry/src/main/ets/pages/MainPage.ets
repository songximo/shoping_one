import { TabbarItem, tabbarItemList } from '../models/TabbarItem'
import { promptAction } from '@kit.ArkUI'
import { Index } from './Index'
import { Message, MessageInfo, messageList } from '../models/MessageInfo'
import { MyPage } from './MyPage'
import { MessagePage } from './MessagePage'
import { emitter } from '@kit.BasicServicesKit'
import { EVENT_ORDER_CANCEL, EVENT_ORDER_PAY_SUCCESS, OrderMessageData } from '../utils/payMessage'
import { image } from '@kit.ImageKit'
import { loadMessageList, saveMessageList } from '../utils/messageStorage'
import { getImageResource } from '../utils/imageMapper'

@Entry
@Component
struct MainPage {

  //使用Tabs控制页面跳转
  @State selectIndex: number = 0
  controller: TabsController = new TabsController()
  @State tabbarItemList: TabbarItem[] = tabbarItemList

  //消息
  // @State messageList: Message[] = messageList  // 初始数据
  @State messageList: Message[] = [];
  @State noReadMsg: number = 0

  async aboutToAppear() {
    // 加载持久化消息
    const saved = await loadMessageList();
    if (saved.length > 0) {
      this.messageList = saved;
    } else {
      // 使用默认数据（如有）
      this.messageList = messageList;
    }
    this.updateNoReadMsg();
    // 注册事件监听
    emitter.on({ eventId: EVENT_ORDER_PAY_SUCCESS }, this.handleOrderEvent);
    emitter.on({ eventId: EVENT_ORDER_CANCEL }, this.handleOrderEvent);
  }
  handleOrderEvent = (eventData: emitter.EventData) => {
    const data = eventData.data as OrderMessageData;
    if (data) {
      this.addSystemMessage(data);
    }
  };

  build() {
    Tabs({barPosition:BarPosition.End,index:this.selectIndex,controller:this.controller}){
      TabContent(){
        //点击页签显示的内容
        Index()
      }.tabBar(this.tabbarBuilder(this.tabbarItemList[0],0))//TabContent的样式和内容
      TabContent(){
        //点击页签显示的内容
        MessagePage({messageList:$messageList,noReadMsg:$noReadMsg})
      }.tabBar(this.tabbarBuilder(this.tabbarItemList[1],1))
      TabContent(){
        //点击页签显示的内容
        MyPage()
      }.tabBar(this.tabbarBuilder(this.tabbarItemList[2],2))
    }.onChange((index: number)=>{
      this.selectIndex = index
      // promptAction.showToast({message:"当前页面为："+index})
    })
  }

  @Builder
  tabbarBuilder(item:TabbarItem,index:number){
    Column(){
      if(index!=0 || this.selectIndex != index){
        //顯示未讀消息
        if(this.noReadMsg>0 && index == 1) {
          Badge({
            value: this.noReadMsg +'',
            position:BadgePosition.RightTop,
            style:{badgeSize:15}
          }){
            Image(this.selectIndex == index?item.icon_selected:item.icon_normal).height(28)
              .width(28)
              .margin({ top: 5, bottom: 1 })
          }
          Text(item.title)
            .width('100%')
            .height(14)
            .fontSize(10)
            .fontWeight(500)
            .textAlign(TextAlign.Center)
            .margin({bottom:7})
        }else {
          Image(this.selectIndex==index?item.icon_selected:item.icon_normal).width(28).aspectRatio(1).margin({top:5,bottom:1})
          Text(item.title).width('100%').height(14).fontSize(10).fontWeight(500)
            .textAlign(TextAlign.Center)
            .margin({bottom:7})
        }
      }else{
        Image(item.icon_selected).width(35).aspectRatio(1).margin({top:5,bottom:1})
      }
    }
  }

  private async addSystemMessage(data: OrderMessageData) {
    const shangpu = data.shangpu;
    const messageTitle = data.messageTitle;
    const messageContent = data.messageContent;
    const imageName = data.imageName;
    let message = this.messageList.find(m => m.sender === shangpu);
    if (!message) {
      console.info('MainPage 收到支付消息，imageName:', imageName);
      // 根据图片标识获取 Resource
      const imgRes = getImageResource(data.imageName);
      console.info('转换后的 imgRes:', imgRes);
      message = new Message(2, shangpu, imgRes, [], 'pages/messagedetail/MessageDetailPage',imageName);
      this.messageList.push(message);
    }
    const newInfo = new MessageInfo();
    newInfo.title = messageTitle;
    newInfo.content = messageContent;
    newInfo.status = 1;
    newInfo.sendTime = this.getCurrentTime();
    newInfo.isSelf = false;
    newInfo.senderName = '系统';
    message.messageInfoList.push(newInfo);
    //更新未读数
    message.noReadNum = message.messageInfoList.filter(info => info.status === 1).length;
    // 触发 UI 刷新界面 （MessageList是@State，直接修改会出触发更新）
    this.messageList = [...this.messageList];
    this.updateNoReadMsg();
    // 持久化保存
    await saveMessageList(this.messageList);
  }

  //更新未读总数（已在MessagePage中计算，可在此更新noReadMsg）
  private updateNoReadMsg() {
    this.noReadMsg = this.messageList.reduce((sum, msg) => sum + msg.noReadNum, 0);
  }

  private getCurrentTime(): string {
    const now = new Date();
    return `${now.getHours().toString().padStart(2, '0')}:${now.getMinutes().toString().padStart(2, '0')}`;
  }

}


