part of '../pages.dart';

class TicketDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Ticket ticket = Get.arguments;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(ticket.destination.name),
            Text(ticket.name),
            Text(ticket.totalPrice.toString())
          ],
        ),
      ),
    );
  }
}
