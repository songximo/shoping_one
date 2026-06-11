//数据持久化
import { MessageInfo } from '../models/MessageInfo';
import preferences from '@ohos.data.preferences';

export class MessageDetailModel {
  sender: string;
  messages: MessageInfo[];
  private prefKey: string;  // 存储额外消息的 key

  constructor(sender: string, originalMessages: MessageInfo[]) {
    this.sender = sender;
    // this.messages = [...originalMessages];  // 复制原始消息
    this.prefKey = `extra_msgs_${sender}`;
    // 标记对方消息：isSelf = false, senderName = 会话名称
    this.messages = originalMessages.map(msg => {
      const newMsg = new MessageInfo();
      newMsg.title = msg.title;
      newMsg.content = msg.content;
      newMsg.status = msg.status;
      newMsg.sendTime = msg.sendTime;
      newMsg.isSelf = msg.isSelf ?? false;
      newMsg.senderName = msg.senderName ?? sender;
      return newMsg;
    });
  }

  // 异步加载额外消息（需要在页面 aboutToAppear 中 await）
  async loadExtraMessages(): Promise<void> {
    try {
      const pref = await preferences.getPreferences(getContext(), 'message_extra');
      const value = await pref.get(this.prefKey, '');
      // 确保 value 是字符串类型
      const json = typeof value === 'string' ? value : JSON.stringify(value);
      if (json && json !== '""') {  // 避免空字符串
        const extraList = JSON.parse(json) as MessageInfo[];
        extraList.forEach(info => {
          const newInfo = new MessageInfo();
          newInfo.title = info.title;
          newInfo.content = info.content;
          newInfo.status = info.status;
          newInfo.sendTime = info.sendTime;

          // 自己发送的消息，isSelf = true, senderName = '我'
          newInfo.isSelf = true;
          newInfo.senderName = '我';

          this.messages.push(newInfo);
        });
      }
    } catch (e) {
      console.error('加载额外消息失败', e);
    }
  }

  // ✅ 修改保存条件：按 isSelf 过滤，而不是 title
  private async saveExtraMessages(): Promise<void> {
    const extra = this.messages.filter(msg => msg.isSelf === true);
    try {
      const pref = await preferences.getPreferences(getContext(), 'message_extra');
      await pref.put(this.prefKey, JSON.stringify(extra));
      await pref.flush();
    } catch (e) {
      console.error('保存额外消息失败', e);
    }
  }

  // 添加新消息（自己发送的默认已读）
  addMessage(content: string): void {
    const newMsg = new MessageInfo();
    // newMsg.title = '我';
    newMsg.title = '';
    newMsg.content = content;
    // newMsg.status = 2; // 已读
    newMsg.sendTime = this.getCurrentTime();

    newMsg.isSelf = true;
    newMsg.senderName = '我';

    this.messages.push(newMsg);
    this.saveExtraMessages(); // 保存到本地
  }

  private getCurrentTime(): string {
    const now = new Date();
    return `${now.getHours().toString().padStart(2, '0')}:${now.getMinutes().toString().padStart(2, '0')}`;
  }
}
