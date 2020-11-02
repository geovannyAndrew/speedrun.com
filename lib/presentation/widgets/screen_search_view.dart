import 'package:flutter/material.dart';

class ScreenSearchView extends StatefulWidget {
  final Widget body;
  final String title;
  final String querySearch;
  final Function(String query) onSearch;
  final Function() onClose;

  ScreenSearchView({
    Key key,
    this.title,
    this.body,
    this.querySearch,
    this.onSearch,
    this.onClose,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScreenSearchViewState();
  }
}

class ScreenSearchViewState extends State<ScreenSearchView> {
  TextEditingController _filter;
  Icon _searchIcon;
  Widget _appBarTitle;
  bool _visibleIcon = true;

  set visibleIcon(bool value) {
    setState(() {
      _visibleIcon = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filter = new TextEditingController(text: widget.querySearch);
    if (this.widget.querySearch == null ||
        this.widget.querySearch?.isEmpty == true) {
      _configureAppBarTitle();
    } else {
      _configureAppBarSearch();
    }
  }

  void _configureAppBarTitle() {
    this._searchIcon = new Icon(Icons.search);
    this._appBarTitle = Text(
      widget.title ?? "",
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    );
    _filter.clear();
  }

  void _configureAppBarSearch() {
    this._searchIcon = new Icon(Icons.close);
    this._appBarTitle = new TextField(
      autofocus: true,
      controller: _filter,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      decoration: new InputDecoration(
          prefixIcon: new Icon(
            Icons.search,
            color: Colors.white,
          ),
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.white70)),
      textInputAction: TextInputAction.search,
      onSubmitted: (query) {
        setState(() {
          if (query.trim().isEmpty) {
            _configureAppBarTitle();
          }
          widget.onSearch(query);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        AppBar(
            title: _appBarTitle,
            centerTitle: true,
            actions: widget.onSearch != null
                ? <Widget>[
                    Visibility(
                      visible: _visibleIcon,
                      child: IconButton(
                        icon: _searchIcon,
                        onPressed: () {
                          setState(() {
                            if (this._searchIcon.icon == Icons.search) {
                              _configureAppBarSearch();
                            } else {
                              _filter.clear();
                              _configureAppBarTitle();
                              if (widget.onClose != null) {
                                widget.onClose();
                              }
                            }
                          });
                        },
                      ),
                    )
                  ]
                : null),
        Expanded(child: widget.body)
      ],
    );
  }
}
