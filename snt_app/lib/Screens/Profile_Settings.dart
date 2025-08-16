import 'package:flutter/material.dart';
import 'package:snt_app/Components/BottomNavBar.dart';

// ——— brand colors tuned to your mock ———
const _kPurple = Color(0xFF7A5AF8);     // slider + button + outline
const _kPurpleLight = Color(0xFFE9E4FF); // subtle fills (if needed)
const _kMuted = Color(0xFFB9C1D0);       // section labels, appbar title
const _kInputBorder = Color(0xFFD5DCE6); // light grey pill border
const _kCardShadow = Color(0x1A000000);  // 10% black

class SettingsResult {
  final String email;
  final String username;
  final List<String> skills;
  SettingsResult({required this.email, required this.username, required this.skills});
}

class SettingsPage extends StatefulWidget {
  final String initialEmail;
  final String initialUsername;
  final List<String> initialSkills;

  const SettingsPage({
    Key? key,
    this.initialEmail = 'bessie.cooper@gmail.com',
    this.initialUsername = 'Bessie Cooper',
    this.initialSkills = const ['Leadership', 'UX Design', 'Basketball', 'Reading'],
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool darkMode = false;
  bool dataSaver = false;
  int currentIndex = 3;

  late final TextEditingController _emailCtrl;
  late final TextEditingController _usernameCtrl;
  final TextEditingController _skillAddCtrl = TextEditingController();

  late List<String> skills;

  @override
  void initState() {
    super.initState();
    _emailCtrl = TextEditingController(text: widget.initialEmail);
    _usernameCtrl = TextEditingController(text: widget.initialUsername);
    skills = [...widget.initialSkills];
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _usernameCtrl.dispose();
    _skillAddCtrl.dispose();
    super.dispose();
  }

  void _finish() {
    Navigator.pop(
      context,
      SettingsResult(
        email: _emailCtrl.text.trim(),
        username: _usernameCtrl.text.trim(),
        skills: skills,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _kMuted),
          onPressed: _finish,
        ),
        title: const Text('Settings',
            style: TextStyle(
              color: _kMuted,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              fontSize: 16,
            )),
        actions: [
          TextButton(
            onPressed: _finish,
            child: const Text('Save',
                style: TextStyle(
                    color: _kPurple,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins')),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const _SectionLabel('Profile settings'),
          const SizedBox(height: 14),

          // ——— Card 1 ———
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FieldLabel('Email'),
                const SizedBox(height: 8),
                _PillTextField(
                  controller: _emailCtrl,
                  prefix: Icons.email_outlined,
                  hint: 'bessie.cooper@gmail.com',
                ),
                const SizedBox(height: 16),
                _FieldLabel('Username'),
                const SizedBox(height: 8),
                _PillTextField(
                  controller: _usernameCtrl,
                  prefix: Icons.person_outline,
                  hint: 'Bessie Cooper',
                ),
                const SizedBox(height: 16),
                _FieldLabel('Skills and Interests'),
                const SizedBox(height: 8),

                // Chips (removeable)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final s in skills)
                      Chip(
                        label: Text(s,
                            style: const TextStyle(
                                fontFamily: 'Poppins', fontSize: 12)),
                        onDeleted: () => setState(() => skills.remove(s)),
                        deleteIconColor: Colors.grey.shade600,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: Colors.white,
                        shape: StadiumBorder(
                          side: BorderSide(color: _kInputBorder),
                        ),
                      ),
                    // Add new (inline)
                    InputChip(
                      label: const Text('Add skill'),
                      onPressed: () => _openSkillsPicker(context),
                      avatar: const Icon(Icons.add, size: 18),
                      shape: StadiumBorder(
                        side: BorderSide(color: _kInputBorder),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          const _SectionLabel('General settings'),
          const SizedBox(height: 10),

          // ——— Card 2 (grey container) ———
          _Card(
            child: Column(children: [
              _SwitchRow(
                icon: Icons.notifications_none_rounded,
                title: 'Enable notifications',
                value: notificationsEnabled,
                onChanged: (v) => setState(() => notificationsEnabled = v),
              ),
              const Divider(height: 1),
              _SwitchRow(
                icon: Icons.dark_mode_outlined,
                title: 'dark mode',
                value: darkMode,
                onChanged: (v) => setState(() => darkMode = v),
              ),
              const Divider(height: 1),
              _SwitchRow(
                icon: Icons.data_saver_off_outlined,
                title: 'data saver',
                value: dataSaver,
                onChanged: (v) => setState(() => dataSaver = v),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPurple,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text('Log out',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ]),
          ),
        ]),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        onHomePressed: () {},
      ),
    );
  }

  // ——— multi-select picker bottom sheet ———
  Future<void> _openSkillsPicker(BuildContext context) async {
    final options = <String>[
      'Leadership',
      'UX Design',
      'UI Design',
      'Basketball',
      'Reading',
      'Project Management',
      'Public Speaking',
      'Figma',
      'Flutter',
      'Data Analysis',
    ];
    final selected = Set<String>.from(skills);
    final tempController = TextEditingController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
            bottom: 16 + MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (context, setSheetState) {
              final filtered = options
                  .where((o) => o
                      .toLowerCase()
                      .contains(tempController.text.toLowerCase()))
                  .toList();
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 44,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: _kInputBorder,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const Text('Choose skills',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: tempController,
                    onChanged: (_) => setSheetState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search or add new',
                      prefixIcon: const Icon(Icons.search),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: _kInputBorder, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: _kInputBorder, width: 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (final o in filtered)
                          CheckboxListTile(
                            value: selected.contains(o),
                            onChanged: (v) => setSheetState(() {
                              if (v == true) {
                                selected.add(o);
                              } else {
                                selected.remove(o);
                              }
                            }),
                            title: Text(o,
                                style: const TextStyle(fontFamily: 'Poppins')),
                            activeColor: _kPurple,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('Add as new'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _kPurple,
                          side: const BorderSide(color: _kPurple),
                        ),
                        onPressed: () {
                          final text = tempController.text.trim();
                          if (text.isEmpty) return;
                          if (!options.contains(text)) {
                            selected.add(text);
                          }
                          setSheetState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => skills = selected.toList()..sort());
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _kPurple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Done'),
                      ),
                    ),
                  ]),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

// ——— UI helpers (match the mock precisely) ———

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          color: _kMuted,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ));
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kInputBorder, width: 1),
        boxShadow: const [
          BoxShadow(
            color: _kCardShadow,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: child,
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          color: _kMuted,
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ));
  }
}

class _PillTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData prefix;
  final String hint;

  const _PillTextField({
    required this.controller,
    required this.prefix,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: _kPurple,
      style: const TextStyle(
          color: _kMuted, fontFamily: 'Poppins', fontSize: 13),
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        prefixIcon: Icon(prefix, color: _kMuted),
        hintText: hint,
        hintStyle:
            const TextStyle(color: _kMuted, fontFamily: 'Poppins', fontSize: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: _kInputBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: _kInputBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: _kInputBorder, width: 1),
        ),
        filled: false,
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchRow({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kPurple, width: 1),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: _kPurple, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.black87,
              )),
        ),
        Transform.scale(
          scale: 0.95,
          child: Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: _kPurple,
            trackOutlineColor:
                WidgetStateProperty.resolveWith((_) => Colors.transparent),
            thumbColor: WidgetStateProperty.resolveWith(
              (states) =>
                  states.contains(WidgetState.selected)
                      ? Colors.white
                      : const Color(0xFFDDE3EA),
            ),
            inactiveTrackColor: const Color(0xFFE8ECF2),
          ),
        ),
      ]),
    );
  }
}
