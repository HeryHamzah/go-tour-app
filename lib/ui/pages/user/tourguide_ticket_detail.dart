part of '../pages.dart';

class TourGuideTicketDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TourGuideTicket tourGuideTicket = Get.arguments;
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: InkWell(
            onTap: () => Get.back(), child: Icon(Icons.arrow_back_ios_new)),
        title: Text("Detail Tiket", style: themeFont.copyWith(fontSize: 20)),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 20),
        child: ListView(
          children: [
            TicketView(
              contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 0),
              drawArc: true,
              triangleAxis: Axis.vertical,
              borderRadius: 6,
              drawDivider: true,
              drawTriangle: false,
              trianglePos: .74,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: tourGuideTicket.bookingCode,
                    child: Container(
                      height: 200,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(BaseUrl.getTourGuideImages +
                                  tourGuideTicket.tourGuide.profilePicture),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width -
                            4 * defaultMargin,
                        child: Text(
                          tourGuideTicket.tourGuide.name,
                          style: themeFont.copyWith(
                              color: Colors.black, fontSize: 18),
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Destinasi",
                          style: themeFont.copyWith(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            tourGuideTicket.destinations,
                            style: themeFont.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tanggal",
                          style: themeFont.copyWith(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(tourGuideTicket.dateTime.dayAndDate,
                              textAlign: TextAlign.end,
                              style: themeFont.copyWith(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kode Reservasi",
                          style: themeFont.copyWith(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(tourGuideTicket.bookingCode,
                              style: themeFont.copyWith(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.end),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultMargin, vertical: defaultMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama:",
                              style: themeFont.copyWith(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              tourGuideTicket.user.name,
                              style: themeFont.copyWith(
                                  color: Colors.black, fontSize: 16),
                            ),
                            SizedBox(height: 9),
                            Text(
                              "Total:",
                              style: themeFont.copyWith(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: "id_ID",
                                      decimalDigits: 0,
                                      symbol: "Rp")
                                  .format(tourGuideTicket.totalPrice),
                              style: themeFont.copyWith(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                        QrImage(
                          version: 5,
                          foregroundColor: Colors.black,
                          errorCorrectionLevel: QrErrorCorrectLevel.M,
                          padding: EdgeInsets.all(0),
                          size: 100,
                          data: tourGuideTicket.bookingCode,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: buildSpeedDial(
          contact: tourGuideTicket.tourGuide.hp,
          email: tourGuideTicket.tourGuide.email),
    );
  }
}
