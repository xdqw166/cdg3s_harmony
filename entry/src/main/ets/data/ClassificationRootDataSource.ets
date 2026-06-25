import { HOST } from "../config";
import { Classification } from "./entity";
import { http } from "@kit.NetworkKit";
import { hilog } from "@kit.PerformanceAnalysisKit";
import { BaseDataSource } from "./BaseDataSource";

const DOMAIN = 0x0003

export class ClassificationRootDataSource extends BaseDataSource<Classification> {
  constructor() {
    super()

    const url = HOST + "/category/listRoots"
    const httpRequest: http.HttpRequest = http.createHttp()

    httpRequest.request(url, (err: BusinessError, res: http.HttpResponse) => {
      if (err == null) {
        this.data = JSON.parse(res.result as string) as Classification[]

        let msg: string = `获取根分类成功 (${this.data.length})`
        for (let index = 0; index < this.data.length; index++) {
          const element = this.data[index];
          msg += `\n  - ${element.name} (${element.id})`
        }
        hilog.info(DOMAIN, "netService", msg)
      } else {
        hilog.error(DOMAIN, "netService", `获取根分类失败：${err.message}`)
      }
      httpRequest.destroy()
      this.notifyDataRefresh()
    })
  }

  private notifyDataRefresh() {
    this.listeners.forEach(listener => {
      listener.onDataReloaded()
    })
  }
}