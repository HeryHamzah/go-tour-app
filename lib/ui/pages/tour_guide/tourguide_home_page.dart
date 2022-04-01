part of "../pages.dart";

class TourGuideHomePage extends StatefulWidget {
  @override
  State<TourGuideHomePage> createState() => _TourGuideHomePageState();
}

class _TourGuideHomePageState extends State<TourGuideHomePage> {
  String tourGuideID = Get.arguments;

  @override
  Widget build(BuildContext context) {
    //FIXME: error receiver null saat full restart emulator
    if (tourGuideID != null) {
      context.bloc<TourGuideBloc>().add(LoadTourGuide(tourGuideID));
      context.bloc<TourguideTicketBloc>().add(GetTourGuideTicket());
      print("perintah jalan!");
    }

    return Scaffold(
        backgroundColor: backColor,
        body: BlocBuilder<TourGuideBloc, TourGuideState>(
          builder: (context, tourGuideState) {
            if (tourGuideState is TourGuideLoaded) {
              TourGuide tourGuide = tourGuideState.tourGuide;
              return ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              width: 100,
                              height: 100,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2.5,
                                      color: (tourGuide.status)
                                          ? Colors.green
                                          : Colors.redAccent)),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: (tourGuide.profilePicture != "")
                                          ? NetworkImage(
                                              BaseUrl.getTourGuideImages +
                                                  tourGuide.profilePicture)
                                          : AssetImage('assets/avatar.png'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 1,
                                  height: 80,
                                  margin: EdgeInsets.only(right: 20),
                                  color: Colors.grey[300],
                                ),
                                Column(
                                  children: [
                                    Text("Status",
                                        style:
                                            themeFont.copyWith(fontSize: 16)),
                                    Switch(
                                        value: tourGuide.status,
                                        onChanged: (status) {
                                          context.bloc<TourGuideBloc>().add(
                                              ChangeStatusTourGuide(
                                                  tourGuide.tourGuideID,
                                                  status));
                                        })
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(tourGuide.name,
                              style: themeFont.copyWith(
                                  fontSize: 24, fontWeight: FontWeight.w500)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text("Total Trip"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    tourGuide.numberOfTrips,
                                    style: themeFont.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed('/reviewPage',
                                  arguments: [null, tourGuide]),
                              child: Container(
                                width: 100,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Text("Rating"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${tourGuide.rating.toString().substring(0, tourGuide.rating.toString().length < 4 ? tourGuide.rating.toString().length : 4)} (${tourGuide.numberOfReviews})",
                                      style: themeFont.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          onTap: () => Get.toNamed('/tourGuideProfile',
                              arguments: tourGuide),
                          contentPadding: EdgeInsets.all(0),
                          leading: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.5),
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              Icons.settings,
                              size: 25,
                            ),
                          ),
                          title: Text("Pengaturan Akun"),
                          trailing: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                              )),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.5),
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              Icons.travel_explore,
                              size: 25,
                            ),
                          ),
                          title: Text("Riwayat Trip"),
                          trailing: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                              )),
                        ),
                        ListTile(
                          onTap: () {
                            TourGuideServices.tourGuideSignOut();
                            context
                                .bloc<TourGuideBloc>()
                                .add(SignOutTourGuide());
                          },
                          contentPadding: EdgeInsets.all(0),
                          leading: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.5),
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              Icons.logout_outlined,
                              size: 25,
                            ),
                          ),
                          title: Text("Keluar"),
                          trailing: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return SpinKitFadingCircle(
                color: mainColor,
              );
            }
          },
        ));
  }
}
