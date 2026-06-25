import { LengthUnit } from "@kit.ArkUI"
import { GoodsInfo } from "../data/entity"
import hilog from "@ohos.hilog"
import { FeaturedRecommendDataSource } from "../data/FeaturedRecommendDataSource"

const DOMAIN = 0x0001

@Component
export struct HomeMainPageContent {
  // ad5 是手机端图片，其余非手机端
  @State ads: string[] | Resource[] = [
    $r("app.media.ad1"),
    $r("app.media.ad2"),
    $r("app.media.ad3"),
    $r("app.media.ad5")
  ]
  @State isDarkAdBg: boolean[] = [
    true,
    false,
    false,
    false
  ]
  // 理论上没有背景色，因为手机端的图片直接填充整个 Swiper
  // 这里使用是因为使用的图片尺寸与手机端不同，为保持观感添加的
  @State AdsBg: string[] | Resource = [
    "#000000",
    "#F7F7F7",
    "#F7F7F7",
    "#F7F7F7"
  ]
  @State currentAdIndex: number = 0
  @State searches: string[] | Resource[] = [
    "搜索条目 1",
    "搜索条目 2",
    "搜索条目 3"
  ]
  @State objectItemImages: string[] | Resource[] = [
    $r("app.media.icon_yjhx"),
    $r("app.media.icon_xrfl"),
    $r("app.media.icon_znjj"),
    $r("app.media.icon_rcj"),
    $r("app.media.icon_znsh"),
    $r("app.media.icon_xszx"),
    $r("app.media.icon_mqxq"),
    $r("app.media.icon_shdq"),
    $r("app.media.icon_scsl"),
    $r("app.media.icon_sqk"),
    $r("app.media.icon_gjbt"),
    $r("app.media.icon_ds"),
    $r("app.media.icon_sj"),
    $r("app.media.icon_xmsx"),
    $r("app.media.icon_xmrb"),
    $r("app.media.icon_zncd"),
    $r("app.media.icon_dnpp"),
    $r("app.media.icon_kbx"),
    $r("app.media.icon_xmzc"),
    $r("app.media.icon_xmfb")
  ]
  @State objectItemText: string[] | Resource[] = [
    "以旧换新",
    "新人福利",
    "智能家居",
    "人车家",
    "智能生活",
    "学生专享",
    "米圈星球",
    "生活电器",
    "商城送礼",
    "省钱卡",
    "国家补贴",
    "电视",
    "手机",
    "小米上新",
    "小米热榜",
    "智能穿戴",
    "电脑/平板",
    "空冰洗",
    "小米众筹",
    "小米发布"
  ]
  @State currentSearchIndex: number = 0
  @State isScrolledUpSomeDistance: boolean = false
  @State totalScrollOffset: number = 0
  @State recommendItems: Record<string, string | Resource>[] = [
    {
      "title": "智慧厨房",
      "subtitle": "国补至高优惠15%",
      "image": $r("app.media.icon_zhcf")
    },
    {
      "title": "青春运动季",
      "subtitle": "限时限量抢好礼",
      "image": $r("app.media.icon_qcydj")
    }
  ]
  @State popularPhones: Record<string, string | Resource>[] = [
    {
      "name": "Xiaomi 17 Max",
      "desc": "至高享12期免息 >",
      "image": $r("app.media.phone_xiaomi_17_max")
    },
    {
      "name": "REDMI 17C",
      "desc": "至高优惠200元 >",
      "image": $r("app.media.phone_redmi_17c")
    },
    {
      "name": "Note 15 系列",
      "desc": "到手价999元起 >",
      "image": $r("app.media.phone_note_15_series")
    },
    {
      "name": "K90",
      "desc": "至高优惠300元 >",
      "image": $r("app.media.phone_k90")
    },
    {
      "name": "Turbo 5 Max",
      "desc": "至高优惠200元 >",
      "image": $r("app.media.phone_turbo_5_max")
    }
  ]
  @State swiperSmartGadgets: Record<string, string | Resource>[] = [
    {
      "name": "强劲风Pro超1.5匹",
      "desc": "强性能旗舰冷暖实力强一档",
      "image": $r("app.media.qjf_pro_c1_5p")
    },
    {
      "name": "561L对开",
      "desc": "全域离子净化",
      "image": $r("app.media.561ldk")
    },
    {
      "name": "室外摄像机4 4G双摄",
      "desc": "免费流量 双500万像素",
      "image": $r("app.media.swsxj4_4gss")
    },
    {
      "name": "REDMI G24Q",
      "desc": "24英寸2K高清显示器",
      "image": $r("app.media.redmi_g24q")
    }
  ]
  @State smartGadgets: Record<string, string | Resource>[] = [
    {
      "name": "强劲风Pro",
      "desc": "至高补贴15%",
      "image": $r("app.media.qjf_pro_c1_5p")
    },
    {
      "name": "561L对开",
      "desc": "国补至高享85折",
      "image": $r("app.media.561ldk")
    },
    {
      "name": "4G双摄",
      "desc": "AI智能识别",
      "image": $r("app.media.swsxj4_4gss")
    },
    {
      "name": "REDMI G24Q",
      "desc": "下单赠送机械键盘",
      "image": $r("app.media.redmi_g24q")
    }
  ]
  @State private FeaturedRecommendDataSource: FeaturedRecommendDataSource = new FeaturedRecommendDataSource()
  @Consume navPathStack: NavPathStack
  onAdBgChange?: (isDark: boolean) => void
  onScrolledUpSomeDistance ?: (isMoreThan: boolean) => void
  private timer: number = -1
  private adsOffset: number = 120

