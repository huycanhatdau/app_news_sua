import 'package:auth_fire/import.dart';
import 'package:auth_fire/pages/account/home/controller.dart';

class AccountHomeMenu extends StatelessWidget {
  const AccountHomeMenu(this.params, {super.key});

  final Map params;

  @override
  Widget build(BuildContext context) {
    List menuItems = [
      {'id': '1', 'title': 'Thông tin tài khoản', 'route': '/account_information'},
      !empty(params['isAdmin']) ? {'id': '2', 'title': 'Tổng quan'} : {},
      {'id': '3', 'title': 'Cài đặt',},
    ];

    return GetBuilder<AccountHomeController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(color: Color(0x71949494), offset: Offset(0.0, 2.0), blurRadius: 4.0, spreadRadius: 0.0), //BoxShadow
                    BoxShadow(color: Colors.white, offset: Offset(0.0, 0.0), blurRadius: 0.0, spreadRadius: 0.0),
                  ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Thông tin cá nhân', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
                  h(10),
                  Text(!empty(params['title']) ? params['title'] : '-', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  h(10),
                  Text(!empty(params['phoneNumber']) ? params['phoneNumber'] : '-')
                ],
              ),
            ),
            h(60),
            ListView.builder(
              itemCount: menuItems.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Map item = menuItems[index];
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(color: Color(0x71949494), offset: Offset(0.0, 2.0), blurRadius: 4.0, spreadRadius: 0.0), //BoxShadow
                        BoxShadow(color: Colors.white, offset: Offset(0.0, 0.0), blurRadius: 0.0, spreadRadius: 0.0),
                      ]
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.person),
                        w(20),
                        Text(!empty(item['title']) ? item['title'] : '-', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios_outlined, size: 14,),
                      ],
                    ),
                  ),
                );
              },
            ),
            h(12),
            ButtonBase(
              onTap: () {
                controller.signOut();
              },
              title: 'Đăng xuất',
              isFull: true,
            )
          ],
        ),
      );
    });
  }
}
