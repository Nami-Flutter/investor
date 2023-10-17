class ChatModel {
  int? code;
  List<Data>? data = [];
  String? message;

  ChatModel();

  ChatModel.fromJson(dynamic json) {
    code = json['code'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    message =
        (json["data"] != null) ? json["message"] : json["message"]["error"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.orderId,
    this.fromUserId,
    this.toUserId,
    this.isRead,
    this.type,
    this.message,
    this.attach,
    this.order,
    this.fromUser,
    this.toUser,
    this.isPlaying = false,
    this.isLoad = false,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    orderId = json['order_id'];
    fromUserId = json['from_user_id'];
    toUserId = json['to_user_id'];
    isRead = json['is_read'];
    type = json['type'];
    message = json['message'];
    attach = json['attach'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    fromUser =
        json['from_user'] != null ? FromUser.fromJson(json['from_user']) : null;
    toUser = json['to_user'] != null ? ToUser.fromJson(json['to_user']) : null;
  }

  int? id;
  int? orderId;
  int? fromUserId;
  int? toUserId;
  bool? isRead;
  String? type;
  String? message;
  String? attach;
  Order? order;
  FromUser? fromUser;
  ToUser? toUser;
  bool isPlaying = false;
  bool isLoad=false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_id'] = orderId;
    map['from_user_id'] = fromUserId;
    map['to_user_id'] = toUserId;
    map['is_read'] = isRead;
    map['type'] = type;
    map['message'] = message;
    map['attach'] = attach;
    if (order != null) {
      map['order'] = order?.toJson();
    }
    if (fromUser != null) {
      map['from_user'] = fromUser?.toJson();
    }
    if (toUser != null) {
      map['to_user'] = toUser?.toJson();
    }
    return map;
  }
}

class ToUser {
  ToUser({
    this.id,
    this.name,
    this.email,
    this.type,
    this.phone,
    this.nationalNum,
    this.username,
    this.nationalty,
    this.experience,
    this.experienceYear,
    this.sectorId,
    this.categoryId,
    this.image,
    this.sector,
    this.category,
    this.token,
  });

  ToUser.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    type = json['type'];
    phone = json['phone'];
    nationalNum = json['national_num'];
    username = json['username'];
    nationalty = json['nationalty'];
    experience = json['experience'];
    experienceYear = json['experience_year'];
    sectorId = json['sector_id'];
    categoryId = json['category_id'];
    image = json['image'];
    sector =
        json['sector'] != null ? SectorToUser.fromJson(json['sector']) : null;
    category = json['category'] != null
        ? CategoryToUser.fromJson(json['category'])
        : null;
    token = json['token'];
  }

  int? id;
  String? name;
  String? email;
  String? type;
  String? phone;
  String? nationalNum;
  String? username;
  String? nationalty;
  String? experience;
  int? experienceYear;
  int? sectorId;
  int? categoryId;
  String? image;
  SectorToUser? sector;
  CategoryToUser? category;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['type'] = type;
    map['phone'] = phone;
    map['national_num'] = nationalNum;
    map['username'] = username;
    map['nationalty'] = nationalty;
    map['experience'] = experience;
    map['experience_year'] = experienceYear;
    map['sector_id'] = sectorId;
    map['category_id'] = categoryId;
    map['image'] = image;
    if (sector != null) {
      map['sector'] = sector?.toJson();
    }
    if (category != null) {
      map['category'] = category?.toJson();
    }
    map['token'] = token;
    return map;
  }
}

class CategoryToUser {
  CategoryToUser({
    this.id,
    this.title,
  });

  CategoryToUser.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }

  int? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }
}

class SectorToUser {
  SectorToUser({
    this.id,
    this.title,
  });

  SectorToUser.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }

  int? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }
}

class FromUser {
  FromUser({
    this.id,
    this.name,
    this.email,
    this.type,
    this.phone,
    this.nationalNum,
    this.username,
    this.nationalty,
    this.experience,
    this.experienceYear,
    this.sectorId,
    this.categoryId,
    this.image,
    this.sector,
    this.category,
    this.token,
  });

