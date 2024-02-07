class OrdersModel {
  int? code;
  List<Data>? data = [];
  String? message;

  OrdersModel();

  OrdersModel.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    data = json["data"] == null
        ? []
        : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x)));
    message =
    (json["data"] != null) ? json["message"] : json["message"]["error"];
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data,
    "message": message,
  };
}


class Data {
  int? id;
  int? business_pioneer_id;
  int? investor_id;
  int? project_id;
  int? is_paid;
  String? status;
  String? created_at;
  Project? project;
  Investor? investor;

  Data({
    this.id,
    this.project,
    this.business_pioneer_id,
    this.project_id,
    this.is_paid,
    this.status,
    this.investor_id,
    this.investor,
    this.created_at
  });

  factory Data.fromJson(Map<String, dynamic>? json) {
    return Data(
      id: json?["id"] ?? '',
      business_pioneer_id: json?["business_pioneer_id"] ?? '',
      project_id: json?["project_id"] ?? '',
      is_paid: json?["is_paid"] ?? '',
      status: json?["status"] ?? '',
      investor_id: json?["investor_id"] ?? '',
      created_at: json?["created_at"] ?? '',
      project: json?["project"] == null
          ? null
          : Project.fromJson(json?["project"]),
      investor: json?["investor"] == null
          ? null
          : Investor.fromJson(json?["investor"]),

    );
  }

}




class Project {
  Sector? sector;
  Categories? categories;
  InvestmentTour? investmentTour;
  BusinessPioneer? businessPioneer;
  int? id;
  String? name;
  String? problem_solve;
  String? how_solve;
  String? details;
  String? website;
  String? address;
  String? market_size;
  String? rivals;
  String? feature;
  String? build_up_date;
  int? partners_num;
  String? partners_name;
  int? profits;
  int? expenses;
  String? financing;
  String? contracs;
  int? category_id;
  int? sector_id;
  int? partnership_ratio;
  String? attachment;
  int? investment_tour_id;
  int? is_paid;
  int? investor_id;
  int? business_pioneer_id;
  String? status;
  String? investor;
  bool? is_featured;
  String? featured_vedio;
  String? featured_image;

  Project({
    this.id,
    this.sector_id,
    this.category_id,
    this.name,
    this.address,
    this.attachment,
    this.is_paid,
    this.build_up_date,
    this.business_pioneer_id,
    this.contracs,
    this.details,
    this.expenses,
    this.feature,
    this.featured_image,
    this.featured_vedio,
    this.financing,
    this.how_solve,
    this.investment_tour_id,
    this.investor,
    this.investor_id,
    this.is_featured,
    this.market_size,
    this.partners_name,
    this.partners_num,
    this.partnership_ratio,
    this.problem_solve,
    this.profits,
    this.rivals,
    this.status,
    this.website,
    this.businessPioneer,
    this.investmentTour,
    this.categories,
    this.sector,
  });

