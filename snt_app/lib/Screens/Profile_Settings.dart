// profile_settings.dart (top of file, outside widgets)
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snt_app/Components/BottomNavBar.dart';

class SettingsResult {
  final String email;
  final String username;
  final List<String> skills;
  final List<String> interests;
  final Uint8List? avatarBytes;

  SettingsResult({
    required this.email,
    required this.username,
    required this.skills,
    required this.interests,
    required this.avatarBytes,
  });
}

// profile_settings.dart

// Colors
const _kPurple = Color(0xFF7A5AF8);
const _kMuted = Color(0xFFB9C1D0);
const _kInputBorder = Color(0xFFD5DCE6);
const _kCardShadow = Color(0x1A000000);

class SettingsPage extends StatefulWidget {
  final String initialEmail;
  final String initialUsername;
  final List<String> initialSkills;
  final List<String> initialInterests;
  final Uint8List? initialAvatarBytes;

  const SettingsPage({
    Key? key,
    this.initialEmail = 'bessie.cooper@gmail.com',
    this.initialUsername = 'Bessie Cooper',
    this.initialSkills = const ['Leadership', 'UX Design', 'Basketball', 'Reading'],
    this.initialInterests = const ['Reading', 'Basketball'],
    this.initialAvatarBytes,
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

  late List<String> skills;
  late List<String> interests;
  Uint8List? avatarBytes;

  @override
  void initState() {
    super.initState();
    _emailCtrl = TextEditingController(text: widget.initialEmail);
    _usernameCtrl = TextEditingController(text: widget.initialUsername);
    skills = [...widget.initialSkills];
    interests = [...widget.initialInterests];
    avatarBytes = widget.initialAvatarBytes;
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _usernameCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery, maxWidth: 1024, imageQuality: 88);
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    setState(() => avatarBytes = bytes);
  }

  void _finish() {
    Navigator.pop(
      context,
      SettingsResult(
        email: _emailCtrl.text.trim(),
        username: _usernameCtrl.text.trim(),
        skills: skills,
        interests: interests,
        avatarBytes: avatarBytes,
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
            style: TextStyle(color: _kMuted, fontWeight: FontWeight.w500, fontFamily: 'Poppins', fontSize: 16)),
        actions: [
          TextButton(onPressed: _finish, child: const Text('Save', style: TextStyle(color: _kPurple)))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          // ——— Avatar ———
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: avatarBytes != null
                        ? MemoryImage(avatarBytes!)
                        : const NetworkImage('https://via.placeholder.com/150') as ImageProvider,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                    onTap: _pickAvatar,
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: _kPurple,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          const _SectionLabel('Profile settings'),
          const SizedBox(height: 14),

          // Email & Username pills
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _FieldLabel('Email'),
                const SizedBox(height: 8),
                _PillTextField(controller: _emailCtrl, prefix: Icons.email_outlined, hint: 'bessie.cooper@gmail.com'),
                const SizedBox(height: 16),
                const _FieldLabel('Username'),
                const SizedBox(height: 8),
                _PillTextField(controller: _usernameCtrl, prefix: Icons.person_outline, hint: 'Bessie Cooper'),
                const SizedBox(height: 16),

                // ——— Skills (multi-select) ———
                const _FieldLabel('Skills'),
                const SizedBox(height: 8),
                _ChipsEditor(
                  items: skills,
                  onAddTap: () => _openPicker(
                    title: 'Choose skills',
                    base: {
                      'Leadership','UX Design','UI Design','Project Management','Public Speaking','Figma','Flutter','Data Analysis'
                    },
                    current: skills,
                    onDone: (sel) => setState(() => skills = sel),
                  ),
                  onDelete: (s) => setState(() => skills.remove(s)),
                ),
                const SizedBox(height: 16),

                // ——— Interests (multi-select) ———
                const _FieldLabel('Interests'),
                const SizedBox(height: 8),
                _ChipsEditor(
                  items: interests,
                  onAddTap: () => _openPicker(
                    title: 'Choose interests',
                    base: {
                      'Reading','Basketball','Travel','Photography','Cooking','Gaming','Music','Fitness'
                    },
                    current: interests,
                    onDone: (sel) => setState(() => interests = sel),
                  ),
                  onDelete: (s) => setState(() => interests.remove(s)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          const _SectionLabel('General settings'),
          const SizedBox(height: 10),

          _Card(
            child: Column(children: [
              _SwitchRow(icon: Icons.notifications_none_rounded, title: 'Enable notifications', value: notificationsEnabled, onChanged: (v) => setState(() => notificationsEnabled = v)),
              const Divider(height: 1),
              _SwitchRow(icon: Icons.dark_mode_outlined, title: 'dark mode', value: darkMode, onChanged: (v) => setState(() => darkMode = v)),
              const Divider(height: 1),
              _SwitchRow(icon: Icons.data_saver_off_outlined, title: 'data saver', value: dataSaver, onChanged: (v) => setState(() => dataSaver = v)),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPurple,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  ),
                  child: const Text('Log out', style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
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

  Future<void> _openPicker({
    required String title,
    required Set<String> base,
    required List<String> current,
    required ValueChanged<List<String>> onDone,
  }) async {
    final selected = {...current};
    final controller = TextEditingController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(left:16,right:16,top:12,bottom:16+MediaQuery.of(ctx).viewInsets.bottom),
          child: StatefulBuilder(builder: (_, setSheet) {
            final list = base
                .where((o) => o.toLowerCase().contains(controller.text.toLowerCase()))
                .toList()
              ..sort();
            return Column(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 44, height: 4, margin: const EdgeInsets.only(bottom: 10), decoration: BoxDecoration(color: _kInputBorder, borderRadius: BorderRadius.circular(2))),
              Text(title, style: const TextStyle(fontFamily:'Poppins', fontSize:16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                onChanged: (_) => setSheet(() {}),
                decoration: InputDecoration(
                  hintText: 'Search or add new',
                  prefixIcon: const Icon(Icons.search),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color:_kInputBorder)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color:_kInputBorder)),
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (final o in list)
                      CheckboxListTile(
                        dense: true,
                        value: selected.contains(o),
                        onChanged: (v){ setSheet((){ v==true ? selected.add(o) : selected.remove(o);}); },
                        title: Text(o, style: const TextStyle(fontFamily:'Poppins')),
                        activeColor: _kPurple,
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
                    style: OutlinedButton.styleFrom(foregroundColor: _kPurple, side: const BorderSide(color: _kPurple)),
                    onPressed: () {
                      final t = controller.text.trim();
                      if (t.isEmpty) return;
                      base.add(t);
                      selected.add(t);
                      setSheet(() {});
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: _kPurple),
                    onPressed: () { onDone(selected.toList()..sort()); Navigator.pop(context); },
                    child: const Text('Done'),
                  ),
                ),
              ]),
            ]);
          }),
        );
      },
    );
  }
}

// ——— helpers used above (unchanged from earlier look) ———
class _SectionLabel extends StatelessWidget {
  final String text; const _SectionLabel(this.text);
  @override Widget build(BuildContext context) => Text(text, style: const TextStyle(color:_kMuted,fontSize:16,fontWeight:FontWeight.w500,fontFamily:'Poppins'));
}
class _Card extends StatelessWidget {
  final Widget child; const _Card({required this.child});
  @override Widget build(BuildContext context) => Container(
    width: double.infinity, padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
      border: Border.all(color:_kInputBorder), boxShadow: const [BoxShadow(color:_kCardShadow, blurRadius:6, offset: Offset(0,3))]),
    child: child);
}
class _FieldLabel extends StatelessWidget {
  final String text; const _FieldLabel(this.text);
  @override Widget build(BuildContext context)=> Text(text, style: const TextStyle(color:_kMuted,fontSize:12.5,fontWeight:FontWeight.w500,fontFamily:'Poppins'));
}
class _PillTextField extends StatelessWidget {
  final TextEditingController controller; final IconData prefix; final String hint;
  const _PillTextField({required this.controller,required this.prefix,required this.hint});
  @override Widget build(BuildContext context)=> TextField(
    controller: controller, cursorColor:_kPurple,
    style: const TextStyle(color:_kMuted,fontFamily:'Poppins',fontSize:13),
    decoration: InputDecoration(
      isDense: true, contentPadding: const EdgeInsets.symmetric(horizontal:16,vertical:14),
      prefixIcon: Icon(prefix,color:_kMuted), hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(28), borderSide: const BorderSide(color:_kInputBorder)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(28), borderSide: const BorderSide(color:_kInputBorder)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(28), borderSide: const BorderSide(color:_kInputBorder)),
    ),
  );
}
class _ChipsEditor extends StatelessWidget {
  final List<String> items; final VoidCallback onAddTap; final ValueChanged<String> onDelete;
  const _ChipsEditor({required this.items,required this.onAddTap,required this.onDelete});
  @override Widget build(BuildContext context) => Wrap(
    spacing: 8, runSpacing: 8,
    children: [
      for (final s in items)
        Chip(label: Text(s, style: const TextStyle(fontFamily:'Poppins',fontSize:12)),
          onDeleted: ()=>onDelete(s),
          deleteIconColor: Colors.grey.shade600,
          backgroundColor: Colors.white,
          shape: StadiumBorder(side: BorderSide(color:_kInputBorder))),
      InputChip(label: const Text('Add'), avatar: const Icon(Icons.add, size:18),
        onPressed: onAddTap,
        shape: StadiumBorder(side: BorderSide(color:_kInputBorder))),
    ],
  );
}
class _SwitchRow extends StatelessWidget {
  final IconData icon; final String title; final bool value; final ValueChanged<bool> onChanged;
  const _SwitchRow({required this.icon,required this.title,required this.value,required this.onChanged});
  @override Widget build(BuildContext context)=> Padding(
    padding: const EdgeInsets.symmetric(vertical:12),
    child: Row(children:[
      Container(width:36,height:36, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color:_kPurple)),
        alignment: Alignment.center, child: Icon(icon,color:_kPurple,size:20)),
      const SizedBox(width:12),
      Expanded(child: Text(title, style: const TextStyle(fontFamily:'Poppins',fontSize:14,color: Colors.black87))),
      Transform.scale(scale: .95, child: Switch.adaptive(
        value: value, onChanged: onChanged,
        activeColor: Colors.white, activeTrackColor:_kPurple,
        trackOutlineColor: WidgetStateProperty.resolveWith((_)=> Colors.transparent),
        thumbColor: WidgetStateProperty.resolveWith((s)=> s.contains(WidgetState.selected) ? Colors.white : const Color(0xFFDDE3EA)),
        inactiveTrackColor: const Color(0xFFE8ECF2),
      )),
    ]),
  );
}
