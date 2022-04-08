# Go Tour
![GitHub repo size](https://img.shields.io/github/repo-size/HeryHamzah/go-tour-app)
![GitHub contributors](https://img.shields.io/github/contributors/HeryHamzah/go-tour-app)
![GitHub stars](https://img.shields.io/github/stars/HeryHamzah/go-tour-app?style=social)
![GitHub forks](https://img.shields.io/github/forks/HeryHamzah/go-tour-app?style=social)

![isometric-iphone-12-mockup-template](https://user-images.githubusercontent.com/73412329/162352211-b0e5fa7d-4372-4c75-9ef0-c098faf621c9.png)

Aplikasi simulasi pemesanan tiket tempat wisata dan tour guide di Sulawesi Selatan. 

## Persiapan

1. Memiliki akun google cloud platform
2. Terinstall web server, database MySQL, dan bahasa PHP. Atau menggunakan Software bundling seperti Laragon, Appserv, Xampp.
3. Dan pastinya terinstall code editor dan Flutter SDK

## Instalasi Go Tour

1. Clone atau download repo
    ```sh
    git clone https://github.com/HeryHamzah/go-tour-app.git
    ```
3. Ganti nama package (opsional)*
4. Buat project baru di firebase => replace file android/app/google-services.json dengan yang baru, tambahkan firebase SDK pada build.gradle, izinkan auth dengan email dan password, buat firestore database*
5. Buat project baru di google cloud platform => Create credentials -> API key, enable maps SDK for Android dan ios*
6. Copy and replace API key project flutter android/app/src/main/AndroidManifest.xml

## Instalasi Backend

1. Clone atau download repo
    ```sh
    git clone https://github.com/HeryHamzah/go-tour-app-backend.git
    ```
3. Pastikan project berada di folder root server lokal (contoh: c:/laragon/www/ atau c:/xampp/htdocs)
4. Import gotour.sql ke database MySQL

## Catatan
1. project dibuat dengan windows, jadi belum memungkinkan untuk ios
2. Semua asset destinasi dan tour guide merupakan asset unsplash, bukan asli
3. (*) silahkan cari tutorialnya

