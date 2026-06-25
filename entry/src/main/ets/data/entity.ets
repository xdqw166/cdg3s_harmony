export interface GoodsInfo {
  id: number
  uid?: string
  name: string | Resource
  price: number
  originalPrice?: number
  isStartingPrice: boolean
  image: string | Resource
  desc: string | Resource
}

export interface Classification {
  id: number,
  name: string
}