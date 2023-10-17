class AddInvestmentModel {
  int? business_pioneer_id;
  int? project_id;

  AddInvestmentModel({
    this.business_pioneer_id,
    this.project_id,
  });

  factory AddInvestmentModel.fromJson(Map<String, dynamic> json) => AddInvestmentModel(
    business_pioneer_id: json["business_pioneer_id"],
    project_id: json["project_id"],
  );

  Map<String, dynamic> toJson() => {
    "business_pioneer_id": business_pioneer_id,
    "project_id": project_id,
  };
}
