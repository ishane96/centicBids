class Item {
  var id;
  var title;
  var description;
  var basePrice;
  var latestBid;
  var itemImg;
  var time;

  Item(
      {
      this.id,
      this.title,
      this.description,
      this.basePrice,
      this.latestBid,
      this.itemImg,
      this.time});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        basePrice: json['basePrice'],
        latestBid: json['latestBid'],
        itemImg: json['itemImg'],
        time: json['time']);
  }
}
