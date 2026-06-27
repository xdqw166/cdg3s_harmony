@Component
@Preview
export struct Login {
  @State agreement: boolean = false

  build() {
    NavDestination() {
      Flex({
        justifyContent: FlexAlign.Center, // 主轴（水平）居中 [reference:9]
        alignItems: ItemAlign.Center      // 交叉轴（垂直）居中 [reference:10]
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
          Blank().height(20)
          TextInput({
            placeholder: '请输入密码'
          })
            .margin({left: 30, right: 30})
            .height(50)
            .width('100%')
            .type(InputType.Password)
          Blank().height(20)
          Row() {
            Radio({ group: "agreement", value: "agreement" })
              .onChange((isChecked: boolean) => {
                this.agreement = isChecked
              })
            Blank().width(10)
            Text('已阅读并同意本应用用户协议 隐私政策、小米账号用户协议 隐私政策')
              .layoutWeight(1)
              .fontColor($r('app.color.font_sub'))
          }
          Blank().height(50)
          Button('登录')
            .height(50)
            .width('100%')
            .backgroundColor($r('app.color.theme'))
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              if (!this.agreement) {

              } else {

              }
            })
          Blank().height(20)
          Button('注册')
            .height(50)
            .width('100%')
            .backgroundColor('#f4f5f5')
            .fontColor($r('app.color.font'))
            .fontWeight(FontWeight.Medium)
        }
      }
      .width('100%')
      .height('100%')
      .padding(30)
    }
    .hideToolBar(true)
  }
}