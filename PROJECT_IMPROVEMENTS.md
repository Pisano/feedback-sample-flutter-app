# Feedback Sample Flutter App — Improvements

Bu doküman, bu repoda yapılan düzenlemeleri ve bu düzenlemelerin gerekçelerini (**eski yapı → yeni yapı**) müşteri paylaşımına uygun şekilde özetler.

> Not: Bu repo **SDK kaynak kodu değildir**.  
> Repo, Pisano Feedback Flutter SDK’nın (iOS + Android) nasıl entegre edilip kullanılacağını gösteren **örnek (sample) Flutter uygulaması** içerir.

## Kısa Özet — Ne Değişti?

Bu repo; “çalıştırması kolay”, “gizli bilgi içermeyen”, “release build’lerde de sorunsuz derlenen” ve “dokümantasyonu güncel” bir sample olacak şekilde temizlendi.

Öne çıkan iyileştirmeler:

- **Repo yapısı sadeleştirildi**: Flutter app artık repo root’ta (komutlar/CI daha net).
- **Secrets yönetimi local-only**: gerçek key/URL’ler repo’ya girmiyor; `--dart-define-from-file` ile veriliyor.
- **Android release build düzeltildi**: R8 “Missing classes” hatası giderildi.
- **README güncellendi**: doğru klasör yapısı, çalışma komutları, troubleshooting ve platform notları netleştirildi.
- **UI/test stabilitesi**: küçük ekran overflow düzeltildi, default “counter” test’i app’e uygun smoke test’e çevrildi.

## Repo’nun Güncel Yapısı

Repo tek bir Flutter sample uygulamasıdır:

- Flutter kaynak kodu: `lib/`
- Android: `android/`
- iOS: `ios/`
- Screenshot’lar: `ss/`
- Testler: `test/`

SDK bağımlılığı **remote git dependency** olarak tüketilir: `pubspec.yaml`.

## Secrets Yönetimi (Local-Only)

Repo’da gerçek credential / API key commit edilmez.

- `pisano_defines.json.example` repoda bulunur (örnek/şablon).
- Local geliştirme akışı:
  - `pisano_defines.json.example` → `pisano_defines.json` olarak kopyalanır
  - Key/URL’ler doldurulur
  - Uygulama şu şekilde çalıştırılır:

```bash
flutter run -d <device_id> --dart-define-from-file=pisano_defines.json
```

`pisano_defines.json` gitignore kapsamındadır ve repo’ya commit edilmez.

> iOS notu: Xcode “Run” ile çalıştırmak `--dart-define-from-file` parametresini otomatik geçmez. Bu nedenle local test için önerilen yol Flutter CLI ile çalıştırmaktır (README’de belirtilmiştir).

## Konfigürasyon & Entegrasyon Standardı

Konfig okuma tekilleştirildi:

- `lib/pisano_config.dart` üzerinden `String.fromEnvironment(...)` ile `--dart-define*` değerleri okunur.
- Placeholder (YOUR_*) değerler varsa sample **init’i bilerek skip eder** ve kullanıcıyı yönlendirir (crash yok).

Uygulama akışı:

- App açılışında `FeedbackFlutterSdk.init(...)`
- Kullanıcı aksiyonu ile `FeedbackFlutterSdk.show(...)`
- Event için `FeedbackFlutterSdk.track(...)`
- State temizliği için `FeedbackFlutterSdk.clear()`

## Android — Release Build Stabilitesi

### INTERNET izni

Network çağrılarının release dahil tüm build’lerde çalışması için `android.permission.INTERNET` izni **main manifest**’te bulunur:

- `android/app/src/main/AndroidManifest.xml`

### R8 / minifyReleaseWithR8 hatası

Android release build’de R8 “Missing class …” hatası görülebiliyordu (opsiyonel platform entegrasyon referansları).

Çözüm:

- `android/app/proguard-rules.pro` eklendi (uyarı bastırma)
- `android/app/build.gradle.kts` içinde release build type’a proguard file’lar bağlandı
- Opsiyonel in-app review bağımlılıkları eklendi (release derlemesi stabil)

## iOS — Derleme & Pod Stabilitesi

- `flutter build ios --no-codesign` ile iOS derlemesi doğrulandı.
- CocoaPods pod install akışı repo içinde mevcut (`ios/Podfile`).

## UI / UX İyileştirmeleri

- Ana ekran küçük yüksekliklerde overflow edebiliyordu; scrollable hale getirildi:
  - `lib/main.dart`

## Test / Smoke Test

- Default Flutter “counter increments” testi app UI’sına uymadığı için fail ediyordu.
- Yerine, **boot + navigation** yapan basit bir widget smoke test eklendi; credentials yoksa da CI kırmaz (init skip banner’ı üzerinden doğrular):
  - `test/widget_test.dart`

## Dokümantasyon

`README.md` tek giriş noktası olacak şekilde güncellendi:

- Repo amacı
- Kurulum (remote git dependency)
- Secrets (local-only) ve çalışma komutları
- Platform notları (Android permission / iOS ATS/HTTPS)
- Troubleshooting
- Screenshot’lar

## Yapılanlar Checklist

- Kod gözden geçirme, naming ve yapı iyileştirmeleri — ✅
- Repo yapısının sadeleştirilmesi (root’a taşıma) — ✅
- Secrets yönetimi (local-only) — ✅
- Android release build stabilitesi (R8) — ✅
- UI overflow / küçük ekran dayanıklılığı — ✅
- Testlerin CI-friendly hale getirilmesi — ✅
- README güncelleme — ✅

## Kabul Kriterleri

- Android derlenir — ✅ (`flutter build apk --release`)
- iOS derlenir — ✅ (`flutter build ios --no-codesign`)
- `flutter analyze` temiz — ✅
- `flutter test` temiz — ✅
- Hassas veriler repo’ya commit edilmez — ✅ (gitignore ile)

## Kanıt / İlgili Dosyalar (Yüksek Seviye)

- **Docs**: `README.md`, `PROJECT_IMPROVEMENTS.md`
- **Config**: `lib/pisano_config.dart`, `pisano_defines.json.example`, `.gitignore`
- **SDK kullanım akışı**: `lib/main.dart`
- **Android release fix**: `android/app/build.gradle.kts`, `android/app/proguard-rules.pro`
- **Tests**: `test/widget_test.dart`
- **Screenshots**: `ss/`

