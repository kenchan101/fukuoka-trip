# 福岡・由布院 旅行助手（個人自用）

一個用 Flutter 寫的個人旅行 App，主題是 **福岡・由布院 5日4夜**。

## 功能
- **行程**：卡通動態首頁 + 航班 + 每日行程時間軸 + 五日一覽
- **住宿**：住宿卡片與狀態
- **待辦**：出發前 checklist（可勾選）
- **記帳**：預算估算（日幣 / 台幣）
- **更多**：緊急聯絡、實用日文、退稅、交通票券、天氣、關於

## 開發方式（純雲端）
本機不需要安裝 Flutter。專案的 `android/` 與 `web/` 由 GitHub Actions 自動產生。

- 推送到 `main` 分支後，GitHub Actions 會：
  1. 編譯 **release APK** → 在 Actions 頁面下載 `fukuoka-trip-apk`
  2. 編譯 **網頁版** → 部署到 GitHub Pages（可在手機瀏覽器即時預覽）

## 目錄結構
```
lib/
  main.dart                 主程式與分頁
  theme.dart                色彩與主題
  data/trip_data.dart       所有行程資料（改這個就能改內容）
  widgets/common.dart       共用小元件
  widgets/hero_card.dart    動態卡通首頁
  screens/                  各分頁畫面
```

## 改內容
大部分內容都在 `lib/data/trip_data.dart`，改完 push 就會自動重新編譯。
