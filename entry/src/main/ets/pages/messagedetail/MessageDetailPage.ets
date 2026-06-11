
//数据持久化
import { router } from '@kit.ArkUI';
import { MessageInfo } from '../../models/MessageInfo';
import { MessageDetailModel } from '../../models/MessageDetailData';
import { Top } from '../../component/messagedetail/Top';
import { MessageDetailList } from '../../component/messagedetail/MessageDetailList';
import { Bottom } from '../../component/messagedetail/Bottom';
import window from '@ohos.window';
import { KeyboardAvoidMode } from '@kit.ArkUI';
// import { AppStorage } from '@kit.ArkUI';

interface SerializedMessageInfo {
  title?: string;
  content?: string;
  status: number;
  sendTime: string;
}
interface SerializedMessage {
  sender: string;
  messageInfoList: Array<SerializedMessageInfo>;
}

@Entry
@Component
struct MessageDetailPage {
  scroller: Scroller = new Scroller();
  @State model: MessageDetailModel | null = null;

  // 滚动到底部的封装方法
  private scrollToBottom(): void {
    setTimeout(() => {
      if (this.scroller) {
        this.scroller.scrollEdge(Edge.Bottom);
      }
    }, 50); // 延迟确保 UI 已更新
  }

  async aboutToAppear() {
    // 设置键盘避让模式
    try {
      // 1. 获取存储的windowStage
      const windowStage = AppStorage.get('windowStage') as window.WindowStage;
      if (windowStage) {
        // 2. 获取主窗口的UIContext
        const uiContext = windowStage.getMainWindowSync().getUIContext();
        // 3. 设置为RESIZE模式：键盘弹出时会调整页面大小，达到压缩滚动区域的效果
        uiContext.setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);
      } else {
        // 备用方案，如果取不到windowStage
        const win = await window.getLastWindow(getContext(this));
        win.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);
      }
    } catch (err) {
      console.error('设置键盘避让模式失败', err);
    }

    const params = router.getParams() as Record<string, string>;
    if (params && params['message']) {
      try {
        const obj = JSON.parse(params['message']) as SerializedMessage;
        const infoList = obj.messageInfoList.map(info => {
          const newInfo = new MessageInfo();
          newInfo.title = info.title;
          newInfo.content = info.content;
          newInfo.status = info.status;
          newInfo.sendTime = info.sendTime;
          return newInfo;
        });
        const model = new MessageDetailModel(obj.sender, infoList);
        await model.loadExtraMessages();   // 等待额外消息加载完成
        this.model = model;

        // 页面加载完成后滚动到底部
        this.scrollToBottom();



      } catch (e) {
        console.error('解析消息失败', e);
      }
    }
  }

  handleSend(text: string): void {
    if (this.model) {
      this.model.addMessage(text);
      // 触发界面刷新（重新赋值）
      // this.model = new MessageDetailModel(this.model.sender, [...this.model.messages]);
      // 强制刷新 UI：临时置空再恢复，符合 ArkTS 规范
      const currentModel = this.model;
      this.model = null;
      setTimeout(() => {
        this.model = currentModel;
        this.scrollToBottom();
      }, 0);
      // 注意：上面的重新构造会丢失异步加载的额外消息？但我们已经在构造函数中复制了 messages，
      // 而 messages 已经包含了所有消息（原始+额外），且新添加的消息也会保存。这里重新赋值是为了刷新UI。
      // 更简单的方法：直接用 @Observed 装饰 MessageInfo 和 MessageDetailModel，但为了简单，就重新赋值。
      // 由于重新赋值后 messages 数据不变，且新消息已在其中，所以没问题。


      // 发送后滚动到底部
      this.scrollToBottom();

    }
  }

  build() {
    Column() {
      if (this.model) {
        Top({ sender: this.model.sender })
        Scroll(this.scroller) {
          MessageDetailList({ messages: this.model.messages })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Auto)
        Bottom({ onSend: (text: string) => this.handleSend(text),
          onInputFocus: () => this.scrollToBottom()   // 键盘弹出时滚动
        })
      } else {
        Text('加载中...').layoutWeight(1)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}

