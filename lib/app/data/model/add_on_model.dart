class AddonCat {
  String addonCategory;

  AddonCat({
    required this.addonCategory,
  });

  factory AddonCat.fromJson(Map<String, dynamic> json) => AddonCat(
    addonCategory: json["addon_category"],
  );

  Map<String, dynamic> toJson() => {
    "addon_category": addonCategory,
  };
}