import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/constants.dart';
import 'package:woke_out/model/administrative_unit.dart';

class AddressPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter your address", style: TextStyle(color: kTextColor),),
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context){
            return IconButton(
              icon: Icon(
                Icons.chevron_left,
                size: 30.0,
                color: kTextColor,
              ),
              onPressed: ()=> Navigator.of(context).pop()
            );
          },
        )
      ),
      body: Container(
        child: ListView(
          children: [
            Level1(),
            Level2(),
            Level3(),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(child: ButtonReset()),
                  Expanded(child: ButtonDone()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonReset extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(right: 10.0),
    child: TextButton(
          child: Text('Reset', style: TextStyle(color: kPrimaryColor, fontSize: 16),),
          onPressed: () =>
              AdministrativeUnit.of(context, listen: false).level1 = null,
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
          ),
        ),
  );
}

class ButtonDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(left: 10.0),
    child: ElevatedButton(
          child: Text('Done', style: TextStyle(color: Colors.white, fontSize: 16),),
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            backgroundColor: kPrimaryColor,
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
          ),
        ),
  );
}

class Level1 extends StatelessWidget {
  @override
  Widget build(BuildContext _) => Consumer<AdministrativeUnit>(
        builder: (context, data, _) => ListTile(
          title: Text('Level 1', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
          subtitle: Text(data.level1?.name ?? 'Tap to select level 1.', style: TextStyle(color: Colors.white),),
          onTap: () => _select1(context, data),
        ),
      );

  void _select1(BuildContext context, AdministrativeUnit data) async {
    final selected = await _select<dvhcvn.Level1>(context, dvhcvn.level1s);
    if (selected != null) data.level1 = selected;
  }
}

class Level2 extends StatefulWidget {
  @override
  _Level2State createState() => _Level2State();
}

class _Level2State extends State<Level2> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final data = AdministrativeUnit.of(context);
    if (data.latestChange == 1) {
      // user has just selected a level 1 entity,
      // automatically trigger bottom sheet for quick level 2 selection
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _select2(context, data));
    }
  }

  @override
  Widget build(BuildContext _) => Consumer<AdministrativeUnit>(
        builder: (context, data, _) => ListTile(
          title: Text('Level 2', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
          subtitle: Text(data.level2?.name ??
              (data.level1 != null
                  ? 'Tap to select level 2.'
                  : 'Select level 1 first.'), style: TextStyle(color: Colors.white),),
          onTap: data.level1 != null ? () => _select2(context, data) : null,
        ),
      );

  void _select2(BuildContext context, AdministrativeUnit data) async {
    final level1 = data.level1;
    if (level1 == null) return;

    final selected = await _select<dvhcvn.Level2>(
      context,
      level1.children,
      header: level1.name,
    );
    if (selected != null) data.level2 = selected;
  }
}

class Level3 extends StatefulWidget {
  @override
  _Level3State createState() => _Level3State();
}

class _Level3State extends State<Level3> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final data = AdministrativeUnit.of(context);
    if (data.latestChange == 2) {
      // user has just selected a level 2 entity,
      // automatically trigger bottom sheet for quick level 3 selection
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _select3(context, data));
    }
  }

  @override
  Widget build(BuildContext _) => Consumer<AdministrativeUnit>(
        builder: (context, data, _) => ListTile(
          title: Text('Level 3', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
          subtitle: Text(data.level3?.name ??
              (data.level2 != null
                  ? 'Tap to select level 3.'
                  : 'Select level 2 first.'), style: TextStyle(color: Colors.white),),
          onTap: data.level2 != null ? () => _select3(context, data) : null,
        ),
      );

  void _select3(BuildContext context, AdministrativeUnit data) async {
    final level2 = data.level2;
    if (level2 == null) return;

    final selected = await _select<dvhcvn.Level3>(
      context,
      level2.children,
      header: level2.name,
    );
    if (selected != null) data.level3 = selected;
  }
}

Future<T> _select<T extends dvhcvn.Entity>(
  BuildContext context,
  List<T> list, {
  String header,
}) =>
    showModalBottomSheet<T>(
      context: context,
      builder: (_) => Column(
        children: [
          // header (if provided)
          if (header != null)
            Padding(
              child: Text(
                header,
                style: Theme.of(context).textTheme.headline6,
              ),
              padding: const EdgeInsets.all(8.0),
            ),
          if (header != null) Divider(),

          // entities
          Expanded(
            child: ListView.builder(
              itemBuilder: (itemContext, i) {
                final item = list[i];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('#${item.id}, ${item.typeAsString}'),
                  onTap: () => Navigator.of(itemContext).pop(item),
                );
              },
              itemCount: list.length,
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
