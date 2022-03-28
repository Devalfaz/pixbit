import 'package:flutter/material.dart';
import '../models/users.dart';
import '../utils/constants.dart';

class Details extends StatefulWidget {
  final UsersDataData data;
  const Details({Key? key, required this.data}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
            ],
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
                title: Text('${widget.data.firstName}'),
                background: Image.network(
                  "$SERVER_ADDRESS${widget.data.profilePicture}",
                )),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('${widget.data.firstName}'),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate.fixed([
            ListTile(
              leading: Icon(Icons.call),
              title: Text('${widget.data.mobile}'),
              subtitle: Text('Mobile'),
              trailing: Icon(Icons.message),
            ),
            ListTile(
              leading: SizedBox(
                height: 12,
                width: 12,
              ),
              title: Text('${widget.data.landline}'),
              subtitle: Text('Land'),
              trailing: Icon(Icons.message),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('${widget.data.email}'),
              subtitle: Text('Personal'),
            ),
            ListTile(
              leading: SizedBox(
                height: 12,
                width: 12,
              ),
              title: Text('${widget.data.email}'),
              subtitle: Text('Work'),
            ),
            Divider(),
          ]))
        ],
      ),
    );
  }
}
