import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Static Resources App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Интеграция кастомного шрифта в глобальную тему
        fontFamily: 'CustomFont',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isVertical = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Static Resources App'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(isVertical ? Icons.grid_view : Icons.view_list),
            onPressed: () {
              setState(() {
                isVertical = !isVertical;
              });
            },
            tooltip: isVertical ? 'Переключить на ряд' : 'Переключить на стопку',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Галерея статических ресурсов',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Это приложение демонстрирует использование ассетов и кастомных шрифтов во Flutter.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const Divider(height: 40),
              if (isVertical)
                Column(
                  children: _buildImageItems(),
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildImageItems(horizontal: true),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildImageItems({bool horizontal = false}) {
    final images = [
      ('assets/images/image1.png', 'Изображение 1'),
      ('assets/images/image2.png', 'Изображение 2'),
      ('assets/images/image3.png', 'Изображение 3'),
    ];

    return images.map((item) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: horizontal ? 0 : 20,
          right: horizontal ? 20 : 0,
        ),
        child: _buildImageCard(item.$1, item.$2),
      );
    }).toList();
  }

  Widget _buildImageCard(String assetPath, String label) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                assetPath,
                width: 180,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 180,
                    height: 180,
                    color: Colors.grey[200],
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image, size: 40, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('Ошибка загрузки', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
