import 'package:auth_fire/import.dart';
import 'package:auth_fire/pages/account/home/page.dart';
import 'package:auth_fire/pages/home/page.dart';

class ScaffoldDefault extends StatefulWidget {
  const ScaffoldDefault({super.key});

  @override
  State<ScaffoldDefault> createState() => _ScaffoldDefaultState();
}

class _ScaffoldDefaultState extends State<ScaffoldDefault> {
  int _indexBottom = 0;
  late List<BottomNavigationBarItem> _bottomItems;

  @override
  void initState() {
    super.initState();
    _setupMenu();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ScaffoldDefault oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _setupMenu() {
    _bottomItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Trang chủ'),
      const BottomNavigationBarItem(icon: Icon(Icons.newspaper_outlined), label: 'Tin tức'),
      const BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Thông báo'),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản'),
    ];
  }

  Future<void> onItemTappedTabBottom(int index) async {
    final uid = await storageLocal.getValue('loginBox', 'accountId');

    if (index == 3 && empty(uid)) {
      Get.toNamed('/account_home');
    } else {
      setState(() {
        factories['bottomNavigatorIndex'] = index;
        _indexBottom = index;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final List<Widget> items = <Widget>[
      const HomePage(),
      Container(color: Colors.redAccent),
      Container(color: Colors.green),
      const AccountHomePage()
    ];

    if (!empty(factories['bottomNavigatorIndex'])) {
      _indexBottom = parseInt(factories['bottomNavigatorIndex']);
      factories.remove('bottomNavigatorIndex');
    }

    if (_indexBottom >= items.length) {
      _indexBottom = items.length - 1;
    }

    return Scaffold(
      body: items[_indexBottom],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomItems,
        type: BottomNavigationBarType.fixed,
        currentIndex: _indexBottom,
        onTap: (index) => onItemTappedTabBottom(index),
      ),
    );
  }
}
