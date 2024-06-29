part of 'calculate_screen.dart';

Widget buildChip(Opera opera, CalculateController controller) {
  return InkWell(
    onTap: () => opera.name == 'turn'
        ? controller.rotateScreen()
        : controller.buttonPressed(opera.name),
    child: Container(
      color: opera.name == '=' ? primaryColor : Colors.white,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(2),
      child: Center(
        child: opera.icon != null
            ? Icon(
                opera.icon,
                color: primaryColor,
              )
            : Text(
                opera.name,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: opera.name == '=' ? Colors.white : opera.color,
                ),
              ),
      ),
    ),
  );
}