  aboutToAppear() {
    // 启动定时器，每隔 3 秒切换索引
    this.timer = setInterval(() => {
      this.currentSearchIndex = (this.currentSearchIndex + 1) % this.searches.length
    }, 3000)
    // 初始化父级 Tab 文字颜色是否反转
    if (this.onAdBgChange) {
      this.onAdBgChange(this.isDarkAdBg[0])
    }
  }

  aboutToDisappear() {
    // 组件销毁时清除定时器
    if (this.timer !== -1) {
      clearInterval(this.timer)
      this.timer = -1
    }
  }

  @Builder
  buildSearchBar() {
    Column() {
      Row() {
        Row() {
          Image($r("app.media.scan_line"))
            .height("80%")
            .padding({ left: 3 })
          Text(this.searches[this.currentSearchIndex])
            .fontSize(14)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)
            .padding({ left: 8, right: 8 })
          Button("搜索")
            .width(60)
            .borderRadius(7)
            .backgroundColor($r("app.color.theme"))
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .margin(3)
      }
      .width("90%")
      .height(30)
      .backgroundColor($r("app.color.background"))
      .border({
        width: 1,
        color: $r("app.color.theme"),
      })
      .borderRadius(10)
    }
    .backgroundColor(this.isScrolledUpSomeDistance ? $r("app.color.background") : Color.Transparent)
    .width("100%")
    .layoutGravity(LocalizedAlignment.CENTER)
    .animation({ duration: 0 }) // 由于父组件 Tab 背景色变更难以实现动画，这里暂时设为 0
    .padding({ bottom: 5 })
  }

  @Builder
  buildAds() {
    Swiper() {
      ForEach(this.ads, (item: string | Resource, index: number) => {
        Row() {
          Image(item)
            .width("100%")
            .objectFit(ImageFit.Auto)
        }
        .height(200 + this.adsOffset)
        .alignItems(VerticalAlign.Bottom)
        .background(this.AdsBg[index])
      })
    }
    .autoPlay(true)
    .onChange((index: number) => {
      this.currentAdIndex = index
    })
    .onAnimationStart((_index: number, targetIndex: number) => {
      if (this.onAdBgChange) {
        this.onAdBgChange(this.isDarkAdBg[targetIndex])
      }
    })
  }

  @Builder
  buildObjectItemBar() {
    Scroll() {
      Grid() {
        ForEach(this.objectItemImages, (image: string | Resource, index: number) => {
          this.buildObjectItem(image, this.objectItemText[index])
        })
      }
      .columnsTemplate(Array(10).fill('1fr').join(' '))
      .rowsTemplate("1fr 1fr")
      .height(200)
      .width("190%")
    }
    .scrollable(ScrollDirection.Horizontal)
    .width("100%")
    .margin({ left: 5, right: 5 })
    .scrollBar(BarState.On)
    .scrollBarMargin({
      start: { value: 135, unit: LengthUnit.VP },
      end: { value: 135, unit: LengthUnit.VP }
    })
  }

  @Builder
  buildObjectItem(
    image: string | Resource,
    title: string | Resource
  ) {
    Column() {
      Image(image).height(75).objectFit(ImageFit.Auto).margin(-5)
      Text(title).fontSize(11)
    }
    .margin(10)
  }

  @Builder
  buildRecommendCard() {
    Stack() {
      Image($r("app.media.ad_hdplr"))
        .height("100%")
        .layoutGravity(LocalizedAlignment.START)
        .borderRadius(10)

      // 遮罩
      Column()
        .borderRadius(10)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [["#ff888888", 0], ["#00ffffff", 1]]
        })
        .height("100%")
        .width("100%")
      Column()
        .borderRadius(10)
        .linearGradient({
          direction: GradientDirection.Left,
          colors: [["#ff888888", 0.4], ["#00ffffff", 1]]
        })
        .height("100%")
        .width("100%")

