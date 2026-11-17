import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    ));

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    ProfileScreen(),
    SettingsScreen(),
    CalendarScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
      ),
      drawer: _buildDrawer(),
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.pink, Colors.redAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Text('Давидов Исаия',
                    style: GoogleFonts.montserratAlternates(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 4),
                Text('isaiah@telaviv.com',
                    style: GoogleFonts.montserratAlternates(
                        fontSize: 14, color: Colors.white70)),
              ],
            ),
          ),
          _buildDrawerItem(0, Icons.person, 'Профиль'),
          _buildDrawerItem(1, Icons.settings, 'Настройки'),
          _buildDrawerItem(2, Icons.calendar_month, 'Календарь'),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Выйти', style: TextStyle(color: Colors.red)),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(int index, IconData icon, String title) {
    final isSelected = _currentIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.blueAccent.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon,
            color: isSelected ? Colors.blueAccent : Colors.grey),
        title: Text(title,
            style: GoogleFonts.montserratAlternates(
              color: isSelected ? Colors.blueAccent : Colors.grey,
              fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.normal,
            )),
        trailing: isSelected
            ? Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(2),
                ),
              )
            : null,
        onTap: () {
          setState(() => _currentIndex = index);
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.person, Icons.person_outline, 'Профиль'),
              _buildNavItem(1, Icons.settings, Icons.settings_outlined, 'Настройки'),
              _buildNavItem(2, Icons.calendar_month,
                  Icons.calendar_month_outlined, 'Календарь'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData activeIcon, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blueAccent.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isSelected ? activeIcon : icon,
                color: isSelected ? Colors.blueAccent : Colors.grey,
                size: 24),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    color: isSelected ? Colors.blueAccent : Colors.grey,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => const Center(
        child: Text('👤 Профиль', style: TextStyle(fontSize: 32)),
      );
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) => const Center(
        child: Text('⚙️ Настройки', style: TextStyle(fontSize: 32)),
      );
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedMonth = DateTime.now();

  final Map<int, List<String>> _events = {
    3: ['Встреча с командой'],
    7: ['День рождения'],
    15: ['Сдача проекта'],
  };

  final List<String> _months = [
    'Январь','Февраль','Март','Апрель','Май','Июнь',
    'Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь',
  ];
  final List<String> _days = ['Пн','Вт','Ср','Чт','Пт','Сб','Вс'];

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  void _changeMonth(int delta) => setState(() =>
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + delta));

  void _showPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                    child: const Text('Отмена'),
                    onPressed: () => Navigator.pop(context)),
                CupertinoButton(
                    child: const Text('Готово',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.pop(context)),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                onDateTimeChanged: (d) => setState(() {
                  _selectedDate = d;
                  _focusedMonth = d;
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddEvent() {
    final c = TextEditingController();
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: Text('${_selectedDate.day} ${_months[_selectedDate.month - 1]}'),
        message: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: CupertinoTextField(
              controller: c, placeholder: 'Название', autofocus: true),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              if (c.text.trim().isNotEmpty) {
                setState(() {
                  _events[_selectedDate.day] ??= [];
                  _events[_selectedDate.day]!.add(c.text.trim());
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Добавить'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lastDay = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0).day;
    final allDays = List.generate(lastDay,
        (i) => DateTime(_focusedMonth.year, _focusedMonth.month, i + 1));
    final offset = DateTime(_focusedMonth.year, _focusedMonth.month, 1).weekday - 1;
    final events = _events[_selectedDate.day] ?? [];

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Календарь'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _showPicker,
          child: const Icon(CupertinoIcons.calendar),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => _changeMonth(-1),
                      child: const Icon(CupertinoIcons.chevron_left)),
                  Text(
                    '${_months[_focusedMonth.month - 1]} ${_focusedMonth.year}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => _changeMonth(1),
                      child: const Icon(CupertinoIcons.chevron_right)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _days
                  .map((d) => SizedBox(
                        width: 36,
                        child: Center(
                          child: Text(d,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: CupertinoColors.systemGrey,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Wrap(
                spacing: 2,
                runSpacing: 2,
                children: [
                  ...List.generate(offset, (_) => const SizedBox(width: 36, height: 46)),
                  ...allDays.map((day) {
                    final sel = _isSameDay(day, _selectedDate);
                    final today = _isSameDay(day, DateTime.now());
                    final hasEv = _events.containsKey(day.day);
                    
                    return GestureDetector(
                      onTap: () => setState(() => _selectedDate = day),
                      child: Container(
                        width: 36,
                        height: 46,
                        margin: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: sel
                              ? CupertinoColors.activeBlue
                              : today
                                  ? CupertinoColors.activeBlue.withValues(alpha: 0.12)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${day.day}',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: sel || today
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: sel
                                      ? Colors.white
                                      : today
                                          ? CupertinoColors.activeBlue
                                          : CupertinoColors.label,
                                )),
                            const SizedBox(height: 2),
                            if (hasEv)
                              Icon(
                                CupertinoIcons.star_fill,
                                size: 10,
                                color: sel ? Colors.white : CupertinoColors.activeBlue,
                              )
                            else
                              const SizedBox(height: 10, width: 10),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('${_selectedDate.day}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_months[_selectedDate.month - 1]} ${_selectedDate.year}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(_days[_selectedDate.weekday - 1],
                          style: const TextStyle(
                              color: CupertinoColors.systemGrey, fontSize: 13)),
                    ],
                  ),
                  const Spacer(),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: _showAddEvent,
                    child: const Icon(CupertinoIcons.add_circled, size: 28),
                  ),
                ],
              ),
            ),
            Expanded(
              child: events.isEmpty
                  ? const Center(
                      child: Text('Нет событий',
                          style: TextStyle(
                              color: CupertinoColors.systemGrey,
                              fontSize: 15)))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: events.length,
                      itemBuilder: (_, i) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: CupertinoColors.activeBlue.withValues(alpha: 0.07),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(CupertinoIcons.star_fill,
                                size: 16,
                                color: CupertinoColors.activeBlue),
                            const SizedBox(width: 10),
                            Text(events[i], style: const TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}