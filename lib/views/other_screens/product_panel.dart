
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/constants/colors.dart';

class PanelWidget extends StatefulWidget {

  final ScrollController controller;
  final snap;
  final PanelController panelController;

  const PanelWidget({
    Key? key,
    required this.controller,
    required this.snap,
    required this.panelController,
  }) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {

  void togglePanel() => widget.panelController.isPanelOpen
      ? widget.panelController.close()
      : widget.panelController.open();

  // @override
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              color: darkGreyColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(
                    0,
                    0.5,
                  ),
                  blurRadius: 1,
                  spreadRadius: 0,
                ),
              ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              16.heightBox,
              GestureDetector(
                onTap: (){
                  togglePanel();
                },
                child: Container(
                  height: 6,
                  width: 32,
                  decoration: BoxDecoration(
                    color: textDarkGreyColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              16.heightBox,
              const Text(
                "Hello",
                style: TextStyle(
                  fontFamily: "Lato",
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              12.heightBox,
            ],
          ),
        ),
        ListView(
          padding: EdgeInsets.zero,
          controller: widget.controller,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            // content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  24.heightBox,
                  36.heightBox,
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}