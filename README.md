# Game Catalogue V.3
<img src="https://app.travis-ci.com/dimasnugroho673/Dolanan-Game-Catalogue3.svg?branch=main" />

</br>

Aplikasi ini merupakan katalog game berbasis `iOS` native yang dibangun dengan `SwiftUI 2.0`. Aplikasi ini mengambil data game melalui API yang disediakan oleh [`RAWG`](https://rawg.io/).

## Implementasi Teknis Pada Project

- [x] Clean Architecture
- [x] Reactive pattern menggunakan [`RxSwift`](https://github.com/ReactiveX/RxSwift).
- [x] Modularization (modul core terdapat pada [`repository ini`](https://github.com/dimasnugroho673/Dolanan-Game-Catalogue3-Module-Core)).
- [x] Unit test.
- [x] Continous Integration with Travis CI

## Features
- [x] List game popular
- [x] List creator game
- [x] Detail game dan Creator
- [x] Preview screenshot
- [x] Pencarian game
- [x] Bookmark game menggunakan data persistence
- [x] Like Game menggunakan data persistence
- [x] Edit profile
- [ ] Menampilkan game favorit pada Widget homescreen
- [ ] Unduh katalog data pada saat offline menggunakan data persistence

## Tools

- Xcode 12.5.1
- Swift 5
- SwiftUI 2.0
- iOS 15.4 (testing device)


## Third Party Library

- [`RxSwift`](https://github.com/ReactiveX/RxSwift)
- [`Alamofire`](https://github.com/Alamofire/Alamofire)
- [`SDWebImageSwiftUI 2.0.2`](https://github.com/SDWebImage/SDWebImageSwiftUI) 
- [`Realm Database`](https://github.com/realm/realm-cocoa)

## Screenshot

![Screenshot](https://raw.githubusercontent.com/dimasnugroho673/Dolanan-Game-Catalogue/main/Screenshots/screenshot_v1.png)

