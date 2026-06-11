@Component
export struct Bottom {
  onSend: (text: string) => void = () => {};
  @State inputText: string = '';
  onInputFocus?: () => void;        //键盘获取焦点时回调

  build() {
    Row({ space: 10 }) {
      TextInput({ placeholder: '输入消息...', text: this.inputText })
        .layoutWeight(1)
        .height(40)
        .backgroundColor('#ffffff')
        .borderRadius(20)
        .onChange((value: string) => { this.inputText = value; })
        .onFocus(() => {
          // 键盘弹出时触发
          this.onInputFocus?.();
        })
      Button('发送')
        .height(40)
        .width(60)
        .fontSize(14)
        .onClick(() => {
          if (this.inputText.trim() !== '') {
            this.onSend(this.inputText);
            this.inputText = '';
          }
        })
    }
    .width('100%')
    .height(50)
    .padding(12)
    .backgroundColor('#f4f4f4')
  }
}