      Column() {
        Text("黑电品类日")
          .fontWeight(FontWeight.Bold)
        Text("限量立减至高100元 >")
          .fontSize(11)
          .margin({ top: 3 })
      }
      .layoutGravity(LocalizedAlignment.TOP_START)
      .alignItems(HorizontalAlign.Start)
      .margin({
        left: 10,
        top: 10
      })

      Row() {
        ForEach(this.recommendItems, (item: Record<string, string | Resource>) => {
          this.buildRecommendCardItem(
            item["title"],
            item["subtitle"],
            item["image"]
          )
        })
      }
      .height("100%")
      .width("60%")
      .layoutGravity(LocalizedAlignment.END)
    }
    .height(130)
    .width("100%")
    .clip(true)
  }

  @Builder
  buildRecommendCardItem(
    title: string | Resource,
    subtitle: string | Resource,
    image: string | Resource
  ) {
    Column() {
      Text(title)
        .fontWeight(FontWeight.Medium)
        .fontSize(12)
      Text(subtitle)
        .fontSize(10)
        .margin({ top: 2 })
        .fontColor($r("app.color.font_sub"))
      Image(image)
        .align(Alignment.Bottom)
        .margin(-2)
        .layoutWeight(1)
    }
    .width(90)
    .padding(5)
    .margin({ top: 10, bottom: 10, right: 10 })
    .borderRadius(5)
    .backgroundColor("#ffffff")
    .layoutWeight(1)
  }

  @Builder
  buildTitle(
    title: string | Resource,
    hasMore: boolean = true
  ) {
    Row() {
      Text(title).fontWeight(FontWeight.Medium)
      Blank().layoutWeight(1)
      if (hasMore) {
        Text("更多 >").fontSize(14).fontColor($r("app.color.font_sub"))
      }
    }
    .margin({
      top: 10,
      bottom: 5
    })
  }

  @Builder
  buildPopularPhones() {
    this.buildTitle("人气手机")
    Stack() {
      Row() {
        this.buildMostPopularPhone(this.popularPhones[0])
        this.buildMostPopularPhone(this.popularPhones[1])
      }
      .layoutGravity(LocalizedAlignment.TOP)

      Row() {
        this.build2ndPopularPhone(this.popularPhones[2])
        this.build2ndPopularPhone(this.popularPhones[3])
        this.build2ndPopularPhone(this.popularPhones[4])
      }
      .backgroundColor("#ccffffff")
      .margin(10)
      .height(100)
      .width("100%")
      .borderRadius(10)
      .layoutGravity(LocalizedAlignment.BOTTOM)
      .backdropBlur(20)
    }
    .width("100%")
    .height(270)
    .backgroundColor($r("app.color.popular_phone_bg"))
    .borderRadius(10)
    .padding({ left: 10, right: 10 })
  }

  @Builder
  buildMostPopularPhone(phone: Record<string, string | Resource>) {
    Column() {
      Text(phone["name"])
        .fontWeight(FontWeight.Bold)
        .fontSize(18)
      Column() {
        Text(phone["desc"])
          .fontSize(12)
      }
      .borderRadius(100)
      .borderWidth(1)
      .width("100%")
      .padding({ top: 5, bottom: 5 })
      .margin({ top: 5 })

      Image(phone["image"])
        .layoutWeight(1)
        .width("100%")
        .objectFit(ImageFit.Auto)
        .padding({ left: 10, right: 10 })
    }
    .width("50%")
    .height("75%")
    .padding({
      left: 10,
      right: 10,
      top: 20
    })
  }

  @Builder
  build2ndPopularPhone(phone: Record<string, string | Resource>) {
    Column() {
      Image(phone["image"])
        .layoutWeight(1)
        .height("100%")
        .objectFit(ImageFit.Auto)
      Text(phone["name"])
        .fontSize(11)
      Text(phone["desc"])
        .fontSize(10)
        .fontColor($r("app.color.font_sub"))
        .margin({ top: 1 })
    }
    .layoutWeight(1)
    .padding(10)
  }

  @Builder
  buildSmartGadgets() {
    this.buildTitle("智能好物")
    Grid() {
      GridItem() {
        Swiper() {
          ForEach(this.swiperSmartGadgets, (item: Record<string, string | Resource>) => {
            Column() {
              Text(item["name"])
                .fontWeight(FontWeight.Medium)
                .fontSize(13)
              Blank().height(4)
              Text(item["desc"])
                .fontSize(10)
                .fontColor($r("app.color.font_sub"))
              Blank().height(4)
              Text("立即查看 >")
                .fontSize(10)
              Image(item["image"])
                .layoutWeight(1)
            }
            .padding(20)
            .onClick(() => {
              this.navPathStack.pushPathByName("GoodsDetails", null)
            })
          })
        }
        .autoPlay(true)
      }
      .columnStart(0)
      .columnEnd(0)
      .rowStart(0)
      .rowEnd(1)
      .backgroundColor($r("app.color.smart_gadget_bg"))
      .borderRadius(10)

      ForEach(this.smartGadgets, (item: Record<string, string | Resource>) => {
        GridItem() {
          Row() {
            Column() {
              Text(item["name"])
                .fontWeight(FontWeight.Medium)
                .fontSize(13)
              Blank().height(4)
              Text(item["desc"])
                .fontSize(10)
                .fontColor($r("app.color.font_sub"))
              Blank().height(4)
              Text("立即查看 >")
                .fontSize(10)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(2)

            Image(item["image"])
              .layoutWeight(1)
          }
          .backgroundColor($r("app.color.smart_gadget_bg"))
          .borderRadius(10)
          .height("100%")
          .padding(5)
        }
      })
    }
    .columnsTemplate("1fr 1fr")
    .rowsTemplate("1fr 1fr 1fr")
    .width("100%")
    .height(300)
    .columnsGap(5)
    .rowsGap(5)
  }

  @Builder
  buildFeaturedRecommendations() {
    this.buildTitle("精选推荐", false)
    WaterFlow() {
      LazyForEach(this.FeaturedRecommendDataSource,
        (item: GoodsInfo) => {
          FlowItem() {
            Column() {
              Image(item.image)
                .width("100%")
                .objectFit(ImageFit.Auto)
              Column() {
                Text(item.name)
                  .fontWeight(FontWeight.Medium)
                Text(item.desc)
                  .fontSize(11)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .fontColor($r("app.color.font_sub"))
                Blank().height(10)
                Row() {
                  Text(`￥${item.price}`)
                    .fontWeight(FontWeight.Medium)
                  if (item.isStartingPrice) {
                    Text("起")
                      .fontSize(13)
                      .fontWeight(FontWeight.Medium)
                  }
                  if (item.originalPrice) {
                    Blank().width(2)
                    Text(`￥${item.originalPrice}`)
                      .fontSize(14)
                      .fontColor($r("app.color.font_unimportant"))
                      .decoration({
                        type: TextDecorationType.LineThrough,
                        color: $r("app.color.font_unimportant")
                      })
                  }
                  Blank().layoutWeight(1)
                }
                .alignItems(VerticalAlign.Bottom)
              }
              .alignItems(HorizontalAlign.Start)
              .backgroundColor("#f8f8f8")
              .width("100%")
              .padding(10)
            }
          }
          .backgroundColor($r("app.color.background"))
          .borderRadius(10)
        },
        (item: GoodsInfo) => item.uid
      )
    }
    .columnsTemplate("1fr 1fr")
    .columnsGap(10)
    .rowsGap(10)
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Scroll() {
        Column() {
          this.buildAds()
          Column() {
            this.buildObjectItemBar()
            this.buildRecommendCard()
            this.buildPopularPhones()
            this.buildSmartGadgets()
          }
          .width("100%")
          .padding({
            left: 10,
            right: 10
          })

          Stack({ alignContent: Alignment.Top }) {
            Column()
              .linearGradient({
                colors: [[$r("app.color.background"), 0], [$r("app.color.bg_gradient"), 1]]
              })
              .width("100%")
              .height(100)
            Column() {
              this.buildFeaturedRecommendations()
            }
            .padding({ left: 10, right: 10 })
          }
          .backgroundColor("#f3f3f3")
        }
        .width("100%")
      }
      .onDidScroll((_xOffset: number, yOffset: number) => {
        this.totalScrollOffset += yOffset
        this.isScrolledUpSomeDistance = this.totalScrollOffset >= 50
        if (this.onScrolledUpSomeDistance) {
          this.onScrolledUpSomeDistance(this.isScrolledUpSomeDistance)
        }
      })
      .margin({ top: -this.adsOffset })
      .scrollBar(BarState.Off)
      .onReachEnd(() => {
        this.FeaturedRecommendDataSource.loadMore()
        hilog.info(DOMAIN, "load", "loading content")
      })

      // 固定搜索栏
      Column() {
        this.buildSearchBar()
      }
    }
    .width("100%")
    .height("100%")
  }
}