@Component
export struct NavComp{

  @Builder
  navItemBuilder(isSelected:boolean,title:string,subTitle:string = ''){
    Column(){
      Text(){
        Span(title).fontSize(16).fontWeight(isSelected?600:300)
          .fontColor(isSelected?'#000':'#999')
        if(subTitle){
          Span(subTitle).fontSize(12).fontColor(isSelected?'#000':'#999')
        }
      }.layoutWeight(1)
      Text()
        .width(20)
        .height(3).backgroundColor(isSelected?'#FFDD00':'transparent')
        .margin(5)
    }
  }

  build() {
    Column({space:10}){
      // 返回和搜索
      Row(){
        Row({space:10}){
          Image($r('app.media.ic_public_input_search')).width(22).aspectRatio(1)
            .fillColor('#666666')
          Text('请输入商品名').fontSize(16).fontColor('#666666')
        }.height(30).backgroundColor('#F5F5F6').width(200).borderRadius(22)
        .margin({left:25})

        Row({space:15}){
          Image($r('app.media.zaixianlianxi'))
            .width(22).aspectRatio(1).fillColor('#575757')
          Image($r('app.media.guanzhu'))
            .width(22).aspectRatio(1).fillColor('#575757')
          Image($r('app.media.more'))
            .width(22).aspectRatio(1).fillColor('#575757')
        }.layoutWeight(1).height(26).justifyContent(FlexAlign.End)

      }.justifyContent(FlexAlign.Center)

      Row({space:10}){
        this.navItemBuilder(true,'点单')
        this.navItemBuilder(false,'评价','1399')
        this.navItemBuilder(false,'商家','地址')
      }.width('100%').height(40).border({color:'#e4e4e4',width:{bottom:0.5}}).margin({top:10})
    }
    .width('100%')
    .height(40)
    .backgroundColor('#ffffff')
    .padding(15)
  }
}


//搜索
// import { router } from "@kit.ArkUI"
//
// @Component
// export struct NavComp {
//   @Link searchKeyword: string;   // 双向绑定搜索关键字
//   onSearch?: (keyword: string) => void; // 可选回调，实时搜索
//
//   @Builder
//   navItemBuilder(isSelected: boolean, title: string, subTitle: string = '') {
//     Column() {
//       Text() {
//         Span(title).fontSize(16).fontWeight(isSelected ? 600 : 300)
//           .fontColor(isSelected ? '#000' : '#999')
//         if (subTitle) {
//           Span(subTitle).fontSize(12).fontColor(isSelected ? '#000' : '#999')
//         }
//       }.layoutWeight(1)
//       Text()
//         .width(20)
//         .height(3).backgroundColor(isSelected ? '#FFDD00' : 'transparent')
//         .margin(5)
//     }
//   }
//
//   build() {
//     Column({ space: 10 }) {
//       // 返回和搜索
//       Row() {
//         // 返回按钮（扩大点击区域）
//         Row() {
//           Image($r('app.media.ic_public_arrow_left'))
//             .width(24).height(24)
//         }
//         .width(44).height(44)
//         .justifyContent(FlexAlign.Center)
//         .onClick(() => router.back())
//
//         // 可输入的搜索框
//         Row({ space: 8 }) {
//           Image($r('app.media.ic_public_input_search'))
//             .width(18).height(18)
//             .fillColor('#999')
//           // TextInput({ placeholder: '请输入商品名', text: this.searchKeyword })
//           //   .layoutWeight(1)
//           //   .height(30)
//           //   .backgroundColor(Color.Transparent)
//           //   .fontSize(14)
//           //   .padding(0)
//           //   .onChange((value: string) => {
//           //     this.searchKeyword = value;
//           //     if (this.onSearch) {
//           //       this.onSearch(value);
//           //     }
//           //   })
//           TextInput({ placeholder: '请输入商品名', text: this.searchKeyword })
//             .layoutWeight(1)
//             .height(30)
//             .backgroundColor('#FFFFFF')        // 临时设为白色，确认可见
//             .fontSize(14)
//             .padding(0)
//             .onChange((value: string) => {
//               this.searchKeyword = value;
//               if (this.onSearch) {
//                 this.onSearch(value);
//               }
//             })
//             .onFocus(() => {
//               console.info("搜索框已获得焦点");
//             })
//
//         }
//         .height(36)
//         .backgroundColor('#F5F5F6')
//         .borderRadius(22)
//         .padding({ left: 12, right: 12 })
//         .layoutWeight(1)
//
//         Row({ space: 15 }) {
//           Image($r('app.media.zaixianlianxi'))
//             .width(22).height(22).fillColor('#575757')
//           Image($r('app.media.guanzhu'))
//             .width(22).height(22).fillColor('#575757')
//           Image($r('app.media.more'))
//             .width(22).height(22).fillColor('#575757')
//         }
//         .height(26)
//         .justifyContent(FlexAlign.End)
//       }
//       .justifyContent(FlexAlign.Center)
//       .width('100%')
//
//       Row({ space: 10 }) {
//         this.navItemBuilder(true, '点单')
//         this.navItemBuilder(false, '评价', '1399')
//         this.navItemBuilder(false, '商家', '地址')
//       }
//       .width('100%')
//       .height(40)
//       .border({ color: '#e4e4e4', width: { bottom: 0.5 } })
//       .margin({ top: 10 })
//     }
//     .width('100%')
//     .backgroundColor('#ffffff')
//     .padding({ left: 12, right: 12, top: 8, bottom: 8 })
//   }
// }


