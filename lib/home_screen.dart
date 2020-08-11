import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  var _headerTitleColor=Colors.grey[800];

  DateTime _dateOfBirth;
  DateTime _todayDate;

  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController _todayDateController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    Widget dateOfBirth        = buildDateOfBirthWidget();
    Widget todayDate          = buildTodayDateWidget();
    Widget clearCalculateRow  = buildClearCalculateRow();

    Widget yourAgeRow         = buildYourAgeRow();
    Widget nextBirthDayRow    = buildNextBirthday();

    Widget spacing = buildSpacing();

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          dateOfBirth,
          spacing,
          todayDate,
          spacing,
          clearCalculateRow,
          spacing,
          yourAgeRow,
          spacing,
          nextBirthDayRow
        ],
      ),
    );
  }

  Widget buildDateOfBirthWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildHeader("Date Of Birth"),
        InkWell(
          onTap: () async {
              setState(() {
                _selectDate(context).then((value){
                  _dateOfBirth =value;
                  _dateOfBirthController.text = _getFormattedDate(_dateOfBirth);
                });

              });
          },
          child: TextField(
            controller: _dateOfBirthController,
            enabled: false,
            decoration: _getDateTextDecoration(),

          ),
        ),
      ],
    );
  }

  Widget buildTodayDateWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildHeader("Today"),
        InkWell(
          onTap: (){
            setState(() {
              _selectDate(context).then((value){
                _todayDate =value;
                _todayDateController.text = _getFormattedDate(_todayDate);
              });

            });
          },
          child: TextField(
            enabled: false,
            controller: _todayDateController,
            decoration: _getDateTextDecoration(),
          ),
        ),
      ],
    );
  }

  Widget _buildStylesActionButton(String buttonName, Function onPressedCallback) {
    return Container(
      width: 150,
      height: 50,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: onPressedCallback,
        child: Text(buttonName.toUpperCase(),
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  Widget _buildOutputBox(String fieldName) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          width: 115,
          height: 30,
          child: Center(
              child: Text(
            fieldName,
            style: TextStyle(color: Colors.white),
          )),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(
            color: Theme.of(context).primaryColor,
          )),
          width: 115,
          height: 30,
          child: Center(
              child: Text(
            "",
            style: TextStyle(color: Colors.grey),
          )),
        )
      ],
    );
  }

  Widget buildClearCalculateRow() {
    Widget clearButton = _buildStylesActionButton("Clear", (){
      setState(() {
        _dateOfBirth = DateTime.now();
        _dateOfBirthController.text = _getFormattedDate(_dateOfBirth);

        _todayDate = DateTime.now();
        _todayDateController.text = _getFormattedDate(_dateOfBirth);

      });
    });
    Widget calcButton = _buildStylesActionButton("Calculate", (){
      //TODO -- calculate age and set it to a variable then setState

    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        clearButton,
        calcButton,
      ],
    );
  }

  Widget buildYourAgeRow() {
    Widget years  = _buildOutputBox("Years");
    Widget months = _buildOutputBox("Months");
    Widget days   = _buildOutputBox("Days");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Age is",
            style: TextStyle(fontSize: 20, color: _headerTitleColor),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            years,
            months,
            days,
          ],
        )
      ],
    );
  }

  Widget buildNextBirthday() {
    Widget years  = _buildOutputBox("Years");
    Widget months = _buildOutputBox("Months");
    Widget days   = _buildOutputBox("Days");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Next Birth Day in",
            style: TextStyle(fontSize: 20, color: _headerTitleColor),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            years,
            months,
            days,
          ],
        ),
      ],
    );
  }


  Widget buildSpacing() {
    return SizedBox(height: 20);
  }

  _getDateTextDecoration() {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
        ),
      ),
      border: OutlineInputBorder(borderSide: BorderSide(        color: Theme.of(context).primaryColor,
      )),
      suffixIcon: Icon(
        Icons.date_range,
          color: Theme.of(context).primaryColor,

      ),
      hintText: '01-01-2018',
    );
  }

  _buildHeader(String headerText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child:
          Text(headerText, style: TextStyle(color: _headerTitleColor, fontSize: 20)),
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    return picked;
  }

  String _getFormattedDate(DateTime todayDate) {
    return "${todayDate.year.toString()}-${todayDate.month.toString().padLeft(2,'0')}-${todayDate.day.toString().padLeft(2,'0')}";

  }
}
