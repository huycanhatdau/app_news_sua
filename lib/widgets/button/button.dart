import 'package:auth_fire/import.dart';

class ButtonBase extends StatelessWidget {
  const ButtonBase({super.key, required this.onTap, required this.title, this.isFull = false, this.keyButton});

  final Function() onTap;
  final String title;
  final bool isFull;
  final Key? keyButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: keyButton,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: !empty(isFull) && (isFull) ? double.infinity : 200,
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        decoration: BoxDecoration(
            color: const Color(0xb8000000),
            borderRadius: BorderRadius.circular(8)
        ),
        child: Text(title, style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
      ),
    );
  }
}
