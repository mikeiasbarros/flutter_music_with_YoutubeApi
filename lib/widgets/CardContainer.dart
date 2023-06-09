import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardContainer extends StatelessWidget {
  final Color color;
  final Widget child;
  final String title, channelName;
  final GestureTapCallback? onTap;

  const CardContainer(
      {super.key,
      required this.color,
      required this.child,
      required this.title,
      required this.channelName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 14, right: 14),
        child: Column(

          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(18)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: child,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5, left: 5, bottom: 5),
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    style: GoogleFonts.openSans()
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(channelName,
                      style: GoogleFonts.openSans(
                          //fontWeight: FontWeight.bold
                          ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
