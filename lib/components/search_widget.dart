import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final Function(String)? textChanged;

  SearchBox({this.textChanged});

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  late TextEditingController controller;
  late FocusNode focusNode;
  bool canCancel = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    focusNode = FocusNode()..addListener(focusListener);
  }

  void focusListener() => setState(() => canCancel = focusNode.hasFocus);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        searchTextField(),
        cancelButton(),
      ],
    );
  }

  Widget searchTextField() {
    return Expanded(
      child: TextField(
        style: TextStyle(height: 2),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
          hintText: 'Enter the country name',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(
            Icons.location_on_rounded,
            color: Color(0xFFFB6F3D),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        keyboardType: TextInputType.text,
        onChanged: (text) => widget.textChanged!(text),
        focusNode: focusNode,
      ),
    );
  }

  Widget cancelButton() {
    return Visibility(
      visible: canCancel,
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        child: GestureDetector(
          child: Icon(Icons.cancel, color: Color(0xFFFB6F3D), size: 30),
          onTap: onCancel,
        ),
      ),
    );
  }

  void onCancel() {
    if (controller.text.isEmpty) focusNode.unfocus();
    setState(() {
      widget.textChanged!('');
      controller.text = '';
    });
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
