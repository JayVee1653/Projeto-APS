import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tavernadoscombos/firebase_options.dart';

///Classe Singleton responsável por instanciar o Firebase
class FirebaseService {
  /// Construtor privado para impedir múltiplas instâncias
  FirebaseService._internal();

  /// Instância única do FirebaseService (Singleton)
  static FirebaseService? _instance;

  /// Flag para saber se o Firebase foi inicializado
  static bool _isInitialized = false;

  /// Getter para a instância única
  static Future<FirebaseService> get instance async {
    if (_instance == null) {
      _instance = FirebaseService._internal();
      await _instance!._initialize(); // Chama o método initialize
    }
    return _instance!;
  }

  /// Método para inicializar o Firebase
  Future<void> _initialize() async {
    if (!_isInitialized) {
      await dotenv.load();
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _isInitialized = true;
    }
  }
}
