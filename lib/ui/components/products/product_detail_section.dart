// flutter imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// my app imports
import 'package:e_commerce/ui/components/primary_section_header.dart';

class ProductDetailSection extends StatelessWidget {
  final String headerTitle;
  final String body1;

  ProductDetailSection({@required this.headerTitle, @required this.body1});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PrimarySectionHeader(
          title: this.headerTitle,
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 22.0, right: 4.0, top: 4.0, bottom: 24.0),
              child: Text(
                this.body1,
                style: Theme.of(context).textTheme.body1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
