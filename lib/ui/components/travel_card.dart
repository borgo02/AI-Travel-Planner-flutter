import 'package:flutter/material.dart';
import 'package:ai_travel_planner/CustomColors.dart';
import 'package:ai_travel_planner/data/model/travel.dart';
import 'package:ai_travel_planner/data/model/user_model.dart';

class TravelCard extends StatelessWidget {
  final Travel travel;
  final User? user;
  final User? ownerUser;
  final IconData? icon;
  final VoidCallback? onIconTap;
  final VoidCallback? onLikeTap;
  final bool showOwnerName;
  final bool showLikes;

  const TravelCard({
    super.key,
    required this.travel,
    required this.user,
    required this.ownerUser,
    this.icon,
    this.onIconTap,
    this.onLikeTap,
    this.showOwnerName = false,
    this.showLikes = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        height: 310.0, // Increased height to accommodate user info
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showOwnerName)
              SizedBox(
                height: 50.0,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png"
                        ),
                        radius: 15.0,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        ownerUser?.fullname ?? "Nome completo",
                        style: const TextStyle(
                          color: CustomColors.mediumBlue,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Image.network(
              travel.imageUrl!.isNotEmpty
                  ? travel.imageUrl!
                  : 'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg',
              height: 150.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 5.0),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  travel.name ?? 'Travel',
                  style: const TextStyle(
                      color: CustomColors.darkBlue,
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
                  if (icon == Icons.share)
                    GestureDetector(
                      onTap: onIconTap,
                      child: Icon(
                        icon,
                        size: 28.0,
                        color: CustomColors.darkBlue,
                      ),
                    ),
                  const SizedBox(width: 4.0),
                  if (showLikes)
                    Row(
                      children: [
                        Text(
                          '${travel.numberOfLikes ?? 0}',
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        GestureDetector(
                          onTap: onLikeTap,
                          child: Icon(
                            travel.isLiked ? Icons.favorite : Icons.favorite_border,
                            color: CustomColors.darkBlue,
                            size: 28.0,
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
    );
  }
}
