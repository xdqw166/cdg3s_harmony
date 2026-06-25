import hilog from "@ohos.hilog"
import { ClassificationRootDataSource } from "../data/ClassificationRootDataSource"
import { Classification } from "../data/entity"

const DOMAIN = 0x0002

@Component
export struct ClassificationContent {
  @State selection: number = 0
  @State private rootDataSource: ClassificationRootDataSource = new ClassificationRootDataSource()

  @Builder
  buildClassification(index: number, name: string | Resource) {
    Row() {
      Column()
        .backgroundColor(index == this.selection ? $r('app.color.theme') : Color.Transparent)
        .width(3)
        .height(20)
      Blank().width(10)
      Text(name)
        .fontColor(index == this.selection ? $r('app.color.font') : $r('app.color.font_sub'))
        .layoutWeight(1)
        .textAlign(TextAlign.Start)
        .fontWeight(index == this.selection ? FontWeight.Medium : FontWeight.Normal)
    }
    .onClick(() => {
      this.selection = index
      hilog.info(DOMAIN, 'select', `selected index: ${index}`)
    })
    .height(50)
  }

  @Builder
  buildClassificationContent() {

  }

  build() {
    Column() {
      Row() {
        Row() {
          Image($r('app.media.search'))
            .height('100%')
            .objectFit(ImageFit.Auto)
            .padding(5)
            .margin({ left: 5 })
          Blank().width(3)
          Text('搜索商品')
            .layoutWeight(1)
            .fontColor($r('app.color.font_unimportant'))
        }
        .backgroundColor('#f7f7f7')
        .width('90%')
        .height('30')
        .borderRadius(15)
        .layoutWeight(1)

        Image($r('app.media.message_square_more'))
          .objectFit(ImageFit.Auto)
          .height('100%')
          .padding(15)
      }
      .height(50)
      .padding({ left: 20 })
      .alignItems(VerticalAlign.Center)

      Row() {
        // 左侧
        Scroll() {
          Column() {
            LazyForEach(this.rootDataSource, (item: Classification , index: number) => {
              this.buildClassification(index, item.name)
            })
          }
        }
        .layoutWeight(1)
        .height('100%')
        .scrollBar(BarState.Off)

        // 右侧
        Scroll() {
          Column() {
          }
        }
        .layoutWeight(2)
      }
      .layoutWeight(1)

    }
    .margin({ top: $r("app.integer.safe_area_top") })
  }
}