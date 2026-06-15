//Category.ets
import { Goods } from './Goods'
export class Category{
  categoryid: number = 0
  name: string = ''
  foods: Goods[] = []
}

export const categoryList: Category[] = [
  {
    categoryid: 1111,
    name: '神抢手',
    foods: [
      {
        goodsid: 101,
        name: '冰淇淋红茶双大杯套餐',
        remark: '20+回头客推荐',
        month_sale: 88,
        price: 40,
        discount: 32.9,
        image: $r('app.media.bingqilinhongchashuangdabeitaocan'),
        zhekou: '低至8.3折'
      },
      {
        goodsid: 102,
        name: '经典招牌(大杯)4选2',
        remark: '30+回头客推荐',
        month_sale: 100,
        price: 32,
        discount: 26.9,
        image: $r('app.media.jingdianzhaopaidabei4xuan2'),
        zhekou: '低至8.5折'
      },
      {
        goodsid: 103,
        name: '果茶系列三选二双大杯套餐',
        month_sale: 25,
        price: 30,
        discount: 24.9,
        image: $r('app.media.guochaxilie3xuan2shuangdabei'),
        zhekou: '低至8.3折'
      },
      {
        goodsid: 104,
        name: '果茶果奶四选二双大杯套餐',
        month_sale: 11,
        price: 30,
        discount: 25.9,
        image: $r('app.media.guochaguonai4xuan2shuangdabei'),
        zhekou: '低至8.7折'
      },
    ]
  },
  {
    categoryid: 2222,
    name: '推荐',
    foods: [
      {
        goodsid: 201,
        name: 'QQ美莓奶茶',
        remark: '门店销量第1名',
        month_sale: 1000,
        price: 16,
        discount: 14,
        image: $r('app.media.QQmeimei'),
        daoshou: 14
      },
      {
        goodsid: 202,
        name: '冰淇淋红茶',
        remark: '门店销量第2名',
        month_sale: 800,
        price: 16,
        discount: 14,
        image: $r('app.media.bingqilinhongcha'),
        daoshou: 14
      },
      {
        goodsid: 203,
        name: '波霸奶茶',
        month_sale: 300,
        price: 13,
        discount: 11,
        image: $r('app.media.bobanaicha'),
        daoshou: 11
      },
      {
        goodsid: 204,
        name: 'A2牛乳红茶',
        month_sale: 100,
        price: 16,
        discount: 14,
        image: $r('app.media.A2niuruhongcha'),
        daoshou: 14
      },
      {
        goodsid: 205,
        name: '奶绿装忙',
        month_sale: 200,
        price: 17,
        discount: 15,
        image: $r('app.media.nailvzhuangmang'),
        daoshou: 15
      },
      {
        goodsid: 206,
        name: '芭乐奶绿',
        remark: '沁脾清甜',
        month_sale: 200,
        price: 16,
        discount: 14,
        image: $r('app.media.balenailv'),
        daoshou: 14
      }
    ]
  },
  {
    categoryid: 3333,
    name: '只此系列',
    foods: [
      {
        goodsid: 301,
        name: '只此青柚',
        remark: '冻软弹滑溜',
        month_sale: 74,
        price: 10.9,
        discount: 8.9,
        image: $r('app.media.zhiciqingyou'),
        daoshou: 8.9
      },
      {
        goodsid: 302,
        name: '只此芒果青',
        remark: '10+回头客推荐',
        month_sale: 77,
        price: 11.9,
        discount: 9.9,
        image: $r('app.media.zhicimangguoqing'),
        daoshou: 9.9
      },
      {
        goodsid: 303,
        name: '只此猕猴桃',
        remark: '酸甜平衡',
        month_sale: 100,
        price: 11.9,
        discount: 9.9,
        image: $r('app.media.zhicimihoutao'),
        daoshou: 9.9
      }
    ]
  },
  {
    categoryid: 4444,
    name: '花果奶茶',
    foods: [
      {
        goodsid: 401,
        name: 'QQ美莓奶茶',
        remark: '门店销量第1名',
        month_sale: 1000,
        price: 16,
        discount: 14,
        image: $r('app.media.QQmeimei'),
        daoshou: 14
      },
      {
        goodsid: 402,
        name: '芭乐奶绿',
        remark: '沁脾清甜',
        month_sale: 200,
        price: 16,
        discount: 14,
        image: $r('app.media.balenailv'),
        daoshou: 14
      },
      {
        goodsid: 403,
        name: '奶绿装忙',
        month_sale: 200,
        price: 17,
        discount: 15,
        image: $r('app.media.nailvzhuangmang'),
        daoshou: 15
      },
      {
        goodsid: 404,
        name: '茶冻桃喜奶青',
        month_sale: 200,
        price: 16,
        discount: 14,
        image: $r('app.media.chadongtaoxinaiqing'),
        daoshou: 14
      },
    ]
  }

]
