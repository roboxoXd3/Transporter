import 'package:Transporter/util/ExpansionTileItem.dart';
import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/theme.dart';
import 'package:flutter/material.dart';

class FaQ extends StatefulWidget {
  FaQ({Key key}) : super(key: key);

  @override
  _FaQState createState() => _FaQState();
}

class _FaQState extends State<FaQ> {

  List<Item> faqPanel = [];

  @override
  void initState() {
    super.initState();
    faqPanel = generateItems(5);
  }
   List<Item> generateItems(int numberOfItems ) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      id: index,
      headerValue: 'How do I get help with my subscription?',
      expandedValue: 'This is the ans',
    );
  });
} 
 Widget _buildPanel() {
    return ExpansionPanelList.radio(
      initialOpenPanelValue: 2,
      expandedHeaderPadding: EdgeInsets.all(0),
      children: faqPanel.map<ExpansionPanelRadio>((Item item) {
        return ExpansionPanelRadio(
            value: item.id,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text('Q : ${item.headerValue}',style: AppStyles.blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),),
              );
            },
            canTapOnHeader: true,
            body: ListTile(
              dense: true,
                title: Text('A : ${item.expandedValue}',style: AppStyles.blackTextStyle),
                ));
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white
            ),
            title: Text('FAQ',style: TextStyle(
                    fontFamily: 'Arial',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                  ),),
            backgroundColor: AppColors.driverprimaryColor,
            
          ),
       body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
              width: double.infinity,
              height: SizeConfig.screenHeight,
              child: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                           Container(
                           child: _buildPanel(),
                         )
                        ]))));})))
    );
  }
}