
//固定多选删除底栏

import { MessageInfo } from '../../models/MessageInfo';
import { AlertDialog } from '@kit.ArkUI';

// 时间解析与格式化（保持不变）
function parseTimeToDate(timeStr: string): Date {
  if (timeStr.includes('-')) {
    return new Date(timeStr.replace(' ', 'T') + ':00');
  } else {
    const now = new Date();
    const parts = timeStr.split(':');
    const hours = Number(parts[0]);
    const minutes = Number(parts[1]);
    const date = new Date(now);
    date.setHours(hours, minutes, 0, 0);
    return date;
  }
}

function formatDisplayTime(timeStr: string): string {
  if (timeStr.includes('-')) {
    const parts = timeStr.split(' ');
    return parts[1];
  }
  return timeStr;
}

@Component
export struct MessageDetailList {
  @Prop @Watch('onMessagesChange') messages: MessageInfo[] = [];
  onDeleteMessage?: (index: number) => void;
  onBatchDeleteMessages?: (indices: number[]) => void;
  @Link isMultiSelectMode: boolean;          // 双向绑定
  @Link selectedIndices: Set<number>;        // 双向绑定
  @State showTimeFlags: boolean[] = [];

  aboutToAppear() {
    this.updateShowTimeFlags();
  }

  onMessagesChange() {
    this.updateShowTimeFlags();
    if (!this.isMultiSelectMode) {
      this.selectedIndices.clear();
    }
  }

  private updateShowTimeFlags() {
    const flags: boolean[] = [];
    for (let i = 0; i < this.messages.length; i++) {
      let show = true;
      if (i > 0) {
        const prev = this.messages[i - 1];
        const prevDate = parseTimeToDate(prev.sendTime);
        const currDate = parseTimeToDate(this.messages[i].sendTime);
        const diffMs = currDate.getTime() - prevDate.getTime();
        if (diffMs < 60000 && diffMs >= 0) {
          show = false;
        }
      }
      flags.push(show);
    }
    this.showTimeFlags = flags;
  }

  // 切换选中状态
  private toggleSelect(idx: number) {
    if (this.selectedIndices.has(idx)) {
      this.selectedIndices.delete(idx);
    } else {
      this.selectedIndices.add(idx);
    }
    // 触发UI更新
    this.selectedIndices = new Set(this.selectedIndices);
  }

  // 长按菜单构建器（使用消息id定位）
  @Builder
  ContextMenuBuilder(message: MessageInfo) {
    Column() {
      Button('删除')
        .width('100%')
        .backgroundColor(Color.Transparent)
        .fontColor('#FF3B30')
        .onClick(() => {
          const realIndex = this.messages.findIndex(m => m.id === message.id);
          if (realIndex === -1) return;
          this.getUIContext().showAlertDialog({
            title: '删除消息',
            message: '确定要删除这条消息吗？',
            primaryButton: {
              value: '取消',
              action: () => {}
            },
            secondaryButton: {
              value: '删除',
              fontColor: '#FF3B30',
              action: () => {
                this.onDeleteMessage?.(realIndex);
              }
            }
          });
        })
      Divider().margin({ left: 10, right: 10 })
      Button('多选')
        .width('100%')
        .backgroundColor(Color.Transparent)
        .fontColor('#007AFF')
        .onClick(() => {
          this.isMultiSelectMode = true;
        })
    }
    .width(100)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .shadow({ radius: 10, color: '#CCCCCC' })
  }

  build() {
    Column() {
      ForEach(this.messages, (info: MessageInfo, idx: number) => {
        Column() {
          // 时间标签
          if (this.showTimeFlags[idx]) {
            Text(formatDisplayTime(info.sendTime))
              .fontSize(12)
              .fontColor('#999999')
              .width('100%')
              .textAlign(TextAlign.Center)
              .margin({ top: 8, bottom: 4 })
          }

          Row() {
            // 多选模式复选框
            if (this.isMultiSelectMode) {
              Checkbox()
                .width(20)
                .height(20)
                .margin({ right: 8 })
                .select(this.selectedIndices.has(idx))
                .onChange((selected) => {
                  if (selected) {
                    this.selectedIndices.add(idx);
                  } else {
                    this.selectedIndices.delete(idx);
                  }
                  this.selectedIndices = new Set(this.selectedIndices);
                })
            }

            // 对方头像
            if (!info.isSelf) {
              Image($r('app.media.icon'))
                .width(40).height(40).borderRadius(20)
                .margin({ right: 8 })
            }

            // 消息气泡
            Column({ space: 4 }) {
              if (!info.isSelf) {
                Text(info.senderName)
                  .fontSize(12).fontColor('#999999')
                  .margin({ left: 4, bottom: 2 })
              }
              Column({ space: 2 }) {
                if (!info.isSelf && info.title) {
                  Text(info.title)
                    .fontSize(14).fontWeight(FontWeight.Medium)
                    .width('100%').textAlign(TextAlign.Start)
                }
                if (info.content) {
                  Text(info.content)
                    .fontSize(14).fontColor('#333333')
                    .width('100%').textAlign(TextAlign.Start)
                }
              }
              .width('70%')
              .padding(10)
              .backgroundColor(info.isSelf ? '#DCF8C6' : '#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 2, color: '#DDDDDD' })
            }

            // 自己头像
            if (info.isSelf) {
              Image($r('app.media.yonghu'))
                .width(40).height(40).borderRadius(20)
                .margin({ left: 8 })
            }
          }
          .width('100%')
          .justifyContent(info.isSelf ? FlexAlign.End : FlexAlign.Start)
          .padding({ left: 12, right: 12, top: 4, bottom: 4 })
          .bindContextMenu(this.ContextMenuBuilder(info), ResponseType.LongPress)
        }
      }, (info: MessageInfo) => info.id)
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .backgroundColor('#f5f5f5')
  }
}