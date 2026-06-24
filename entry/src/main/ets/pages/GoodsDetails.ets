@Component
export struct GoodDetails {
  @Consume navPathStack: NavPathStack

  build() {
    NavDestination() {
      Column() {
        Text('商品详情')
      }
    }
    .padding({top: $r("app.integer.safe_area_top")})
  }
}

@Builder
export function GoodDetailsPageBuilder() {
  GoodDetails()
}