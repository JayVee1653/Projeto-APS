import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tavernadoscombos/firebase_options.dart';  // Dependendo de onde está seu arquivo de opções.

///Classe Singleton responsável por instanciar o Firebase
class FirebaseService {

  /// Construtor privado para impedir múltiplas instâncias
  FirebaseService._internal();

  /// Instância única do FirebaseService (Singleton)
  static final FirebaseService _instance = FirebaseService._internal();

  /// Getter para a instância única
  static FirebaseService get instance => _instance;

  /// Método para inicializar o Firebase
  Future<void> initialize() async {
    await dotenv.load();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
