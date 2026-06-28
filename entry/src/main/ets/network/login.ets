import { HOST } from "../config"
import { http } from "@kit.NetworkKit"
import { LoginRequest, LoginResponse } from "./dto"

export interface LoginAttr {
  username: string
  password: string
  onSuccess?: (msg: string) => void
  onFail?: (msg: string) => void
}

export function login(attr: LoginAttr) {
  const url = `http://${HOST}/auth/login`
  const httpRequest = http.createHttp()

  const requestData: LoginRequest = {
    username: attr.username,
    password: attr.password
  }

  httpRequest.request(url, {
    method: http.RequestMethod.POST,
    header: {
      'Content-Type': 'application/json'
    },
    extraData: JSON.stringify(requestData)
  }, (err: BusinessError, res: http.HttpResponse) => {
    httpRequest.destroy()

    if (err) {
      if (attr.onFail) attr.onFail(`网络错误：${err.message}`)
      return
    }
    try {
      const response = JSON.parse(res.result as string) as LoginResponse
      if (response.success && response.token) {
        if (attr.onSuccess) attr.onSuccess(response.message || '登录成功')
      } else {
        if (attr.onFail) attr.onFail(response.message || '登录失败')
      }
    } catch (e) {
      if (attr.onFail) attr.onFail(`登录失败：${e}`)
    }
  })
}