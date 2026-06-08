import { router } from '@kit.ArkUI'
import { RoutePath } from '../route'

@Entry
@Component
struct AppFiringPage {
  // @State message: string = '启动页面';

  aboutToAppear(): void {
    setTimeout(()=>{
      router.replaceUrl({url:RoutePath.MainPage})
    },3000)
  }

  build() {
    Stack(){
      Image($r('app.media.welcome')).objectFit(ImageFit.Fill).interpolation(ImageInterpolation.High)
    }.width('100%').height('100%').backgroundColor($r('app.color.start_window_background'))
    .alignContent(Alignment.Center)


  }
}