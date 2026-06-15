
// utils/MessageStorage.ets
import preferences from '@ohos.data.preferences';
import { Message, MessageInfo } from '../models/MessageInfo';
import { getImageResource } from './imageMapper';

const MESSAGE_STORAGE_KEY = 'message_list';

// 定义存储结构接口（必须显式声明）
interface StoredMessageInfo {
  id: string;
  title?: string;
  content?: string;
  status: number;
  sendTime: string;
  isSelf: boolean;
  senderName: string;
}

interface StoredMessage {
  id: string;
  category?: number;
  sender: string;
  imageName: string;
  messageInfoList: StoredMessageInfo[];
  noReadNum: number;
  url?: string;
}

export async function saveMessageList(messages: Message[]): Promise<void> {
  try {
    const pref = await preferences.getPreferences(getContext(), 'message_data');
    // ✅ 显式构造 StoredMessage 对象，不能直接写对象字面量
    const toStore: StoredMessage[] = messages.map(msg => {
      const stored: StoredMessage = {
        id: msg.id,
        category: msg.category,
        sender: msg.sender,
        imageName: msg.imageName,
        messageInfoList: msg.messageInfoList,
        noReadNum: msg.noReadNum,
        url: msg.url
      };
      return stored;
    });
    await pref.put(MESSAGE_STORAGE_KEY, JSON.stringify(toStore));
    await pref.flush();
  } catch (e) {
    console.error('保存消息列表失败', e);
  }
}

export async function loadMessageList(): Promise<Message[]> {
  try {
    const pref = await preferences.getPreferences(getContext(), 'message_data');
    const json = await pref.get(MESSAGE_STORAGE_KEY, '[]');
    const data = typeof json === 'string' ? json : JSON.stringify(json);
    const rawList = JSON.parse(data) as StoredMessage[];
    const messages: Message[] = [];
    for (const raw of rawList) {
      const imgRes = getImageResource(raw.imageName);
      // ✅ 构造 Partial<MessageInfo> 数组，每个元素需显式声明类型
      const partialList: Partial<MessageInfo>[] = raw.messageInfoList.map(info => {
        const partial: Partial<MessageInfo> = {
          title: info.title,
          content: info.content,
          status: info.status,
          sendTime: info.sendTime
        };
        return partial;
      });
      const msg = new Message(
        raw.category ?? 2,
        raw.sender,
        imgRes,
        partialList,
        raw.url,
        raw.imageName
      );
      msg.id = raw.id;
      msg.noReadNum = raw.noReadNum;
      // 恢复完整字段
      for (let i = 0; i < raw.messageInfoList.length; i++) {
        const stored = raw.messageInfoList[i];
        const target = msg.messageInfoList[i];
        target.id = stored.id;
        target.isSelf = stored.isSelf;
        target.senderName = stored.senderName;
      }
      messages.push(msg);
    }
    return messages;
  } catch (e) {
    console.error('加载消息列表失败', e);
    return [];
  }
}




