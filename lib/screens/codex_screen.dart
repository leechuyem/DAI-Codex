import 'package:dai_codex/components/codex_text.dart';
import 'package:dai_codex/components/custom_sliver_app.dart';
import 'package:dai_codex/misc/helper.dart';
import 'package:dai_codex/misc/styles.dart';
import 'package:dai_codex/models/codex_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CodexScreen extends StatefulWidget {
  static const id = "Codex Screen";
  final CodexData codexData;

  CodexScreen({@required this.codexData});

  @override
  _CodexScreenState createState() => _CodexScreenState();
}

class _CodexScreenState extends State<CodexScreen> {
  List<String> lines = new List<String>();

  @override
  void initState() {
    super.initState();
    loadText();
  }

  void loadText() {
    Helper.loadMd(context, widget.codexData.codexPath).then((data) {
      setState(() {
        this.lines = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: CustomSliverAppBar(
                expandedHeight: 70,
                minHeight: 70,
                headerText: widget.codexData.title,
                leading: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      FontAwesomeIcons.chevronLeft,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              pinned: false,
              floating: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: Styles.bigSpacing),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Styles.smallSpacing),
                  child: CodexText(lines: this.lines,)
                ),
                SizedBox(height: Styles.bigSpacing,)
              ]),
            )
          ],
        ),
      ),
    );
  }
}
