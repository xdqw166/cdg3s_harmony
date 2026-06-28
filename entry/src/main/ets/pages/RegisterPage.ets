import { isBlank } from "../utils"
import { hilog } from "@kit.PerformanceAnalysisKit"
import { register } from "../network/register"

const DOMAIN = 0x0006

@Component
struct RegisterPage {
  @State agreement: boolean = false
  @State userName: string = ''
  @State psw1: string = ''
  @State psw2: string = ''
  @State isSamePsw: boolean = true
  @Consume navPathStack: NavPathStack
  private showToast = (message: string) => {
    try {
      this.getUIContext().getPromptAction().showToast({ message })
    } catch (error) {
      hilog.error(DOMAIN, 'winSys', error)
    }
  }

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
          Text('小米账号注册')
          Blank().height(50)
          TextInput({
            placeholder: '请输入用户名'
          })
            .margin({ left: 30, right: 30 })
            .height(50)
            .width('100%')
            .onChange((userName: string) => {
              this.userName = userName
            })
          Blank().height(20)
          TextInput({
            placeholder: '请输入密码'
          })
            .margin({ left: 30, right: 30 })
            .height(50)
            .width('100%')
            .type(InputType.Password)
            .onChange((psw: string) => {
              this.psw1 = psw
              this.isSamePsw = this.psw1 == this.psw2
            })
          Blank().height(20)
          TextInput({
            placeholder: '请再次输入密码'
          })
            .margin({ left: 30, right: 30 })
            .height(50)
            .width('100%')
            .type(InputType.Password)
            .onChange((psw: string) => {
              this.psw2 = psw
              this.isSamePsw = this.psw1 == this.psw2
            })
            .showError(this.isSamePsw ? null : '前后密码不一致')
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
          Button('注册')
            .height(50)
            .width('100%')
            .backgroundColor($r('app.color.theme'))
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              register({
                username: this.userName,
                password: this.psw1,
                onSuccess: (msg: string) => {
                  this.showToast(msg)
                  this.navPathStack.pop()
                },
                onFail: (msg: string) => {
                  this.showToast(msg)
                }
              })
            })
            .enabled(this.isSamePsw && this.agreement && !isBlank(this.psw1) && !isBlank(this.userName))
          Blank().height(20)
          Button('返回登录')
            .height(50)
            .width('100%')
            .backgroundColor('#f4f5f5')
            .fontColor($r('app.color.font'))
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.navPathStack.pop()
            })
        }
      }
      .width('100%')
      .height('100%')
      .padding(30)
    }
    .hideToolBar(true)
    .padding({ top: $r('app.integer.safe_area_top') })
    .hideBackButton(true)
  }
}

@Builder
export function RegisterPageBuilder() {
  RegisterPage()
}

@Component
@Preview
struct RegisterPagePreview {
  @Provide navPathStack: NavPathStack = new NavPathStack()

  build() {
    RegisterPage()
  }
}