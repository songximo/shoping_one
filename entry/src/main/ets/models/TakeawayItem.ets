export class TakeawayItem{
  itemName: string = ''
  itemImage: ResourceStr = ''
  itemUrl?: string// 可选属性可以不赋值
}

export const takeawayList: TakeawayItem[] = [
  {
    itemName:'美食',
    itemImage: $r('app.media.meishi')
  },
  {
    itemName:'同城急送',
    itemImage: $r('app.media.tongchengjisong')
  },
  {
    itemName:'超市便利',
    itemImage: $r('app.media.supermarket')
  },
  {
    itemName:'品质百货',
    itemImage: $r('app.media.store')
  },
  {
    itemName:'看病买药',
    itemImage: $r('app.media.medicine')
  }
]


export const secondtakeawayList: TakeawayItem[][]= [
  [
    {
      itemName:'外卖',
      itemImage: $r('app.media.takeaway')
    },
    {
      itemName:'团购',
      itemImage: $r('app.media.tuangou')
    },
  {
    itemName:'蛋糕',
    itemImage: $r('app.media.dangao')
  },
  {
    itemName:'水果',
    itemImage: $r('app.media.fruit')
  },
  {
    itemName:'鲜花',
    itemImage: $r('app.media.xianhua')
  },
  {
    itemName:'咖啡奶茶',
    itemImage: $r('app.media.naicha')
  },
  {
    itemName:'新鲜蔬菜',
    itemImage: $r('app.media.xinxianshucai')
  },
    {
      itemName:'酒水饮料',
      itemImage: $r('app.media.jiushuiyinliao')
    },
    {
      itemName:'零食',
      itemImage: $r('app.media.lingshi')
    },
    {
      itemName:'电影演出',
      itemImage: $r('app.media.maoyan')
    },
],
[
  {
    itemName:'新鲜蔬菜',
    itemImage: $r('app.media.xinxianshucai')
  },
  {
    itemName:'蛋糕',
    itemImage: $r('app.media.dangao')
  },
  {
    itemName:'咖啡奶茶',
    itemImage: $r('app.media.naicha')
  },
  {
    itemName:'零食',
    itemImage: $r('app.media.lingshi')
  },
  {
    itemName:'酒水饮料',
    itemImage: $r('app.media.jiushuiyinliao')
  },
  {
    itemName:'外卖',
    itemImage: $r('app.media.takeaway')
  },
  {
    itemName:'美食',
    itemImage: $r('app.media.meishi')
  },
  {
    itemName:'水果',
    itemImage: $r('app.media.fruit')
  },
  {
    itemName:'鲜花',
    itemImage: $r('app.media.xianhua')
  },
  {
    itemName:'看病买药',
    itemImage: $r('app.media.medicine')
  },
  ]
]