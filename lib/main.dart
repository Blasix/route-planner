import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Duration buttonDuration = const Duration(milliseconds: 300);
  int distance = 15;
  bool isWalking = true;
  bool isRecent = true;
  bool isTemplate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.settings_outlined),
                        Text(
                          '👋 Hello, User',
                          style: GoogleFonts.openSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const CircleAvatar(
                          radius: 24,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 169, 203, 255),
                          Color.fromARGB(255, 69, 139, 231),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create\nRoute',
                          style: GoogleFonts.openSans(
                            height: 1,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Row(children: [
                                Text(
                                  '$distance KM',
                                  style: GoogleFonts.openSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                SizedBox(
                                  height: 43,
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              distance++;
                                            });
                                          },
                                          child: const Icon(
                                            FontAwesomeIcons.angleUp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              distance--;
                                            });
                                          },
                                          child: const Icon(
                                            FontAwesomeIcons.angleDown,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Row(children: [
                                InkWell(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  onTap: () {
                                    if (!isWalking) {
                                      setState(() {
                                        isWalking = true;
                                      });
                                    }
                                  },
                                  child: AnimatedContainer(
                                    duration: buttonDuration,
                                    width: 60,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      color: const Color(0xffF4F4F4),
                                      border: Border.all(
                                          width: 2,
                                          color: isWalking
                                              ? const Color(0xff458BE7)
                                              : const Color(0xffD9D9D9)),
                                    ),
                                    child: const Icon(
                                      FontAwesomeIcons.personWalking,
                                      color: Colors.black,
                                      size: 28,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                InkWell(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  onTap: () {
                                    if (isWalking) {
                                      setState(() {
                                        isWalking = false;
                                      });
                                    }
                                  },
                                  child: AnimatedContainer(
                                    duration: buttonDuration,
                                    width: 60,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      color: const Color(0xffF4F4F4),
                                      border: Border.all(
                                          width: 2,
                                          color: !isWalking
                                              ? const Color(0xff458BE7)
                                              : const Color(0xffD9D9D9)),
                                    ),
                                    child: const Icon(
                                      FontAwesomeIcons.personBiking,
                                      color: Colors.black,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              onTap: () {
                                isWalking ? print('Walking') : print('Biking');
                                print('$distance KM');
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.all(4).copyWith(left: 10),
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Row(children: [
                                  Text(
                                    'GO!',
                                    style: GoogleFonts.openSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Icon(
                                    FontAwesomeIcons.chevronRight,
                                    color: Colors.black,
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12).copyWith(bottom: 5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              onTap: () {
                                if (!isRecent) {
                                  setState(() {
                                    isRecent = true;
                                  });
                                }
                              },
                              child: AnimatedContainer(
                                duration: buttonDuration,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  color: const Color(0xffF4F4F4),
                                  border: Border.all(
                                      width: 2,
                                      color: isRecent
                                          ? const Color(0xff458BE7)
                                          : const Color(0xffD9D9D9)),
                                ),
                                child: Text(
                                  'Recent',
                                  style: GoogleFonts.openSans(
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              onTap: () {
                                if (isRecent) {
                                  setState(() {
                                    isRecent = false;
                                    isTemplate = false;
                                  });
                                }
                              },
                              child: AnimatedContainer(
                                duration: buttonDuration,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  color: const Color(0xffF4F4F4),
                                  border: Border.all(
                                      width: 2,
                                      color: !isRecent
                                          ? const Color(0xff458BE7)
                                          : const Color(0xffD9D9D9)),
                                ),
                                child: Text(
                                  'Liked',
                                  style: GoogleFonts.openSans(
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible: isRecent,
                              child: InkWell(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                onTap: () {
                                  if (!isTemplate) {
                                    setState(() {
                                      isTemplate = true;
                                    });
                                  }
                                },
                                child: AnimatedContainer(
                                  duration: buttonDuration,
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    color: const Color(0xffF4F4F4),
                                    border: Border.all(
                                        width: 2,
                                        color: isTemplate
                                            ? const Color(0xff458BE7)
                                            : const Color(0xffD9D9D9)),
                                  ),
                                  child: Text(
                                    'Template',
                                    style: GoogleFonts.openSans(
                                        fontSize: 14, color: Colors.grey[600]),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: isRecent,
                              child: const SizedBox(
                                width: 10,
                              ),
                            ),
                            InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              onTap: () {
                                if (isTemplate) {
                                  setState(() {
                                    isTemplate = false;
                                  });
                                }
                              },
                              child: AnimatedContainer(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  color: const Color(0xffF4F4F4),
                                  border: Border.all(
                                      width: 2,
                                      color: !isTemplate
                                          ? const Color(0xff458BE7)
                                          : const Color(0xffD9D9D9)),
                                ),
                                duration: buttonDuration,
                                child: Text(
                                  'Route',
                                  style: GoogleFonts.openSans(
                                      fontSize: 14, color: Colors.grey[600]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isTemplate
                ? Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 7),
                          height: 200,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(114, 129, 223, 0.2),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1 / 1.2,
                          crossAxisCount: 2,
                        ),
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.all(7),
                            height: 200,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(114, 129, 223, 0.2),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
