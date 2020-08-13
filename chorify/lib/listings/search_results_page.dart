import 'package:flutter/material.dart';
import '../listings/search.dart';

class SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class DataSearch extends SearchDelegate<String> {
  final occupations = [
    'Carpenter',
    'Landscaper',
    'Maid',
    'Mechanic',
    'Plumber',
  ];

  // Actions for app bar
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  // Leading icon on left of the app bar
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
        FocusScope.of(context).unfocus();
      },
    );
  }

  // Show result based on suggestion selection
  @override
  Widget buildResults(BuildContext context) {
    // Grid for the results after search
    return ListPage(query);
  }

  // What to show when someone searches for something
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = occupations.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
