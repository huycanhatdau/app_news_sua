import 'package:auth_fire/import.dart ';

AppBar headerFix(BuildContext context,
    {PreferredSizeWidget? bottom,
      Widget? title,
      String? label,
      double? elevation,
      Color? backgroundColor,
      bool automaticallyImplyLeading = true,
      bool? centerTitle,
      List<Widget>? actions,
      Widget? leading,
      bool hideSearchIcon = false}) {
  return AppBar(
    backgroundColor: backgroundColor,
    elevation: elevation ?? 0.5,
    centerTitle: centerTitle ?? true,
    leading: leading ?? (Navigator.canPop(context) ?
    IconButton(
        onPressed: () {
          Navigator.pop;
        },
        icon: const Icon(
          Icons.add,
          color: Colors.green,
        )) : null),
    title: (label != null)
        ? Text(
      label,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    )
        : (title),
    bottom: bottom,
    actions: actions,
  );
}
