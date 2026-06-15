//Shops.ets
import { RoutePath } from "../route"

export class Shops {
  shopid: number = 0;           // 店铺ID
  type: string = '';
  image: ResourceStr = '';      // 店铺图标
  shangpu: string = '';         // 店铺名称
  remark: string = '';          // 促销信息
  content?: string;             // 店铺描述
  url?: string;                 // 跳转路径
}

export const shopList: Shops[] = [
  {
    shopid: 1,
    type: '外卖',
    // name: '一点点',
    image: $r('app.media.yidiandian'),
    shangpu: '一点点(中海国际店)',
    remark: '38减18 | 新客减3元 | 免配送',
    content: '点评收录9年',
    // url: 'pages/shops/YidiandianPage'//方法1
    url:RoutePath.YidiandianPage//方法2
  },
  {
    shopid: 2,
    type: '外卖',
    // name: '曹有道鸡公煲',
    image: $r('app.media.jigongbao'),
    shangpu: '曹有道鸡公煲',
    remark: '38减18 | 新客减3元 | 免配送',
    content: '郫都区鸡公煲排行第3',
    // url: 'pages/shops/YidiandianPage'
  },
  {
    shopid: 3,
    type: '外卖',
    // name: '尊宝披萨',
    image: $r('app.media.pisa'),
    shangpu: '尊宝披萨',
    remark: '38减18 | 新客减3元 | 免配送',
    content: '点评收录4年',
    // url: 'pages/shops/YidiandianPage'
  },
  {
    shopid:4,
    type: '外卖',
    // name: '螺蛳粉',
    image: $r('app.media.luosifen'),
    shangpu: '白螺湾(百草路店)',
    remark: '新客减3元 | 免配送',
    content: '郫都区螺蛳粉人气榜第3名',
    // url: 'pages/shops/YidiandianPage'
  },
  // ]
  // export const goodsItem2: Goods[] = [
  {
    shopid: 5,
    type: '外卖',
    // name: '塔斯汀',
    image: $r('app.media.tasiting'),
    shangpu: '塔斯汀(中海国际店)',
    remark: '20减11 | 新客减3元 | 免配送',
    content: '金牛区汉堡复购榜第5名',
    // url: 'pages/shops/YidiandianPage'
  },
  {
    shopid: 6,
    type: '外卖',
    // name: '华莱士',
    image: $r('app.media.hualaishi'),
    shangpu: '华莱士',
    remark: '20减13',
    content: '点评收录8年',
    // url: 'pages/shops/YidiandianPage'
  },
  {
    shopid: 7,
    type: '外卖',
    // name: '炸鸡',
    image: $r('app.media.zhaji'),
    shangpu: '故事里的炸鸡',
    remark: '免配送',
    content: '点评收录4年',
    // url: 'pages/shops/YidiandianPage'
  },
  {
    shopid: 8,
    type: '外卖',
    // name: '一点点',
    image: $r('app.media.yidiandian'),
    shangpu: '一点点(中海国际店)',
    remark: '38减18 | 新客减3元 | 免配送',
    content: '点评收录9年',
    // url: 'pages/shops/YidiandianPage'
  }
]

