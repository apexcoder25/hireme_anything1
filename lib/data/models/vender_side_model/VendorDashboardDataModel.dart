/// total_pending : 0
/// total_in_progress : 0
/// total_completed : 0
/// total_cancelled : 0

class VendorDashboardDataModel {
  VendorDashboardDataModel({
      num? totalPending, 
      num? totalInProgress, 
      num? totalCompleted, 
      num? totalCancelled,}){
    _totalPending = totalPending;
    _totalInProgress = totalInProgress;
    _totalCompleted = totalCompleted;
    _totalCancelled = totalCancelled;
}

  VendorDashboardDataModel.fromJson(dynamic json) {
    _totalPending = json['total_pending'];
    _totalInProgress = json['total_in_progress'];
    _totalCompleted = json['total_completed'];
    _totalCancelled = json['total_cancelled'];
  }
  num? _totalPending;
  num? _totalInProgress;
  num? _totalCompleted;
  num? _totalCancelled;
VendorDashboardDataModel copyWith({  num? totalPending,
  num? totalInProgress,
  num? totalCompleted,
  num? totalCancelled,
}) => VendorDashboardDataModel(  totalPending: totalPending ?? _totalPending,
  totalInProgress: totalInProgress ?? _totalInProgress,
  totalCompleted: totalCompleted ?? _totalCompleted,
  totalCancelled: totalCancelled ?? _totalCancelled,
);
  num? get totalPending => _totalPending;
  num? get totalInProgress => _totalInProgress;
  num? get totalCompleted => _totalCompleted;
  num? get totalCancelled => _totalCancelled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_pending'] = _totalPending;
    map['total_in_progress'] = _totalInProgress;
    map['total_completed'] = _totalCompleted;
    map['total_cancelled'] = _totalCancelled;
    return map;
  }

}