export interface GoodsInfo {
  id: number
  name: string | Resource
  price: number
  originalPrice?: number
  isStartingPrice: boolean
  image: string | Resource
  desc: string | Resource
}