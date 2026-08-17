import 'package:flutter/material.dart';

class ScreenSearchView extends StatefulWidget {
  final Widget body;
  final String title;
  final String? querySearch;
  final Function(String query)? onSearch;
  final Function()? onClose;
  final bool isLoading;

  const ScreenSearchView({
    Key? key,
    required this.title,
    required this.body,
    this.querySearch,
    this.onSearch,
    this.onClose,
    this.isLoading = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ScreenSearchViewState();
  }
}

class ScreenSearchViewState extends State<ScreenSearchView> {
  late TextEditingController _filter;
  late Icon _searchIcon;
  late Widget _appBarTitle;
  bool _visibleIcon = true;

  set visibleIcon(bool value) {
    setState(() {
      _visibleIcon = value;
    });
  }

  bool get _showLoadingIcon => widget.isLoading && _visibleIcon;

  @override
  void initState() {
    super.initState();
    _filter = TextEditingController(text: widget.querySearch);
    if(widget.querySearch == null || widget.querySearch?.isEmpty == true){
      _configureAppBarTitle();
    }
    else{
      _configureAppBarSearch();
    }
  }

  void _configureAppBarTitle(){
    _searchIcon = const Icon(Icons.search);
    _appBarTitle = Text(
      widget.title,
      style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
      ),
    );
    _filter.clear();
  }

  void _configureAppBarSearch(){
    _searchIcon = const Icon(Icons.close);
    _appBarTitle = TextField(
      autofocus: true,
      controller: _filter,
      cursorColor: Colors.white,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
      ),
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search,color: Colors.white,),
          hintText: 'Search...',
          hintStyle: TextStyle(
              color: Colors.white70,
          ),
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: (query){
        setState(() {
          if(query.trim().isEmpty){
            _configureAppBarTitle();
          }
          widget.onSearch?.call(query);
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: _appBarTitle,
          centerTitle: true,
          actions: widget.onSearch != null
              ? <Widget>[
                  if (_showLoadingIcon)
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white70,
                        ),
                      ),
                    )
                  else if (_visibleIcon)
                    IconButton(
                      icon: _searchIcon,
                      onPressed: () {
                        setState(() {
                          if (_searchIcon.icon == Icons.search) {
                            _configureAppBarSearch();
                          } else {
                            _filter.clear();
                            _configureAppBarTitle();
                            if (widget.onClose != null) {
                              widget.onClose!();
                            }
                          }
                        });
                      },
                    ),
                ]
              : null,
        ),
        Expanded(child: widget.body),
      ],
    );
  }

}
