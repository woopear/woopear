import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilImage extends ConsumerStatefulWidget {
  String urlAvatar;

  ProfilImage({Key? key, required this.urlAvatar}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilImageState();
}

class _ProfilImageState extends ConsumerState<ProfilImage> {

  /// upload l'image du profil
  Future<void> uploadAvatar() async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              /// image
              /// si image on affiche image sinon on affiche logo person
              Container(
                margin: const EdgeInsets.only(top: 50.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey
                      : Colors.black12,
                  shape: BoxShape.circle,
                ),
                child: widget.urlAvatar != ''
                    ? CircleAvatar(
                        radius: 200 / 2,
                        backgroundImage: NetworkImage(
                          widget.urlAvatar,
                        ),
                      )
                    : const Icon(Icons.person, size: 200.0),
              ),

              /// btn update
              Positioned(
                bottom: 0,
                right: 5,
                child: Tooltip(
                  message: 'Modifier mon image de profil',
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        /// TODO: upload image
                      },
                      icon: Icon(
                        Icons.photo_library,
                        size: 30,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
