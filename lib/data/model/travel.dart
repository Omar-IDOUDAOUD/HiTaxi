class TravelModel {
  int id;
  String? createdAt;
  String driverName;
  String fromPlace;
  String toPlace;
  String departureTime;
  int maximumPassengers;
  double? price;
  String? cart;
  String? cartMark;
  String? cartImage;
  String? backBoxVolume;
  String? freePlacesLeft;

  TravelModel({
    required this.id,
    this.createdAt,
    required this.driverName,
    required this.fromPlace,
    required this.toPlace,
    required this.departureTime,
    required this.maximumPassengers,
    this.price,
    this.cart,
    this.cartMark,
    this.cartImage,
    this.backBoxVolume,
    this.freePlacesLeft,
  });

  factory TravelModel.fromJson(Map<String, dynamic> data) => TravelModel(
        id: data['id'],
        createdAt: data['created_at'],
        driverName: data['driver_name'],
        fromPlace: data['from_place'],
        toPlace: data['to_place'],
        departureTime: data['departure_time'],
        maximumPassengers: data['maximum_passengers'],
        price: data['price'],
        cart: data['cart'],
        cartImage: data['cart_image'],
        cartMark: data['cart_mark'],
        backBoxVolume: data['back_box_volume'],
        freePlacesLeft: data['free_places_left'],
      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'created_at': this.createdAt,
        'driver_name': this.driverName,
        'from_place': this.fromPlace,
        'to_place': this.toPlace,
        'departure_time': this.departureTime,
        'maximum_passengers': this.maximumPassengers,
        'price': this.price,
        'cart': this.cart,
        'cart_image': this.cartImage,
        'cart_mark': this.cartMark,
        'back_box_volume': this.backBoxVolume,
        'free_places_left': this.freePlacesLeft,
      };
}