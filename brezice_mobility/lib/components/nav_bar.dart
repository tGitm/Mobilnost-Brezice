import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          accountName: Text('Oflutter.com'),
          accountEmail: Text('example@gmail.com'),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.network(
                'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                fit: BoxFit.cover,
                width: 90,
                height: 90,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
          ),
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text('Parkirna mesta'),
          onTap: () => null,
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Izposojevalnice koles'),
          onTap: () => null,
        ),
        ListTile(
          leading: Icon(Icons.share),
          title: Text('Električne polnilnice'),
          onTap: () => null,
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Defibrilatorji'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Prikazovalniki hitrosti'),
          onTap: () => null,
        ),
      ],
    );
  }
}