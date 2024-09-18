import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';


/// Classe que inicia o ChatBoT Gemini
class ChatBotApp extends StatelessWidget {
  /// Construtor responsável pelo ChatBoT Gemini
  const ChatBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: TaverneiroPage(),);
  }
}

///Classe que inicia a página do Taverneiro
class TaverneiroPage extends StatefulWidget {
  ///Construtor responsável pelo Taverneiro
  const TaverneiroPage({super.key});

  @override
  State<TaverneiroPage> createState() => _ScreenState();
}

class _ScreenState extends State<TaverneiroPage> {
  final TextEditingController _controller = TextEditingController();
  final GenerativeModel model = GenerativeModel(
    model: 'gemini-1.5-flash-latest', // Ou "gemini-pro"
    apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
  );
  final List<Widget> _messageList = <Widget>[];

  Future<void> _sendMessage() async {
    final String userMessage = _controller.text;
    if (userMessage.isNotEmpty) {
      setState(() {
        _messageList.add(MarkdownBody(data: '**Você**: $userMessage'));
        _messageList.add(
          const Row(
            children: <Widget>[
              MarkdownBody(data: '**Taverneiro**: '),
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        );
      });
      _controller.clear();
    }

    final List<Content> content = <Content>[Content.text(userMessage)];
    final GenerateContentResponse response = 
    await model.generateContent(content);

    setState(() {
      _messageList.removeAt(_messageList.length - 1);
      _messageList.add(
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(55, 255, 255, 255),
            ),
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(10, 255, 255, 255),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MarkdownBody(
              data:
                  '**Taverneiro**: ${response.text ?? 
                  'Opa, não consigo responder no momento Me fale sobre você'}',
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Conversa com o Taverneiro'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              itemCount: _messageList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _messageList[index],);
              },
            ),),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Mande sua mensagem para o Taverneiro',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),);
  }
}