  factory Project.fromJson(Map<String, dynamic>? json) {
    return Project(
      id: json?["id"] ?? '',
      name: json?["name"] ?? '',
      problem_solve: json?["problem_solve"] ?? '',
      how_solve: json?["how_solve"] ?? '',
      details: json?["details"] ?? '',
      website: json?["website"] ?? '',
      address: json?["address"] ?? '',
      market_size: json?["market_size"] ?? '',
      rivals: json?["rivals"] ?? '',
      feature: json?["feature"] ?? '',
      build_up_date: json?["build_up_date"] ?? '',
      partners_num: json?["partners_num"] ?? '',
      partners_name: json?["partners_name"] ?? '',
      profits: json?["profits"] ?? '',
      expenses: json?["expenses"] ?? '',
      financing: json?["financing"] ?? '',
      contracs: json?["contracs"] ?? '',
      category_id: json?["category_id"] ?? '',
      sector_id: json?["sector_id"] ?? '',
      partnership_ratio: json?["partnership_ratio"] ?? '',
      attachment: json?["attachment"] ?? '',
      is_paid: json?["is_paid"] ?? '',
      investment_tour_id: json?["investment_tour_id"] ?? '',
      investor_id: json?["investor_id"] ?? '',
      business_pioneer_id: json?["business_pioneer_id"] ?? '',
      status: json?["status"] ?? '',
      investor: json?["investor"] ?? '',
      is_featured: json?["is_featured"] ?? '',
      featured_vedio: json?["featured_vedio"] ?? '',
      featured_image: json?["featured_image"] ?? '',
      // categories: json?["category"] ?? '',
      // investmentTour: json?["investment_tour"] ?? '',
      // businessPioneer: json?["business_pioneer"] ?? '',

      businessPioneer: json?["business_pioneer"] == null
          ? null
          : BusinessPioneer.fromJson(json?["business_pioneer"]),
      categories: json?["category"] == null
          ? null
          : Categories.fromJson(json?["category"]),
      investmentTour: json?["investment_tour"] == null
          ? null
          : InvestmentTour.fromJson(json?["investment_tour"]),
      sector: json?["sector"] == null ? null : Sector.fromJson(json?["sector"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "problem_solve": problem_solve,
    "featured_image": featured_image,
    "featured_vedio": featured_vedio,
    "is_featured": is_featured,
    "investor": investor,
    "status": status,
    "business_pioneer_id": business_pioneer_id,
    "investor_id": investor_id,
    "investment_tour_id": investment_tour_id,
    "attachment": attachment,
    "is_paid": is_paid,
    "partnership_ratio": partnership_ratio,
    "sector_id": sector_id,
    "category_id": category_id,
    "contracs": contracs,
    "financing": financing,
    "expenses": expenses,
    "profits": profits,
    "partners_name": partners_name,
    "partners_num": partners_num,
    "build_up_date": build_up_date,
    "feature": feature,
    "rivals": rivals,
    "market_size": market_size,
    "address": address,
    "website": website,
    "details": details,
    "how_solve": how_solve,
  };
}

class Sector {
  String? title;
  int? id;

  Sector({
    this.title,
    this.id,
  });

  factory Sector.fromJson(Map<String, dynamic>? json) {
    return Sector(
      id: json?["id"] ?? '',
      title: json?["title"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "type": title,
    "id": id,
  };
}

class Categories {
  String? title;
  int? id;

  Categories({
    this.title,
    this.id,
  });

  factory Categories.fromJson(Map<String, dynamic>? json) {
    return Categories(
      id: json?["id"] ?? '',
      title: json?["title"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "type": title,
    "id": id,
  };
}

class InvestmentTour {
  String? title;
  String? details;
  int? id;

  InvestmentTour({this.title, this.id, this.details});

  factory InvestmentTour.fromJson(Map<String, dynamic>? json) {
    return InvestmentTour(
      id: json?["id"] ?? '',
      title: json?["title"] ?? '',
      details: json?["details"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "type": title,
    "details": details,
    "id": id,
  };
}

class BusinessPioneer {
  String? type;
  String? email;
  int? id;
  int? categoryId;
  int? sectorId;
  String? name;
  String? userName;
  String? token;
  String? phone;
  String? national_num;
  String? nationalty;
  String? experience;
  String? image;
  int? experience_year;

  BusinessPioneer({
    this.email,
    this.id,
    this.name,
    this.token,
    this.experience_year,
    this.experience,
    this.national_num,
    this.nationalty,
    this.phone,
    this.type,
    this.sectorId,
    this.categoryId,
    this.image,
    this.userName,
  });

  factory BusinessPioneer.fromJson(Map<String, dynamic>? json) {
    return BusinessPioneer(
      type: json?["type"] ?? '',
      id: json?["id"] ?? '',
      name: json?["name"] ?? '',
      token: json?["token"] ?? '',
      national_num: json?["national_num"] ?? '',
      phone: json?["phone"] ?? '',
      nationalty: json?["nationalty"] ?? '',
      email: json?["email"] ?? '',
      experience: json?["experience"] ?? '',
      experience_year: json?["experience_year"] ?? '',
    );
  }

// Map<String, dynamic> toJson() => {
//   "type": title,
//   "details": details,
//   "id": id,
// };
}


class Investor{
  String? type;
  String? email;
  int? id;
  int? categoryId;
  int? sectorId;
  String? name;
  String? userName;
  String? token;
  String? phone;
  String? national_num;
  String? nationalty;
  String? experience;
  String? image;
  int? experience_year;
  SectorInv? sectorInv;
  CategoriesInv? categoriesInv;

  Investor({
    this.email,
    this.id,
    this.name,
    this.token,
    this.experience_year,
    this.experience,
    this.national_num,
    this.nationalty,
    this.phone,
    this.type,
    this.sectorId,
    this.categoryId,
    this.image,
    this.userName,
    this.categoriesInv,
    this.sectorInv
  });

  factory Investor.fromJson(Map<String, dynamic>? json) {
    return Investor(
      type: json?["type"] ?? '',
      id: json?["id"] ?? '',
      name: json?["name"] ?? '',
      token: json?["token"] ?? '',
      national_num: json?["national_num"] ?? '',
      phone: json?["phone"] ?? '',
      nationalty: json?["nationalty"] ?? '',
      email: json?["email"] ?? '',
      experience: json?["experience"] ?? '',
      experience_year: json?["experience_year"] ?? '',
      categoriesInv: json?["category"] == null
          ? null
          : CategoriesInv.fromJson(json?["category"]),
      sectorInv: json?["sector"] == null ? null : SectorInv.fromJson(json?["sector"]),
    );
  }

}


class SectorInv {
  String? title;
  int? id;

  SectorInv({
    this.title,
    this.id,
  });

  factory SectorInv.fromJson(Map<String, dynamic>? json) {
    return SectorInv(
      id: json?["id"] ?? '',
      title: json?["title"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "type": title,
    "id": id,
  };
}

class CategoriesInv {
  String? title;
  int? id;

  CategoriesInv({
    this.title,
    this.id,
  });

  factory CategoriesInv.fromJson(Map<String, dynamic>? json) {
    return CategoriesInv(
      id: json?["id"] ?? '',
      title: json?["title"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "type": title,
    "id": id,
  };
}



// Map<String, dynamic> toJson() => {
//   "type": title,
//   "details": details,
//   "id": id,
// };
