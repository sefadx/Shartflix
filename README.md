## Shartflix

Flutter ile geliştirilmiş basit ve akıcı bir Movies App.Dikey kaydırmalı poster akışı, favori işaretleme, profil sayfası ve çok dillilik (tr/en) içerir.


# Gelişmiş Navigasyon Mimarisi

Bu proje, **Flutter Navigator 2.0 API**'ını temel alarak **tip-güvenli (type-safe)**, merkezi ve ölçeklenebilir bir navigasyon mimarisi kullanır. Geleneksel `Navigator.pushNamed` yaklaşımının getirdiği karmaşıklığı ve hataları ortadan kaldırmayı hedefler.

## 🎯 Motivasyon

Flutter'da standart navigasyon yöntemleri, özellikle parametre gönderirken veya karmaşık akışlar yönetirken aşağıdaki sorunları beraberinde getirir:

* **Tip Güvenliği Eksikliği:** Rota isimlerini `String` olarak göndermek, yazım hatalarına ve runtime hatalarına açıktır.
* **Parametre Karmaşası:** Sayfalara parametre göndermek ve bu parametreleri okumak zordur.
* **Dağınık Yapı:** Navigasyon mantığı projenin farklı yerlerine dağılır.
* **Deeplink Zorluğu:** URL'den sayfa yönlendirmesi için ek mantıklar gerekir.

Bu mimari, bu sorunları çözmek için tasarlanmıştır.

## 🏩 Mimarinin Temel Bileşenleri

Sistem üç ana bileşenden oluşur:

1. **AppRoute (Soyut Sınıf):** Uygulamadaki her sayfa için türetilir.
2. **AppRouter (RouterDelegate):** Navigasyon yığını merkezi olarak yönetir. Singleton deseni kullanır.
3. **AppRouteInformationParser (RouteInformationParser):** Deeplink'leri analiz eder ve `AppRoute` nesnesine dönüştürür.

## 🚀 Nasıl Çalışır?

### 1. Rotaları Tanımlama (`app_route.dart`)

**Parametresiz rota:**

```dart
class LoginRoute extends AppRoute {
  const LoginRoute();

  @override
  Widget build() => const PageLogin();
}
```

**Parametre alan rota (Equatable ile):**

```dart
import 'package:equatable/equatable.dart';

class ProfileRoute extends AppRoute with EquatableMixin {
  final String userId;
  const ProfileRoute({required this.userId});

  @override
  Widget build() => PageProfile(userId: userId);

  @override
  List<Object?> get props => [userId];
}
```

### 2. Rotaları Kullanma (`AppRouter`)

**Sayfa ekleme (Push):**

```dart
AppRouter.instance.push(const LoginRoute());
AppRouter.instance.push(ProfileRoute(userId: 'user-123'));
```

**Sayfa kaldırma (Pop):**

```dart
AppRouter.instance.pop();
AppRouter.instance.pop(route: const LoginRoute());
```

**Yığını değiştirme (Replace / ReplaceAll):**

```dart
AppRouter.instance.replace(const ForgotPasswordRoute());
AppRouter.instance.replaceAll(const HomeRoute());
```

### 3. Deeplink Entegrasyonu

`AppRouteInformationParser`, gelen URL'leri rota nesnesine dönüştürür.

```dart
class AppRouteInformationParser extends RouteInformationParser<AppRoute> {
  @override
  Future<AppRoute> parseRouteInformation(RouteInformation routeInformation) {
    final uri = routeInformation.uri;
    switch (segments.first) {
      case 'profile':
        if (segments.length > 1) {
          final userId = segments[1];
          return SynchronousFuture(ProfileRoute(userId: userId));
        }
    }
  }
}
```

### 4. Kurulum (`main.dart`)

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: AppRouter.instance,
      routeInformationParser: AppRouteInformationParser(),
    );
  }
}
```

## ✅ Avantajlar

* **Tip-Güvenli:** Derleme zamanında hatalar yakalanır.
* **Merkezi Yönetim:** Tüm navigasyon mantığı tek yerde.
* **Okunabilirlik:** Koddan ne yapıldığı kolayca anlaşılır.
* **Ölçeklenebilirlik:** Yeni sayfa eklemek kolay.
* **Esneklik:** Yığından belirli sayfa kaldırma desteği.
* **Kolay Test:** Navigasyon UI'dan soyutlandığı için test edilebilir.




# API Servis Katmanı Mimarisi

Bu doküman, projenin API servis katmanının mimarisini, tasarım kararlarını ve nasıl kullanılacağını açıklamaktadır. Servis katmanı **tip güvenliği (type-safety)**, **esneklik** ve **test edilebilirlik** ilkeleri üzerine kurulmuştur.

## Temel Felsefe

API katmanımız üç ana bileşenden oluşur:

* **ApiEndpoint:** API'nin tüm endpoint'lerini ve bu endpoint'lerin gerektirdiği parametreleri tip güvenli bir şekilde tanımlar. "Magic string" kullanımını ortadan kaldırır.
* **ApiService:** HTTP isteklerini (GET, POST, UPLOAD vb.) gerçekleştiren, hata yönetimini merkezileştiren ve JSON parse işlemlerini yürüten ana servis sınıfıdır.
* **Modeller (json\_serializable):** API'den gelen veya API'ye gönderilen JSON verilerini temsil eden Dart sınıflarıdır. Kod üretimi (code generation) sayesinde boilerplate kod minimuma indirilmiştir.

Bu yapı, ağ isteklerinin tüm karmaşıklığını tek bir katmanda soyutlayarak, BLoC veya Repository gibi üst katmanların sadece iş mantığına odaklanmasını sağlar.

## ApiEndpoint - Tip Güvenli Endpoint Yönetimi

Swift'teki *enum with associated values* deseninden esinlenerek, Dart 3'ün **sealed class (mühürlü sınıf)** özelliğini kullanıyoruz. Bu, her bir API çağrısını kendi parametrelerine sahip bir nesne olarak tanımlamamızı sağlar.

### Tanımlama

Her endpoint, `ApiEndpoint` soyut sınıfından türetilir ve kendi `path()` metodunu implemente eder. Bu metot, endpoint'in yolunu ve sorgu parametrelerini (query parameters) oluşturur.

```dart
// lib/services/api/api_endpoint.dart

