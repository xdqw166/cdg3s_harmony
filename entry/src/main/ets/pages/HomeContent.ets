import { setWindowSystemBarColor } from "../utils/ui"
import { HomeMainPageContent } from "./HomeMainPageContent"

@Component
export struct HomeContent {
  @State currentTabIndex: number = 0
  @State @Watch("onNeedFontColorReverseChange") needFontColorReverse: boolean = false
  @State @Watch("onNeedShowTabBg") needShowTabBg: boolean = false
  @State tabBgColor: string | Resource = "#ffffff"

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
      Text(text).fontSize(19).fontColor(this.needFontColorReverse && !this.needShowTabBg ? fontColorReverse : fontColor)
      Row()
        .width(15)
        .height(3)
        .backgroundColor(this.currentTabIndex == index ? '#ff000000' : '#0000000')
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