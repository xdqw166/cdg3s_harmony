import { HomeContent } from './HomeContent';

@Entry
@Component
struct Index {
  @State currentTabIndex: number = 0

  @Provide navPathStack: NavPathStack = new NavPathStack()

  @Builder
  buildTabBar(
    icon: string | Resource,
    selectedIcon: string | Resource,
    text: string | Resource,
    index: number
  ) {
    Column() {
      Image(this.currentTabIndex == index ? selectedIcon : icon).width(19)
      Text(text).fontSize(11)
    }
  }

  build() {
    Navigation(this.navPathStack) {
      Tabs() {
        TabContent() {
          HomeContent()
        }
        .tabBar(this.buildTabBar(
          $r("app.media.house"),
          $r("app.media.house_highlight"),
          "首页",
          0
        ))

        TabContent() {
          Text("分类内容")
        }
        .tabBar(this.buildTabBar(
          $r("app.media.layout_list"),
          $r("app.media.layout_list_highlight"),
          "分类",
          1
        ))

        TabContent() {
          Text("服务内容")
        }
        .tabBar(this.buildTabBar(
          $r("app.media.heart"),
          $r("app.media.heart_highlight"),
          "服务",
          2
        ))

        TabContent() {
          Text("购物车内容")
        }
        .tabBar(this.buildTabBar(
          $r("app.media.shopping_cart"),
          $r("app.media.shopping_cart_highlight"),
          "购物车",
          3
        ))

        TabContent() {
          Text('我的内容')
        }
        .tabBar(this.buildTabBar(
          $r("app.media.user_round"),
          $r("app.media.user_round_highlight"),
          "我的",
          4
        ))
      }
      .barPosition(BarPosition.End)
      .barBackgroundColor($r("app.color.background"))
      .animationDuration(0)
      .onChange((index: number) => {
        this.currentTabIndex = index;
      })
    }
    .hideToolBar(true)
    .mode(NavigationMode.Stack)
  }
}