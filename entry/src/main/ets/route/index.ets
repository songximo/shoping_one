import { Router } from '@kit.ArkUI';
export  class  RoutePath{
  static  readonly  FiringPage = 'pages/AppFiringPage'
  static  readonly  MainPage = 'pages/MainPage'
  static  readonly  IndexPage = 'pages/Index'
  static  readonly  YidiandianPage = 'pages/shops/YidiandianPage'
  static  readonly  MessageDetailPage = 'pages/messagedetail/MessageDetailPage'
  static  readonly  MyPage = 'MyPage'
}
// 注册路由
// Router.registerRoute(RoutePath.YidiandianPage, () => import('../pages/shop/YidiandianPage'));