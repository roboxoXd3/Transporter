class Item {
  Item({
    this.id,
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });
  int id;
  String expandedValue;
  String headerValue;
  bool isExpanded;
}