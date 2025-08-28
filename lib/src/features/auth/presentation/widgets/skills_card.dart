import 'package:flutter/material.dart';

class SkillsCard extends StatelessWidget {
  final Skills skill;
  const SkillsCard({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: skill.color, width: 2),
        ),
        height: 84,
        width: 84,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(skill.icon, width: 34, height: 34),
            const SizedBox(height: 6),
            Text(skill.name, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class Skills {
  final String name;
  final String icon;
  final Color color;

  Skills({required this.name, required this.icon, required this.color});
}
