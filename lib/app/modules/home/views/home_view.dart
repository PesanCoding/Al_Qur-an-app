import 'package:flutter/material.dart';
import 'package:alquran/global.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alquran/app/modules/dashboard/views/dashboard_view.dart';
import 'package:alquran/app/modules/prayer_time/views/prayer_time_view.dart';
import 'package:alquran/app/modules/quran/views/quran_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _MainPageState();
}

class _MainPageState extends State<HomeView> {
  final List<Widget> _pages = [
    DashboardView(),
    QuranView(),
    PrayerTimeView(),
    Text('Profile'),
    Text('Profile'),
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary.withOpacity(0.4),
        automaticallyImplyLeading: false,
        title: Row(children: [
          IconButton(
            onPressed: (() => {}),
            icon: SvgPicture.asset('assets/svgs/menu-icon.svg'),
          ),
          const SizedBox(
            width: 24,
          ),
          Text(
            "My Al-Qur'an",
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF009595)),
          ),
          const Spacer(),
          IconButton(
              onPressed: (() => {}),
              icon: SvgPicture.asset('assets/svgs/search-icon.svg')),
        ]),
      ),
      body: _pages[_index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [AppShadow.card],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[300]!,
              gap: 10,
              activeColor: Colors.teal,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.teal.withOpacity(0.1),
              color: Colors.teal,
              tabMargin: const EdgeInsets.only(top: 4),
              textStyle: AppTextStyle.normal.copyWith(
                color: Colors.teal,
              ),
              tabs: [
                GButton(
                  icon: UniconsLine.home_alt,
                  text: "",
                ),
                GButton(
                  icon: UniconsLine.book_open,
                  text: "",
                ),
                GButton(
                  icon: UniconsLine.compass,
                  text: "",
                ),
                GButton(
                  icon: UniconsLine.heart,
                  text: "",
                ),
                GButton(
                  icon: UniconsLine.heart,
                  text: "",
                ),
              ],
              selectedIndex: _index,
              onTabChange: (index) {
                setState(() {
                  _index = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
