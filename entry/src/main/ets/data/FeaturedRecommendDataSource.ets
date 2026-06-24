import { GoodsInfo } from './type';

export class FeaturedRecommendDataSource implements IDataSource {
  private dataArray: GoodsInfo[] = [
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
  private listeners: DataChangeListener[] = []

  totalCount(): number {
    return this.dataArray.length
  }

  getData(index: number): GoodsInfo {
    return this.dataArray[index]
  }

  getDataArray(): GoodsInfo[] {
    return this.dataArray
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener)
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener)
    if (pos >= 0) {
      this.listeners.splice(pos, 1)
    }
  }

  public pushData(items: GoodsInfo[]) {
    this.dataArray.push(...items)
    this.notifyDataAdd(this.dataArray.length - items.length)
  }

  private notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index)
    })
  }
}