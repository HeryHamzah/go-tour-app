part of '../pages.dart';

class TicketDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Ticket ticket = Get.arguments;

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
              trianglePos: .77,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: ticket.bookingCode,
                    child: Container(
                      height: 200,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(BaseUrl.getAssets +
                                  ticket.destination.images[0]),
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
                          ticket.destination.name,
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
                          "Lokasi",
                          style: themeFont.copyWith(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            ticket.destination.locationName +
                                ", Sulawesi Selatan",
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
                          child: Text(ticket.time.dayAndDate,
                              textAlign: TextAlign.end,
                              style: themeFont.copyWith(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 9),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jumlah Tiket",
                          style: themeFont.copyWith(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(ticket.totalTicket.toString(),
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
                          child: Text(ticket.bookingCode,
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
                              ticket.userName,
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
                                  .format(ticket.totalPrice),
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
                          data: ticket.bookingCode,
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
    );
  }
}
