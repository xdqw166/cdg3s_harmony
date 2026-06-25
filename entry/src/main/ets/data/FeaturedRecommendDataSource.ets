import { BaseDataSource } from './BaseDataSource';
import { GoodsInfo } from './entity';

export class FeaturedRecommendDataSource extends BaseDataSource<GoodsInfo> {
  private dataSpanShot: GoodsInfo[]
  private uidCounter: number = 0  // 唯一 id 计数器

  constructor() {
    super()

    const fakeData: GoodsInfo[] = [
      {
        id: 0,
        name: "Xiaomi 17 Max",
        desc: "至高享12期免息 >",
        image: $r("app.media.phone_xiaomi_17_max"),
        price: 9999,
        isStartingPrice: false
      },
      {
        id: 1,
        name: "REDMI 17C",
        desc: "至高优惠200元 >",
        image: $r("app.media.phone_redmi_17c"),
        price: 8888,
        isStartingPrice: true
      },
      {
        id: 2,
        name: "Note 15 系列",
        desc: "到手价999起",
        image: $r("app.media.phone_note_15_series"),
        price: 7777,
        originalPrice: 8889,
        isStartingPrice: false
      },
      {
        id: 3,
        name: "强劲风Pro超1.5匹",
        desc: "强性能旗舰冷暖实力强一档",
        image: $r("app.media.qjf_pro_c1_5p"),
        price: 6666,
        originalPrice: 7659,
        isStartingPrice: true
      },
      {
        id: 4,
        name: "室外摄像机4 4G双摄像头监控",
        desc: "免费流量 双500万像素",
        image: $r("app.media.swsxj4_4gss"),
        price: 5555,
        isStartingPrice: false
      },
      {
        id: 5,
        name: "K90",
        desc: "至高优惠300元 >",
        image: $r("app.media.phone_k90"),
        price: 4567,
        isStartingPrice: false
      }
    ]
    this.data.push(...fakeData)

    // 如果原始数据没有 uid，这里补上
    this.data.forEach((item) => {
      item.uid = `${this.uidCounter++}`

    })
    this.dataSpanShot = this.data
  }

  public pushData(items: GoodsInfo[]) {
    this.data.push(...items)
    this.notifyDataAdd(items.length)
  }

  private notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index)
    })
  }

  // 加载更多
  public loadMore(): void {
    let newArray: GoodsInfo[] = []
    for (let index = 0; index < this.dataSpanShot.length; index++) {
      let element: GoodsInfo = this.dataSpanShot[index];
      element.uid = `${this.uidCounter++}`
      newArray.push(element)
    }
    this.pushData(newArray)
  }
}