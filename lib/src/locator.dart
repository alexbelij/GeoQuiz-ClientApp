import 'package:app/src/services/local_database_service.dart';
import 'package:app/src/services/local_progression_service.dart';
import 'package:app/src/services/remote_database_service.dart';
import 'package:app/src/services/remote_resource_downloader_service.dart';
import 'package:app/src/ui/startup/startup_provider.dart';
import 'package:app/src/ui/themes/themes_provider.dart';
import 'package:app/src/utils/app_logger.dart';
import 'package:get_it/get_it.dart';

/// Service locator used to retrieve services and providers.
/// 
/// Before to use it to retrieve objects it needs to be initialized by calling
/// [setupLocator] static method, it will lazy initialized the services and
/// the providers.
/// 
/// It register all services used in the app and providers that can be accessed
/// anywhere in the app. For providers used only in specific page and without
/// accessible anywhere, use the traditionnal approach with the
/// [ChangeNotifierProvider] and [Consumer] widgets.
/// 
/// {@tool sample}
/// To retrieve the MockProvider
/// 
/// ```dart
/// import 'package:app/src/locator.dart';
/// 
/// final mockProvider = Locator.of<MockProvider>();
/// ```
/// {@end-tool}
/// 
/// 
/// See :
/// 
///  * [Service locator pattern](https://en.wikipedia.org/wiki/Service_locator_pattern)
///  * [get_it package](https://pub.dev/packages/get_it)
class Locator {
  static final GetIt _locator = GetIt.instance;

  /// Retrieve an instance registered of the type [T]
  /// 
  /// As the objects are lazy initialized, it may also create the object.
  static T of<T>() {
    return _locator<T>();
  }

  /// Register the services and the providers
  /// 
  /// You can access to these objects by using the [_locator] instance
  /// 
  /// First, it register the services and then the providers, but the order of
  /// declaration is not important. The objects are lazy initialized, so their
  /// creations are deferred until their first used
  static void setupLocator() {
    _registerServices();
    _registerProviders();
  }

  static void _registerServices() {
    _locator.registerLazySingleton<ILocalDatabaseRepository>(
      () => SQLiteLocalDatabaseRepository(
        AppLogger('SQLiteLocalDatabaseRepository'),
        localProgressionRepo: _locator<ILocalProgressionRepository>()
      )
    );
    _locator.registerLazySingleton<IRemoteResourcesDownloader>(
      () => FirebaseResourceDownloader(
        AppLogger('FirebaseResourceDownloader')
      )
    );
    _locator.registerLazySingleton<IRemoteDatabaseRepository>(
      () => FirebaseRemoteDatabaseRepository(
        AppLogger('FirebaseRemoteDatabaseRepository'),
        resourceDownloader: _locator<IRemoteResourcesDownloader>()
      )
    );
    _locator.registerLazySingleton<ILocalProgressionRepository>(
      () => SQLiteLocalProgressionRepository()
    );
  }

  static void _registerProviders() {
    _locator.registerLazySingleton<StartUpProvider>(() => 
      StartUpProvider(
        localDbService: _locator<ILocalDatabaseRepository>(),
        remoteDbService: _locator<IRemoteDatabaseRepository>(),
      )..init()
    );
    _locator.registerLazySingleton<ThemesProvider>(() => 
      ThemesProvider(
        localRepo: _locator<ILocalDatabaseRepository>(),
        progressRepo: _locator<ILocalProgressionRepository>()
      )..loadThemes()
    );
  }
}




