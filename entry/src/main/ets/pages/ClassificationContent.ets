import hilog from "@ohos.hilog"
import { ClassificationDataSource, ClassificationRootDataSource } from "../data/ClassificationDataSource"
import { Classification } from "../data/entity"

const DOMAIN = 0x0002

@Component
export struct ClassificationContent {
  @State selection: number = -1
  @State childSelection: number = 0
  @State private rootDataSource: ClassificationRootDataSource = new ClassificationRootDataSource()
  @State private dataSource: ClassificationDataSource = new ClassificationDataSource(-1)

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
      this.childSelection = 0
      if (index >= 0) {
        const selectionId = this.rootDataSource.getData(index).id
        this.dataSource.reloadWithId(selectionId)
        hilog.info(DOMAIN, 'select', `selection id: ${selectionId}`)
      }
    })
    .height(50)
  }

  @Builder
  buildClassificationContent() {
    if (this.selection == -1) {

    } else {
      Column() {
        Scroll() {
          Row() {
            LazyForEach(this.dataSource,
              (item: Classification, index: number) => {
                Text(item.name)
                  .height('100%')
                  .padding({ left: 5, right: 5 })
                  .margin({left: 5, right: 5})
                  .backgroundColor(this.childSelection == index ? '#ececec' : Color.Transparent)
                  .onClick(() => {
                    this.childSelection = index
                  })
                  .fontSize(14)
                  .borderRadius(5)
              },
              (item: Classification) => item.id.toString()
            )
          }
          .alignItems(VerticalAlign.Center)
          .padding({top: 10})
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .height(30)
      }
      .width('100%')
      .layoutWeight(1)
    }
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
            this.buildClassification(-1, "推荐")
            LazyForEach(this.rootDataSource, (item: Classification, index: number) => {
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
            this.buildClassificationContent()
          }
        }
        .layoutWeight(2)
      }
      .layoutWeight(1)
    }
    .margin({ top: $r("app.integer.safe_area_top") })
  }
}