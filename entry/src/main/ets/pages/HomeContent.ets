import { setWindowSystemBarColor } from "../utils"
import { HomeMainPageContent } from "./HomeMainPageContent"

@Component
export struct HomeContent {
  @State currentTabIndex: number = 0 // 当前选中的Tab索引
  @State @Watch("onNeedFontColorReverseChange") needFontColorReverse: boolean = false // 是否需要反转字体颜色
  @State @Watch("onNeedShowTabBg") needShowTabBg: boolean = false // 是否需要显示Tab背景颜色
  @State tabBgColor: string | Resource = "#ffffff" // Tab背景色（暂未使用）

  aboutToAppear() {
    setWindowSystemBarColor(this.needFontColorReverse && !this.needShowTabBg ? "#ffffff" : "#000000")
  }

  onNeedFontColorReverseChange() {
    setWindowSystemBarColor(this.needFontColorReverse && !this.needShowTabBg ? "#ffffff" : "#000000")
  }

  onNeedShowTabBg() {
    setWindowSystemBarColor(this.needFontColorReverse && !this.needShowTabBg ? "#ffffff" : "#000000")
  }

  @Builder
  buildTabBar(
    text: string | Resource,
    index: number,
    fontColor: string | Resource = "#000000",
    fontColorReverse: string | Resource = "#ffffff",
  ) {
    Column() {
      Text(text).fontSize(19)
        .fontColor(this.needFontColorReverse && !this.needShowTabBg ? fontColorReverse : fontColor)
      Row() // 底部指示器（小横条）
        .width(15)
        .height(3)
        .backgroundColor(
          this.currentTabIndex == index
            ? (this.needFontColorReverse && !this.needShowTabBg ? fontColorReverse : fontColor)
            : '#0000000'
        )
        .borderRadius(1.5)
        .margin({ top: 4 })
    }
  }

  build() {
    Tabs() {
      TabContent() {
        HomeMainPageContent({
          onAdBgChange: (isDark: boolean) => {
            this.needFontColorReverse = isDark
          },
          onScrolledUpSomeDistance: (isMoreThan: boolean) => {
            this.needShowTabBg = isMoreThan
          }
        })
      }
      .tabBar(this.buildTabBar(
        "首页",
        0
      ))
      .clip(false)

      TabContent() {
        Text("手机发布内容")
      }
      .tabBar(this.buildTabBar(
        "手机发布",
        1
      ))

      TabContent() {
        Text("国补内容")
      }
      .tabBar(this.buildTabBar(
        "国补",
        2,
        "#569976",
        "#569976"
      ))
    }
    .onChange((index: number) => {
      this.currentTabIndex = index;
      this.needFontColorReverse = false
      this.needShowTabBg = false
    })
    .barWidth("70%")
    .clip(this.needShowTabBg)
    .margin({top: $r("app.integer.safe_area_top")})
  }
}