import 'package:flutter/material.dart';
import 'package:ai_travel_planner/CustomColors.dart';
import 'package:ai_travel_planner/data/model/travel.dart';

class TravelCard extends StatefulWidget {
  final Travel travel;

  const TravelCard({super.key, required this.travel});

  @override
  _TravelCardState createState() => _TravelCardState();
}

class _TravelCardState extends State<TravelCard> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.travel.isLiked ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        height: 270.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.travel.imageUrl!.isNotEmpty
                  ? widget.travel.imageUrl!
                  : 'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg',
              height: 150.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10.0),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.travel.name ?? 'Viaggio',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 4.0),
                  Text(
                    '${widget.travel.numberOfLikes ?? 0}',
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLiked = !isLiked;
                        widget.travel.isLiked = isLiked;
                      });
                    },
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? CustomColors.darkBlue : CustomColors.darkBlue,
                      size: 28.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
