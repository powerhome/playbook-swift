
[!Currency-Alignment](https://github.com/powerhome/playbook-swift/assets/112719604/d74a9c5a-c606-4cd0-bf70-20e9297ec246)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  HStack {
    PBCurrency(
      amount: "2,000",
      decimalAmount: ".50",
      label: "left",
      size: .title4,
      symbol: "en_US",
      isEmphasized: true,
      alignment: .leading
    )
  }
  .frame(maxWidth: .infinity, alignment: .leading)
  HStack {
    PBCurrency(
      amount: "342",
      decimalAmount: ".00",
      label: "center",
      size: .title4,
      symbol: "en_EU",
      isEmphasized: true,
      alignment: .center
    )
  }
  .frame(maxWidth: .infinity, alignment: .center)
  HStack {
    PBCurrency(
      amount: "45",
      label: "right",
      size: .title4,
      symbol: "en_US",
      unit: "/mo",
      isEmphasized: true,
      hasUnit: true,
      alignment: .trailing
    )
  }
  .frame(maxWidth: .infinity, alignment: .trailing)
}
```