sealed class ApiEndpoint {
  const ApiEndpoint();
  String path();
}

// Parametresiz bir endpoint
class LoginEndpoint extends ApiEndpoint {
  const LoginEndpoint();
  @override
  String path() => "/user/login";
}

// Path parametresi alan bir endpoint
class GetUserEndpoint extends ApiEndpoint {
  final int userId;
  const GetUserEndpoint({required this.userId});
  @override
  String path() => "/api/users/$userId";
}

// Sorgu parametreleri alan bir endpoint
class UserConnectionsEndpoint extends ApiEndpoint {
  final String id;
  final String? queryText;
  final int? limit;

  const UserConnectionsEndpoint({required this.id, this.queryText, this.limit});

  @override
  String path() {
    final basePath = "/user/$id/connections";
    final params = {'text': queryText, 'limit': limit};
    // _buildPathWithQuery, null parametreleri atar ve URL encoding yapar.
    return _buildPathWithQuery(basePath, params);
  }
}
```

### Avantajları

* **Tip Güvenliği:** `GetUserEndpoint(userId: 'abc')` gibi bir kullanım derleme hatası verir.
* **Okunabilirlik:** `service.get(GetUserEndpoint(userId: 123))` kodu, `service.get("/api/users/123")` gibi bir string'den çok daha nettir.
* **Merkezi Yönetim:** Tüm endpoint'ler tek bir dosyada toplanır.

## ApiService - Merkezi İstek ve Hata Yönetimi

ApiService, tüm HTTP operasyonlarının kalbidir. Bir `IApiService` arayüzünü implemente eder, bu da bağımlılıkların enjekte edilmesini ve testlerde kolayca *mock*'lanabilmesini sağlar.

### Mimarisi

* **Constructor:** `baseUrl` ve opsiyonel olarak token veya test için `http.Client` alır.
* **Metotlar:** `get`, `post`, `put`, `delete`, `upload` gibi standart HTTP metotlarını sunar.
* **Hata Yönetimi:** Network hataları, zaman aşımları ve HTTP durum kodu hatalarını yakalar ve `ApiException` sınıflarına dönüştürür.
* **JSON İşleme:** Gelen yanıtları `fromJson` fonksiyonu ile belirtilen modele (`<T>`) dönüştürür.

### Kullanım Örnekleri

ApiService, generic tipler sayesinde son derece esnektir.

#### 1. Basit GET İsteği

```dart
Future<UserModel> fetchUser(int id) async {
  try {
    final user = await _apiService.get<UserModel>(
      GetUserEndpoint(userId: id),
      fromJson: (json) => UserModel.fromJson(json['data']),
    );
    return user;
  } on ApiException catch (e) {
    log("Kullanıcı alınamadı: ${e.message}");
    rethrow;
  }
}
```

#### 2. POST İsteği ve BaseResponseModel Kullanımı

```dart
Future<void> login(String email, String password) async {
  try {
    final response = await _apiService.post<BaseResponseModel<Authenticated>, LoginBody>(
      const LoginEndpoint(),
      body: LoginBody(email: email, password: password),
      fromJson: (json) => BaseResponseModel.fromJson(
        json,
        (dataJson) => Authenticated.fromJson(dataJson as Map),
      ),
    );

    if (response.responseInfo.code == 200 && response.data != null) {
      emit(AuthenticatedState(response.data!));
    } else {
      emit(AuthFailureState(response.responseInfo.message));
    }
  } on ApiException catch (e) {
    emit(AuthFailureState(e.message));
  }
}
```

#### 3. Dosya Yükleme (upload)

```dart
Future<void> uploadProfilePicture(String userId, String imagePath) async {
  final response = await _apiService.upload<BaseResponseModel<FileUploadResponse>, UploadBody>(
    const UploadProfilePictureEndpoint(),
    filePath: imagePath,
    body: UploadBody(userId: userId),
    fromJson: (json) => BaseResponseModel.fromJson(
      json,
      (dataJson) => FileUploadResponse.fromJson(dataJson as Map),
    ),
  );
  // yanıtı işle...
}
```

---

Bu mimari, projenin API ile olan etkileşimini standartlaştırır, sürdürülebilirliği artırır ve olası hataları derleme zamanında yakalamayı hedefler.
