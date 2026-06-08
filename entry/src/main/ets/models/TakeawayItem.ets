export class TakeawayItem{
  itemName: string = ''
  itemImage: ResourceStr = ''
  itemUrl?: string// 可选属性可以不赋值
}

export const takeawayList: TakeawayItem[] = [
  {
    itemName:'外卖',
    itemImage: $r('app.media.takeaway')
  },
  {
    itemName:'蔬菜水果',
    itemImage: $r('app.media.fruit')
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
  },
]


export const secondtakeawayList: TakeawayItem[][]= [
  [
  {
    itemName:'外卖',
    itemImage: $r('app.media.takeaway')
  },
  {
    itemName:'蔬菜水果',
    itemImage: $r('app.media.fruit')
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
  },
],
[
  {
    itemName:'外卖',
    itemImage: $r('app.media.takeaway')
  },
  {
    itemName:'蔬菜水果',
    itemImage: $r('app.media.fruit')
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
  },
  ]
]