//搜索能输入
// import { router } from "@kit.ArkUI"
//
// @Component
// export struct NavComp {
//   @Link searchKeyword: string;
//   onSearch?: (keyword: string) => void;
//
//   @Builder
//   navItemBuilder(isSelected: boolean, title: string, subTitle: string = '') {
//     Column() {
//       Text() {
//         Span(title).fontSize(16).fontWeight(isSelected ? 600 : 300)
//           .fontColor(isSelected ? '#000' : '#999')
//         if (subTitle) {
//           Span(subTitle).fontSize(12).fontColor(isSelected ? '#000' : '#999')
//         }
//       }.layoutWeight(1)
//       Text()
//         .width(20)
//         .height(3).backgroundColor(isSelected ? '#FFDD00' : 'transparent')
//         .margin(5)
//     }
//   }
//
//   build() {
//     Column({ space: 10 }) {
//       Row() {
//         // 返回按钮（扩大点击区域）
//         Row() {
//           Image($r('app.media.ic_public_arrow_left'))
//             .width(24).height(24)
//         }
//         .width(44).height(44)
//         .justifyContent(FlexAlign.Center)
//         .onClick(() => router.back())
//
//         // 搜索框（确保可点）
//         Row({ space: 8 }) {
//           Image($r('app.media.ic_public_input_search'))
//             .width(18).height(18).fillColor('#999')
//           TextInput({ placeholder: '请输入商品名', text: this.searchKeyword })
//             .layoutWeight(1)
//             .height(36)
//             .backgroundColor('#F5F5F6')
//             .fontSize(14)
//             .padding(0)
//             .onChange((value: string) => {
//               this.searchKeyword = value;
//               if (this.onSearch) this.onSearch(value);
//             })
//         }
//         .height(40)
//         .backgroundColor('#F5F5F6')
//         .borderRadius(22)
//         .padding({ left: 12, right: 12 })
//         .layoutWeight(1)
//         .hitTestBehavior(HitTestMode.Default)  // 关键：确保可交互
//
//         Row({ space: 15 }) {
//           Image($r('app.media.zaixianlianxi')).width(22).height(22).fillColor('#575757')
//           Image($r('app.media.guanzhu')).width(22).height(22).fillColor('#575757')
//           Image($r('app.media.more')).width(22).height(22).fillColor('#575757')
//         }
//         .height(26).justifyContent(FlexAlign.End)
//       }
//       .justifyContent(FlexAlign.Center)
//       .width('100%')
//
//       Row({ space: 10 }) {
//         this.navItemBuilder(true, '点单')
//         this.navItemBuilder(false, '评价', '1399')
//         this.navItemBuilder(false, '商家', '地址')
//       }
//       .width('100%')
//       .height(40)
//       .border({ color: '#e4e4e4', width: { bottom: 0.5 } })
//       .margin({ top: 10 })
//     }
//     .width('100%')
//     .backgroundColor('#ffffff')
//     .padding({ left: 12, right: 12, top: 8, bottom: 8 })
//   }
// }

