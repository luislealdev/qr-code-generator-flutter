import 'package:flutter/material.dart';
import 'package:qr_code_generator/config/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      title: 'QR Generator',
      home: _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  var url = 'https://www.luisrrleal.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Generador de QR',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            const Text('Ingresa el enlace '),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              child: TextField(
                autocorrect: false,
                onChanged: (value) {
                  setState(() {
                    url = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'www.luisrrleal.com',
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 54, 164, 255))),
              onPressed: () {
                if (url.isEmpty) {
                  return;
                }

                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Image.network(loadingBuilder:
                              (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          }, 'https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=${url.trim().toLowerCase()}'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Generar nuevo QR"))
                          ],
                        ));
              },
              child: const Text(
                "Generar QR",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        color: Colors.blue,
        child: const Padding(
          padding: EdgeInsets.all(40.0),
          child: Text("With ❤️ by @luisrrleal",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
