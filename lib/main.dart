import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uv_indeksi/date_helper.dart';
import 'package:uv_indeksi/uv_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'UV-indeksi';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(primary: Colors.green),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(primary: Colors.green),
      ),
      home: const MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _uvTime;
  double _uvValue = -1;
  var _loading = false;

  void _fetchUV() async {
    try {
      if (_loading) {
        return;
      }

      setState(() {
        _loading = true;
      });

      final uv = await fetchUV();

      setState(() {
        _uvTime = formatDateTime(uv.time);
        _uvValue = uv.value;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Virhe: $e'),
        ),
      );
      if (kDebugMode) {
        print(e);
      }
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _loading
                ? const CircularProgressIndicator()
                : _uvTime == null
                    ? const Text(
                        'Hae UV-indeksi napauttamalla päivityspainiketta',
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'UV-indeksi: $_uvValue',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text('Viimeisin tieto: $_uvTime'),
                          const Text('Sijainti: Helsinki Kumpula'),
                        ],
                      ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchUV,
        tooltip: 'Päivitä',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
