export  class TabbarItem{
  index: number = 0
  title: string = ''
  icon_selected: Resource = $r('app.media.ic_sel_index')//选中的图片
  icon_normal: Resource = $r('app.media.ic_unsel_index')//默认图片
}

//tabs显示的tabbar数据
export const tabbarItemList: TabbarItem[] = [
  {
    index: 0,
    title: '首页',
    icon_selected: $r('app.media.ic_sel_index'),
    icon_normal: $r('app.media.ic_unsel_index')
  },
  // {
  //   index: 1,
  //   title: '优选',
  //   icon_selected: $r('app.media.ic_sel_youxuan'),
  //   icon_normal: $r('app.media.ic_unsel_youxuan')
  // },
  {
    index: 1,
    title: '消息',
    icon_selected: $r('app.media.ic_sel_msg'),
    icon_normal: $r('app.media.ic_unsel_msg')
  },
  {
    index: 2,
    title: '我的',
    icon_selected: $r('app.media.ic_sel_my'),
    icon_normal: $r('app.media.ic_unsel_my')
  },


]