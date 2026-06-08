import { RoutePath } from "../route"

export class Goods{
  id?: number
  name: string = ''
  image: ResourceStr = ''
  price?: number
  content?: string
  remark?: string
  discount?: number
  type?: string
  shangpu?: string
  url?: string
}

export const youxuanList: Goods[] = [
  {
    name: '柠檬水',
    price: 1,
    image: $r('app.media.mixue1'),
    // remark: '秒杀'
  },
  {
    name: '塔斯汀',
    price: 20,
    image: $r('app.media.tasiting')
  },
  {
    name: '螺蛳粉',
    price: 4,
    image: $r('app.media.luosifen'),
    // remark: '秒杀'
  },
  {
    name: '烧仙草',
    price: 7,
    image: $r('app.media.shaoxiancao')
  }
]
export const youxuanList1: Goods[] = [
  {
    name: '寿司',
    price: 19,
    image: $r('app.media.shous'),
    // remark: '限时秒杀'
  },
  {
    name: '华莱士',
    price: 15,
    image: $r('app.media.hualaishi')
  },
  {
    name: '烧仙草',
    price: 7,
    image: $r('app.media.shaoxiancao')
  },
  {
    name: '披萨',
    price: 10,
    image: $r('app.media.pisa'),
    // remark: '限时秒杀'
  }
]

export const goodsItem1: Goods[] = [
  {
    type: '外卖',
    name: '一点点',
    image: $r('app.media.yidiandian'),
    shangpu: '一点点(中海国际店)',
    remark: '38减18 | 新客减3元 | 免配送',
    content: '点评收录9年',
    url: 'pages/shops/YidiandianPage'//方法1
    // url:RoutePath.Yidiandian//方法2
  },
  {
    type: '外卖',
    name: '曹有道鸡公煲',
    image: $r('app.media.jigongbao'),
    shangpu: '曹有道鸡公煲',
    remark: '38减18 | 新客减3元 | 免配送',
    content: '郫都区鸡公煲排行第3'
  },
  {
    type: '外卖',
    name: '尊宝披萨',
    image: $r('app.media.pisa'),
    shangpu: '尊宝披萨',
    remark: '38减18 | 新客减3元 | 免配送',
    content: '点评收录4年'
  },
  {
    type: '外卖',
    name: '螺蛳粉',
    image: $r('app.media.luosifen'),
    shangpu: '白螺湾(百草路店)',
    remark: '新客减3元 | 免配送',
    content: '郫都区螺蛳粉人气榜第3名'
  }
]
export const goodsItem2: Goods[] = [
  {
    type: '外卖',
    name: '塔斯汀',
    image: $r('app.media.tasiting'),
    shangpu: '塔斯汀(中海国际店)',
    remark: '20减11 | 新客减3元 | 免配送',
    content: '金牛区汉堡复购榜第5名'
  },
  {
    type: '外卖',
    name: '华莱士',
    image: $r('app.media.hualaishi'),
    shangpu: '华莱士',
    remark: '20减13',
    content: '点评收录8年'
  },
  {
    type: '外卖',
    name: '炸鸡',
    image: $r('app.media.zhaji'),
    shangpu: '故事里的炸鸡',
    remark: '免配送',
    content: '点评收录4年'
  },
  {
    type: '外卖',
    name: '一点点',
    image: $r('app.media.yidiandian'),
    shangpu: '一点点(中海国际店)',
    remark: '38减18 | 新客减3元 | 免配送',
    content: '点评收录9年'
  }
]