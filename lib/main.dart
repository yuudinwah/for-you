// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buat-mu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  double? top;
  double? left;
  TextEditingController nameController = TextEditingController();
  int pageIndex = 0;
  int imageIndex = 0;
  bool imageDone = false;
  List<String> images = [
    'assets/images/animate/1.png',
    'assets/images/animate/2.webp',
    'assets/images/animate/3.webp',
    'assets/images/animate/4.webp',
    'assets/images/animate/5.webp',
    'assets/images/animate/6.webp',
    'assets/images/animate/7.webp',
    'assets/images/animate/8.webp',
    'assets/images/animate/9.webp',
    'assets/images/animate/10.webp',
    'assets/images/animate/11.webp',
    'assets/images/animate/12.webp',
    'assets/images/animate/13.webp',
    'assets/images/animate/14.webp',
    'assets/images/animate/15.webp',
  ];
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _prefs.then((value) {
      String? name = value.getString('name');
      if (name != null) {
        nameController = TextEditingController(text: name);
        pageIndex = 3;
        setState(() {});
      } else {}
    });
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (pageIndex == 2) {
        if (imageIndex == 14) {
          imageDone = true;
          imageIndex = 0;
        } else {
          imageIndex++;
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    double maxLeft = (MediaQuery.of(context).size.width - 480) / 2;
    double maxTop = (MediaQuery.of(context).size.height - 240) / 2;
    String nama =
        nameController.text.isEmpty ? "Orang misterius" : nameController.text;
    return Scaffold(
      // appBar: pageIndex == 2
      //     ? AppBar(
      //         title: Text(
      //           '♥ ${nameController.text.isEmpty ? "Orang misterius" : nameController.text} ♥',
      //           textAlign: TextAlign.center,
      //         ),
      //       )
      //     : null,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.2),
            ),
            if (pageIndex < 2)
              AnimatedPositioned(
                top: top ?? maxTop,
                left: MediaQuery.of(context).size.width < 480
                    ? null
                    : left ?? maxLeft,
                duration: const Duration(
                  milliseconds: 0,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width < 480
                      ? MediaQuery.of(context).size.width
                      : 480,
                  height: 240,
                  // constraints: MediaQuery.of(context).size.width < 480
                  //     ? null
                  //     : const BoxConstraints(
                  //         maxHeight: 240,
                  //         maxWidth: 480,
                  //       ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Builder(builder: (context) {
                    if (pageIndex == 0) {
                      return Column(
                        children: [
                          Container(
                            height: 40,
                            width: 480,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.grey[200]!,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Kenalan Yuk',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                      child: const Text(
                                        'Siapa nama mu?',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: nameController,
                                      onEditingComplete: () {
                                        setState(() {
                                          pageIndex = 1;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 480,
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      pageIndex = 1;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    margin: const EdgeInsets.only(
                                      right: 16,
                                      bottom: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'Send',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    if (pageIndex == 1) {
                      return Column(
                        children: [
                          Container(
                            height: 40,
                            width: 480,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.grey[200]!,
                                ),
                              ),
                            ),
                            child: Text(
                              'Halo ${nameController.text.isEmpty ? "Orang misterius" : nameController.text}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                      child: const Text(
                                        'Sebenarnya aku suka padamu.',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: const Text(
                                        'Maukah kamu menjadi orang yang selalu disisiku, yang selalu ada disaat senang ataupun susah, yang selalu ada sampai akhir hayatku?',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 480,
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                MouseRegion(
                                  onHover: (_) async {
                                    setState(() {
                                      if (maxTop > 0) {
                                        top =
                                            random.nextInt(maxTop.ceil()) * 1.0;
                                      }
                                      if (maxLeft > 0) {
                                        left = random.nextInt(maxLeft.ceil()) *
                                            1.0;
                                      }
                                    });
                                    // await db
                                    //     .doc(
                                    //         '#buatmu/${nameController.text.isEmpty ? "Orang misterius" : nameController.text}')
                                    //     .update({
                                    //   'revused': FieldValue.increment(1)
                                    // });
                                  },
                                  // onEnter: (_) {
                                  //   setState(() {
                                  //     top = random.nextInt(maxTop.ceil()) * 1.0;
                                  //     left = random.nextInt(maxLeft.ceil()) * 1.0;
                                  //   });
                                  // },
                                  child: InkWell(
                                    onDoubleTap: () async {
                                      setState(() {
                                        if (maxTop > 0) {
                                          top = random.nextInt(maxTop.ceil()) *
                                              1.0;
                                        }
                                        if (maxLeft > 0) {
                                          left =
                                              random.nextInt(maxLeft.ceil()) *
                                                  1.0;
                                        }
                                      });
                                    },
                                    // onLongPress: () {
                                    //   setState(() {
                                    //     if (maxTop > 0) {
                                    //       top = random.nextInt(maxTop.ceil()) *
                                    //           1.0;
                                    //     }
                                    //     if (maxLeft > 0) {
                                    //       left =
                                    //           random.nextInt(maxLeft.ceil()) *
                                    //               1.0;
                                    //     }
                                    //   });
                                    // },
                                    onTap: () async {
                                      setState(() {
                                        if (maxTop > 0) {
                                          top = random.nextInt(maxTop.ceil()) *
                                              1.0;
                                        }
                                        if (maxLeft > 0) {
                                          left =
                                              random.nextInt(maxLeft.ceil()) *
                                                  1.0;
                                        }
                                      });

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text('coba')));
                                      _prefs.then((value) async {
                                        bool iscomplete =
                                            await value.setString('name', nama);
                                        if (iscomplete) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content:
                                                      Text('yes berhasil')));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text('yes gagal')));
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text(
                                        'Tidak',
                                        style: TextStyle(
                                            // color: Colors.white,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      pageIndex = 2;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'Mau',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  }),
                ),
              ),
            if (pageIndex == 2)
              Center(
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Image.asset(
                      images[imageIndex],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            if (imageDone && pageIndex == 2)
              Positioned(
                right: 8,
                top: 8,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      pageIndex = 3;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Lanjut',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            if (pageIndex == 3)
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          nameController = TextEditingController();
                          pageIndex = 0;
                          imageIndex = 0;
                          _prefs.then((value) async {
                            await value.remove('name');
                          });
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Reset',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<void>(
                        stream: Stream.periodic(const Duration(seconds: 1)),
                        builder: (context, snapshot) {
                          DateTime now = DateTime.now();
                          String sapaan = '';
                          String waktu = '';
                          if (now.hour >= 0 && now.hour < 5) {
                            waktu = 'Selamat malam';
                            sapaan = 'kamu sudah istirahat kan?';
                          }
                          if (now.hour >= 5 && now.hour < 10) {
                            waktu = 'Selamat pagi';
                            sapaan =
                                'semoga hari ini akan menjadi hari yang baik buat $nama.';
                          }
                          if (now.hour >= 10 && now.hour < 15) {
                            waktu = 'Selamat siang';
                            sapaan = 'ayo semangat demi mewujukan mimpimu.';
                          }
                          if (now.hour >= 15 && now.hour < 19) {
                            waktu = 'Selamat petang';
                            sapaan =
                                'ayo siapkan untuk hari esok, dan jangan lupa istirahat ya.';
                          }
                          if (now.hour >= 19 && now.hour < 24) {
                            waktu = 'Selamat malam';
                            sapaan =
                                'waktunya kamu untuk istirahat, semoga bermimpi indah.';
                          }

                          return SizedBox(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                Expanded(
                                  flex: 60,
                                  child: SizedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat('HH:mm').format(now),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 32,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          DateFormat('EEEE, dd MMMM')
                                              .format(now),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Expanded(
                                  flex: 40,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 480,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$waktu $nama, $sapaan',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 80,
                    ),
                  ],
                ),
              ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(10),
                  ),
                ),
                child: const Text(
                  'Created with 😏',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
