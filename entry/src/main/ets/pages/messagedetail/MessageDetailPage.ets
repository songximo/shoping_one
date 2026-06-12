
//数据持久化

//多选删除底栏

import { router } from '@kit.ArkUI';
import { MessageInfo } from '../../models/MessageInfo';
import { MessageDetailModel } from '../../models/MessageDetailData';
import { Top } from '../../component/messagedetail/Top';
import { MessageDetailList } from '../../component/messagedetail/MessageDetailList';
import { Bottom } from '../../component/messagedetail/Bottom';
import window from '@ohos.window';
import { KeyboardAvoidMode, AlertDialog } from '@kit.ArkUI';

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
  @State isMultiSelectMode: boolean = false;
  @State selectedIndices: Set<number> = new Set();
  private currentMessageId: string = '';   // 保存当前会话的 id

  private scrollToBottom(): void {
    setTimeout(() => {
      if (this.scroller) {
        this.scroller.scrollEdge(Edge.Bottom);
      }
    }, 50);
  }

  async aboutToAppear() {
    try {
      const windowStage = AppStorage.get('windowStage') as window.WindowStage;
      if (windowStage) {
        const uiContext = windowStage.getMainWindowSync().getUIContext();
        uiContext.setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);
      } else {
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
        await model.loadExtraMessages();
        this.model = model;
        this.scrollToBottom();
      } catch (e) {
        console.error('解析消息失败', e);
      }
    }
  }

  handleSend(text: string): void {
    if (this.model) {
      this.model.addMessage(text);
      const currentModel = this.model;
      this.model = null;
      setTimeout(() => {
        this.model = currentModel;
        this.scrollToBottom();
      }, 0);
    }
  }

  handleDeleteMessage(index: number): void {
    if (this.model) {
      this.model.deleteMessage(index);
      this.model = new MessageDetailModel(this.model.sender, [...this.model.messages]);
    }
  }

  handleBatchDeleteMessages(indices: number[]): void {
    if (this.model) {
      this.model.deleteMessages(indices);
      this.model = new MessageDetailModel(this.model.sender, [...this.model.messages]);
    }
  }

  // 底栏批量删除
  private batchDeleteFromBar(): void {
    const indices = Array.from(this.selectedIndices).sort((a, b) => b - a);
    if (indices.length === 0) return;
    this.getUIContext().showAlertDialog({
      title: '批量删除',
      message: `确定要删除选中的 ${indices.length} 条消息吗？`,
      primaryButton: {
        value: '取消',
        action: () => {}
      },
      secondaryButton: {
        value: '删除',
        fontColor: '#FF3B30',
        action: () => {
          this.handleBatchDeleteMessages(indices);
          this.isMultiSelectMode = false;
          this.selectedIndices.clear();
        }
      }
    });
  }

  private exitMultiSelectMode(): void {
    this.isMultiSelectMode = false;
    this.selectedIndices.clear();
  }

  //多选底栏覆盖发送框
  build() {
    Column() {
      if (this.model) {
        Top({ sender: this.model.sender })
        Scroll(this.scroller) {
          MessageDetailList({
            messages: this.model.messages,
            onDeleteMessage: (index: number) => this.handleDeleteMessage(index),
            onBatchDeleteMessages: (indices: number[]) => this.handleBatchDeleteMessages(indices),
            isMultiSelectMode: $isMultiSelectMode,
            selectedIndices: $selectedIndices
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Auto)

        // 底部区域：多选模式显示底栏，否则显示输入框（覆盖效果）
        if (this.isMultiSelectMode) {
          // 多选底栏
          Row() {
            Button('取消')
              .fontSize(14)
              .backgroundColor(Color.Transparent)
              .fontColor('#007AFF')
              .onClick(() => this.exitMultiSelectMode())
            Blank()
            Text(`已选 ${this.selectedIndices.size} 条`)
              .fontSize(14)
              .fontColor('#333333')
            Blank()
            Button('删除')
              .fontSize(14)
              .backgroundColor(Color.Transparent)
              .fontColor('#FF3B30')
              .enabled(this.selectedIndices.size > 0)
              .onClick(() => this.batchDeleteFromBar())
          }
          .width('100%')
          .height(50)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFF')
          .border({ width: { top: 0.5 }, color: '#E0E0E0' })
        } else {
          Bottom({
            onSend: (text: string) => this.handleSend(text),
            onInputFocus: () => this.scrollToBottom()
          })
        }
      } else {
        Text('加载中...').layoutWeight(1)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }

}

