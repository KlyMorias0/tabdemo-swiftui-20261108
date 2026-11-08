# TabDemo

SwiftUI ile üç sekmeli küçük iOS demosu: Ana Sayfa, Ara, Profil.
Harici paket kullanmaz. iOS 16 ve üzerini destekler.

## Durum

Kaynak kodu ve Xcode projesi GitHub Actions üzerinde macOS ile başarıyla
derlendi. İmzasız cihaz IPA'sı Releases bölümünde sunulur. Uygulama gerçek
iPhone üzerinde test edilmedi.

## Mac olmadan imzasız IPA oluşturma

1. GitHub'da herkese açık (public) boş bir depo oluştur.
2. Bu klasörün içeriğini, gizli `.github` klasörü dahil, depoya yükle.
   `TabDemo.xcodeproj` dosyası deponun kökünde bulunmalı.
3. GitHub'da **Actions → Build unsigned IPA → Run workflow** seç.
4. Başarılı çalışmanın **Artifacts** bölümünden `TabDemo-unsigned-ipa`
   arşivini indir. İçinde `TabDemo-unsigned.ipa` bulunur.

GitHub'ın standart macOS Actions çalıştırıcıları herkese açık depolarda
ücretsizdir; hizmetin güncel kullanım koşulları geçerlidir. Bu iş akışı
Apple Developer hesabı, sertifika veya üçüncü taraf bağımlılığı istemez.
Derleme iş akışı ayrıca `demo-1.0` sürümüne IPA dosyasını yükler.

## iPhone'a kurma

İmzasız IPA doğrudan kurulmaz. Windows'ta AltStore Classic gibi bir araçla
ücretsiz Apple hesabını kullanarak kişisel cihazına imzalayıp yükleyebilirsin.
Araç kurulumu, uyumlu iOS sürümü ve hesabının desteklenmesi gerekir.
Ücretsiz hesapla bu yöntem genellikle 7 günde bir yenileme gerektirir.
Apple hesap bilgilerini sohbette paylaşma; yalnızca seçtiğin aracın güvenilir
resmi sürümünde kullan. TestFlight/App Store dağıtımı bu ücretsiz derlemeden
ayrı olarak Apple Developer Program üyeliği gerektirir.

## Mac üzerinde

`TabDemo.xcodeproj` dosyasını Xcode ile aç; simülatörde çalıştır.
İmzasız cihaz IPA'sı için terminalde:

```sh
bash scripts/build-unsigned-ipa.sh
```

Sonuç: `build/TabDemo-unsigned.ipa`.