  FromUser.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    type = json['type'];
    phone = json['phone'];
    nationalNum = json['national_num'];
    username = json['username'];
    nationalty = json['nationalty'];
    experience = json['experience'];
    experienceYear = json['experience_year'];
    sectorId = json['sector_id'];
    categoryId = json['category_id'];
    image = json['image'];
    sector =
        json['sector'] != null ? SectorFromUser.fromJson(json['sector']) : null;
    category = json['category'] != null
        ? CategoryFromUser.fromJson(json['category'])
        : null;
    token = json['token'];
  }

  int? id;
  String? name;
  String? email;
  String? type;
  String? phone;
  String? nationalNum;
  String? username;
  String? nationalty;
  String? experience;
  int? experienceYear;
  int? sectorId;
  int? categoryId;
  String? image;
  SectorFromUser? sector;
  CategoryFromUser? category;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['type'] = type;
    map['phone'] = phone;
    map['national_num'] = nationalNum;
    map['username'] = username;
    map['nationalty'] = nationalty;
    map['experience'] = experience;
    map['experience_year'] = experienceYear;
    map['sector_id'] = sectorId;
    map['category_id'] = categoryId;
    map['image'] = image;
    if (sector != null) {
      map['sector'] = sector?.toJson();
    }
    if (category != null) {
      map['category'] = category?.toJson();
    }
    map['token'] = token;
    return map;
  }
}

class CategoryFromUser {
  CategoryFromUser({
    this.id,
    this.title,
  });

  CategoryFromUser.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }

  int? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }
}

class SectorFromUser {
  SectorFromUser({
    this.id,
    this.title,
  });

  SectorFromUser.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }

  int? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }
}

class Order {
  Order({
    this.id,
    this.businessPioneerId,
    this.investorId,
    this.status,
    this.projectId,
    this.project,
    this.investor,
    this.businessPioneer,
  });

  Order.fromJson(dynamic json) {
    id = json['id'];
    businessPioneerId = json['business_pioneer_id'];
    investorId = json['investor_id'];
    status = json['status'];
    projectId = json['project_id'];
    project = json['project'];
    investor = json['investor'];
    businessPioneer = json['business_pioneer'] != null
        ? BusinessPioneer.fromJson(json['business_pioneer'])
        : null;
  }

  int? id;
  int? businessPioneerId;
  int? investorId;
  String? status;
  int? projectId;
  dynamic project;
  dynamic investor;
  BusinessPioneer? businessPioneer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['business_pioneer_id'] = businessPioneerId;
    map['investor_id'] = investorId;
    map['status'] = status;
    map['project_id'] = projectId;
    map['project'] = project;
    map['investor'] = investor;
    if (businessPioneer != null) {
      map['business_pioneer'] = businessPioneer?.toJson();
    }
    return map;
  }
}

class BusinessPioneer {
  BusinessPioneer({
    this.id,
    this.name,
    this.email,
    this.type,
    this.phone,
    this.nationalNum,
    this.username,
    this.nationalty,
    this.experience,
    this.experienceYear,
    this.sectorId,
    this.categoryId,
    this.image,
    this.sector,
    this.category,
    this.token,
  });

  BusinessPioneer.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    type = json['type'];
    phone = json['phone'];
    nationalNum = json['national_num'];
    username = json['username'];
    nationalty = json['nationalty'];
    experience = json['experience'];
    experienceYear = json['experience_year'];
    sectorId = json['sector_id'];
    categoryId = json['category_id'];
    image = json['image'];
    sector = json['sector'];
    category = json['category'];
    token = json['token'];
  }

  int? id;
  String? name;
  String? email;
  String? type;
  String? phone;
  String? nationalNum;
  String? username;
  String? nationalty;
  String? experience;
  int? experienceYear;
  int? sectorId;
  int? categoryId;
  String? image;
  dynamic sector;
  dynamic category;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['type'] = type;
    map['phone'] = phone;
    map['national_num'] = nationalNum;
    map['username'] = username;
    map['nationalty'] = nationalty;
    map['experience'] = experience;
    map['experience_year'] = experienceYear;
    map['sector_id'] = sectorId;
    map['category_id'] = categoryId;
    map['image'] = image;
    map['sector'] = sector;
    map['category'] = category;
    map['token'] = token;
    return map;
  }
}
