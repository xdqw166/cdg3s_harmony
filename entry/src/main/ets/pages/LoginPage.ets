import { login } from '../network/login'
import { isBlank } from '../utils/base'
import { showToast } from '../utils/ui'

@Component
struct LoginPage {
  @State agreement: boolean = false
  @State username: string = ''
  @State psw: string = ''

  @Consume navPathStack: NavPathStack

  build() {
    NavDestination() {
      Flex({
        justifyContent: FlexAlign.Center,
        alignItems: ItemAlign.Center
      }) {
        Column() {
          Image($r('app.media.startIcon'))
            .width(50)
            .height(50)
          Blank().height(30)
          Text('小米账号登录')
          Blank().height(50)
          TextInput({
            placeholder: '请输入用户名'
          })
            .margin({left: 30, right: 30})
            .height(50)
            .width('100%')
            .onChange((userName: string) => {
              this.username = userName
            })
          Blank().height(20)
          TextInput({
            placeholder: '请输入密码'
          })
            .margin({left: 30, right: 30})
            .height(50)
            .width('100%')
            .type(InputType.Password)
            .onChange((psw: string) => {
              this.psw = psw
            })
          Blank().height(20)
          Row() {
            Checkbox({ name: 'agreement', group: 'agreement' })
              .onChange((isSelected: boolean) => {
                this.agreement = isSelected
              })
            Blank().width(10)
            Text('已阅读并同意本应用用户协议 隐私政策、小米账号用户协议 隐私政策')
              .layoutWeight(1)
              .fontColor($r('app.color.font_sub'))
              .fontSize(14)
          }
          Blank().height(50)
          Button('登录')
            .height(50)
            .width('100%')
            .backgroundColor($r('app.color.theme'))
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              login({
                username: this.username,
                password: this.psw,
                onSuccess: (msg: string) => {
                  showToast(msg, this.getUIContext())
                  this.navPathStack.pop()
                },
                onFail: (msg: string) => {
                  showToast(msg, this.getUIContext())
                }
              })
            })
            .enabled(this.agreement && !isBlank(this.username) && !isBlank(this.psw))
          Blank().height(20)
          Button('注册')
            .height(50)
            .width('100%')
            .backgroundColor('#f4f5f5')
            .fontColor($r('app.color.font'))
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.navPathStack.pushPathByName('Register', null)
            })
        }
      }
      .width('100%')
      .height('100%')
      .padding(30)
    }
    .hideToolBar(true)
    .padding({top: $r('app.integer.safe_area_top')})
  }
}

@Builder
export function LoginPageBuilder() {
  LoginPage()
}

@Component
@Preview
struct LoginPagePreview {
  @Provide navPathStack: NavPathStack = new NavPathStack()
  build() {
    LoginPage()
  }
}