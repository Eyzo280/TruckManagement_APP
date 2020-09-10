import 'package:flutter/material.dart';

class SettingsUser extends StatefulWidget {
  @override
  _SettingsUserState createState() => _SettingsUserState();
}

class _SettingsUserState extends State<SettingsUser>
    with TickerProviderStateMixin {
  AnimationController _rotationController;
  Animation<double> animation;

  bool _open = false;

  @override
  void initState() {
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animation = Tween<double>(begin: _open ? 0 : 1.5, end: _open ? 1.5 : 0)
        .animate(_rotationController);

    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      elevation: 10,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        onTap: () {
          setState(() {
            _open = !_open;
            _rotationController.forward(from: 0);
          });
        },
        contentPadding: EdgeInsets.all(15),
        leading: Text('Avatar'),
        title: AnimatedContainer(
          width: double.infinity,
          height: _open
              ? (MediaQuery.of(context).size.height * 0.035) * 13
              : MediaQuery.of(context).size.height * 0.035,
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !_open
                  ? Text(
                      'nickName',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  : Expanded(
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              Text(
                                'nickName:',
                                style: TextStyle(fontSize: 20),
                              ),
                              Expanded(child: TextField())
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Imię:',
                                style: TextStyle(fontSize: 20),
                              ),
                              Expanded(child: TextField())
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Nazwisko:',
                                style: TextStyle(fontSize: 20),
                              ),
                              Expanded(child: TextField())
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Numer Tel:',
                                style: TextStyle(fontSize: 20),
                              ),
                              Expanded(child: TextField())
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Doswiadczenie:',
                                style: TextStyle(fontSize: 20),
                              ),
                              Expanded(child: TextField())
                            ],
                          ),
                          SizedBox(
                            height:
                                (MediaQuery.of(context).size.height * 0.035),
                          ),
                          RaisedButton(
                            onPressed: () {},
                            child: Text('Zapisz'),
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_open)
              Text(
                'Edit Profile',
                style: TextStyle(fontSize: 15),
              ),
          ],
        ),
        trailing: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.rotate(
              angle: animation.value,
              child: Icon(
                Icons.keyboard_arrow_right,
              ),
            );
          },
        ),
      ),
    );
  }
}
