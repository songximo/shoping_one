import { Message } from "../models/MessageInfo"

@Component
export struct MessageComp{
  @Link messageList: Message[]

  @Link noReadMsg: number


  build() {
    Column(){
      Row({space:15}){
        Text(){
          Span('消息').fontSize(25).fontWeight(600)
          if(this.noReadMsg>0){
            Span(` (${this.noReadMsg})`).fontSize(15)
          }

        }
        Row(){
          Image($r('app.media.icon_message_read')).width(15).aspectRatio(1)
            .fillColor('#7D7D7D')
          Text('全部已读').fontSize(15).fontColor('#7b7b7b')
        }.alignItems(VerticalAlign.Bottom)
        .onClick(()=>{
          this.messageList.forEach((item:Message,index:number)=>{
            if(item.noReadNum>0){
              // const msg = {...item}
              const msg: Message = new Message(
                item.category ?? 0,  // ✅ 兜底，undefined 转 0
                item.sender,
                item.image,
                [...item.messageInfoList]
              );
              msg.noReadNum = item.noReadNum ?? 0; // 同样给 noReadNum 兜底

              const newList = msg.messageInfoList.map(item=>{
                item.status = 2
                return item
              })
              msg.messageInfoList = newList
              msg.noReadNum = 0
              this.messageList[index] = msg
            }
          })
          this.noReadMsg = 0
        })
        Text('设置').fontSize(15).layoutWeight(1).textAlign(TextAlign.End)

      }.width('100%')
      .padding({top:15,left:15,right:15})
      .height(50).backgroundColor('#f4f4f4')

      List({space:25}){
        ListItem(){
          Row(){
            Row(){
              Image($r('app.media.ic_public_input_search')).width(24).aspectRatio(1)
                .fillColor('#7b7b7b')
              Text('搜索').fontSize(17).fontColor('#7b7b7b')
            }.borderRadius(14).backgroundColor('FFFFFF').width('100%').height(33)
          }.width('100%')
          .height(55).backgroundColor('#f4f4f4').padding({top:8,left:15,right:15})
        }
        ForEach(
          this.messageList,
          (item:Message)=>{
            ListItem(){
              Row({space:10}){
                Row({space:10}) {
                  if (item.messageInfoList.filter(item => item.status == 1).length > 0){
                  Badge({
                    value: item.messageInfoList.filter(item => item.status == 1).length + '',
                    position: BadgePosition.RightTop,
                    style: { badgeSize: 15 }
                  }) {
                    Image(item.image).width(50).aspectRatio(1).borderRadius(8)
                  }
                  .width(55)
                  .height(55)
                  .margin({ bottom: 4 })
                } else{
                    Image(item.image).width(50).aspectRatio(1).borderRadius(8)
                  }

                  Column({space:5}){
                    Text(item.sender).fontColor(item.category==1?'#6E3800':'#000000')
                    Text(item.category==1?item.messageInfoList[item.messageInfoList.length-1].content:'')
                      .fontSize(14).fontColor('#7b7b7b')
                      .textOverflow({overflow:TextOverflow.Ellipsis})
                      .maxLines(1)
                  }.alignItems(HorizontalAlign.Start).width(200)
                }

                Column(){
                  Text(item.messageInfoList[item.messageInfoList.length-1].sendTime)
                }.height(50).width(80).justifyContent(FlexAlign.Start)
              }.width('100%').margin({left:15}).justifyContent(FlexAlign.SpaceBetween)
            }
          }
        )
      }.layoutWeight(1).width('100%').backgroundColor('#ffffff')
       .divider({color:'#f4f4f4',strokeWidth:0.5,startMargin:60})

    }.width('100%')
    .height('100%')
  }
}