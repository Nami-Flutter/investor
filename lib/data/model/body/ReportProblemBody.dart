class ReportProblemBody {
  int? problem_id;
  String? details;

  ReportProblemBody({
    this.problem_id,
    this.details,
  });

  factory ReportProblemBody.fromJson(Map<String, dynamic> json) => ReportProblemBody(
    problem_id: json["problem_id"],
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "problem_id": problem_id,
    "details": details,
  };
}
