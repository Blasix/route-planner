import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maps_test/screens/map/map_screen.dart';
import 'package:maps_test/screens/settings/settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../loading_manager.dart';
import '../../models/route_template_model.dart';
import 'home_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<bool> handleLocationPermission() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location services are disabled. Please enable the services')));
        return false;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permissions are denied')));
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.')));
        return false;
      }
      return true;
    }

    const buttonDuration = Duration(milliseconds: 300);
    final template = ref.watch(templateNotifierProvider);
    final homeState = ref.watch(homeStateProvider);
    return LoadingManager(
      child: Scaffold(
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
                          InkWell(
                              onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsScreen(),
                                    ),
                                  ),
                              child: const Icon(Icons.settings_outlined)),
                          Text(
                            AppLocalizations.of(context)!.helloUser('User'),
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
                            AppLocalizations.of(context)!.createRoute,
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
                                    '${template.distance} KM',
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
                                              ref
                                                  .read(templateNotifierProvider
                                                      .notifier)
                                                  .setDistance(true);
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
                                              ref
                                                  .read(templateNotifierProvider
                                                      .notifier)
                                                  .setDistance(false);
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
                                      if (!template.isWalking) {
                                        ref
                                            .read(templateNotifierProvider
                                                .notifier)
                                            .setWalking(true);
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
                                            color: template.isWalking
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
                                      if (template.isWalking) {
                                        ref
                                            .read(templateNotifierProvider
                                                .notifier)
                                            .setWalking(false);
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
                                            color: !template.isWalking
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
                                onTap: () async {
                                  try {
                                    ref.read(loadingProvider.notifier).state =
                                        true;
                                    bool locationEnabled =
                                        await handleLocationPermission();
                                    if (locationEnabled) {
                                      Position position =
                                          await Geolocator.getCurrentPosition(
                                              desiredAccuracy:
                                                  LocationAccuracy.high);
                                      template.isWalking
                                          ? print('Walking')
                                          : print('Biking');
                                      print('${template.distance} KM');
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MapScreen(),
                                      ),
                                    );
                                    ref.read(loadingProvider.notifier).state =
                                        false;
                                    return;
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4)
                                      .copyWith(left: 10),
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                  child: Row(children: [
                                    Text(
                                      AppLocalizations.of(context)!.go,
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
                                  if (!homeState.isRecent) {
                                    ref
                                        .read(homeStateProvider.notifier)
                                        .setRecent(true);
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
                                        color: homeState.isRecent
                                            ? const Color(0xff458BE7)
                                            : const Color(0xffD9D9D9)),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.recent,
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
                                  if (homeState.isRecent) {
                                    ref
                                        .read(homeStateProvider.notifier)
                                        .setRecent(false);
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
                                        color: !homeState.isRecent
                                            ? const Color(0xff458BE7)
                                            : const Color(0xffD9D9D9)),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.liked,
                                    style: GoogleFonts.openSans(
                                      fontSize: 22,
                                    ),
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
              Expanded(
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
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
      ),
    );
  }
}
