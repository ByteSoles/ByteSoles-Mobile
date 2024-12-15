// To parse this JSON data, do
//
//     final sneakerEntry = sneakerEntryFromJson(jsonString);

import 'dart:convert';

List<SneakerEntry> sneakerEntryFromJson(String str) => List<SneakerEntry>.from(json.decode(str).map((x) => SneakerEntry.fromJson(x)));

String sneakerEntryToJson(List<SneakerEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SneakerEntry {
    Model model;
    int pk;
    Fields fields;

    SneakerEntry({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory SneakerEntry.fromJson(Map<String, dynamic> json) => SneakerEntry(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String name;
    Brand brand;
    int price;
    DateTime releaseDate;
    String image;
    String slug;

    Fields({
        required this.name,
        required this.brand,
        required this.price,
        required this.releaseDate,
        required this.image,
        required this.slug,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        brand: brandValues.map[json["brand"]]!,
        price: json["price"],
        releaseDate: DateTime.parse(json["release_date"]),
        image: json["image"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "brand": brandValues.reverse[brand],
        "price": price,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "image": image,
        "slug": slug,
    };
}

enum Brand {
    ADIDAS,
    CROCS,
    JORDAN,
    MSCHF,
    NEW_BALANCE,
    NIKE,
    PUMA
}

final brandValues = EnumValues({
    "adidas": Brand.ADIDAS,
    "Crocs": Brand.CROCS,
    "Jordan": Brand.JORDAN,
    "MSCHF": Brand.MSCHF,
    "New Balance": Brand.NEW_BALANCE,
    "Nike": Brand.NIKE,
    "Puma": Brand.PUMA
});

enum Model {
    CATALOG_SNEAKER
}

final modelValues = EnumValues({
    "catalog.sneaker": Model.CATALOG_SNEAKER
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
