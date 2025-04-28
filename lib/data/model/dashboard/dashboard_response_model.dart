// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_null_aware_operators

import 'package:erosta_loans/data/model/global/meassage_model.dart';

import 'package:erosta_loans/data/model/loan/running_loan_response.dart';
import 'package:erosta_loans/data/model/user/user.dart';

class DashboardResponseModel {
  DashboardResponseModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,
  }) {
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  DashboardResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _remark;
  String? _status;
  Message? _message;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    User? user,
    Insights? insights,
    DashboardData? dashboardData,
    LatestCredits? latestCredits,
    LatestDebits? latestDebits,
    List<RunningLoanModel>? myLoan,
  }) {
    _user = user;
    _insights = insights;
    _dashboardData = dashboardData;
    _dashboardData = dashboardData;
    _latestCredits = latestCredits;
    _latestDebits = latestDebits;
    _runningLoanList = runningLoanList;
  }

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _insights = json['insights'] != null ? Insights.fromJson(json['insights']) : null;
    _dashboardData = json['dashboard_data'] != null ? DashboardData.fromJson(json['dashboard_data']) : null;
    _latestCredits = json['latest_credits'] != null ? LatestCredits.fromJson(json['latest_credits']) : null;
    _latestDebits = json['latest_debits'] != null ? LatestDebits.fromJson(json['latest_debits']) : null;
    _runningLoanList = json["running_loans"] == null ? [] : List<RunningLoanModel>.from(json["running_loans"]!.map((x) => RunningLoanModel.fromJson(x)));
  }

  User? _user;
  DashboardData? _dashboardData;
  LatestCredits? _latestCredits;
  LatestDebits? _latestDebits;
  Insights? _insights;
  List<RunningLoanModel>? _runningLoanList;

  User? get user => _user;
  DashboardData? get dashboardData => _dashboardData;
  LatestCredits? get latestCredits => _latestCredits;
  LatestDebits? get latestDebits => _latestDebits;
  Insights? get insights => _insights;
  List<RunningLoanModel>? get runningLoanList => _runningLoanList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_insights != null) {
      map['insights'] = _insights?.toJson();
    }
    if (_dashboardData != null) {
      map['dashboard_data'] = _dashboardData?.toJson();
    }
    if (_latestCredits != null) {
      map['latest_credits'] = _latestCredits?.toJson();
    }
    if (_latestDebits != null) {
      map['latest_debits'] = _latestDebits?.toJson();
    }
    return map;
  }
}

class LatestDebits {
  LatestDebits({List<LatestDebitsData>? data, dynamic nextPageUrl, String? path}) {
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;
  }

  LatestDebits.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LatestDebitsData.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
  }

  List<LatestDebitsData>? _data;
  dynamic _nextPageUrl;
  String? _path;

  List<LatestDebitsData>? get data => _data;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    return map;
  }
}

class LatestDebitsData {
  LatestDebitsData({int? id, String? userId, String? branchId, String? branchStaffId, String? amount, String? charge, String? postBalance, String? trxType, String? trx, String? details, String? remark, String? createdAt, String? updatedAt}) {
    _id = id;
    _userId = userId;
    _branchId = branchId;
    _branchStaffId = branchStaffId;
    _amount = amount;
    _charge = charge;
    _postBalance = postBalance;
    _trxType = trxType;
    _trx = trx;
    _details = details;
    _remark = remark;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  LatestDebitsData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _branchId = json['branch_id'].toString();
    _branchStaffId = json['branch_staff_id'].toString();
    _amount = json['amount'].toString();
    _charge = json['charge'].toString();
    _postBalance = json['post_balance'].toString();
    _trxType = json['trx_type'].toString();
    _trx = json['trx'].toString();
    _details = json['details'] != null ? json['details'].toString() : '';
    _remark = json['remark'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _userId;
  String? _branchId;
  String? _branchStaffId;
  String? _amount;
  String? _charge;
  String? _postBalance;
  String? _trxType;
  String? _trx;
  String? _details;
  String? _remark;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get userId => _userId;
  String? get branchId => _branchId;
  String? get branchStaffId => _branchStaffId;
  String? get amount => _amount;
  String? get charge => _charge;
  String? get postBalance => _postBalance;
  String? get trxType => _trxType;
  String? get trx => _trx;
  String? get details => _details;
  String? get remark => _remark;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['branch_id'] = _branchId;
    map['branch_staff_id'] = _branchStaffId;
    map['amount'] = _amount;
    map['charge'] = _charge;
    map['post_balance'] = _postBalance;
    map['trx_type'] = _trxType;
    map['trx'] = _trx;
    map['details'] = _details;
    map['remark'] = _remark;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class LatestCredits {
  LatestCredits({List<LatestCreditsData>? data, dynamic nextPageUrl, String? path}) {
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;
  }

  LatestCredits.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LatestCreditsData.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
  }

  List<LatestCreditsData>? _data;
  dynamic _nextPageUrl;
  String? _path;

  List<LatestCreditsData>? get data => _data;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    return map;
  }
}

class LatestCreditsData {
  LatestCreditsData({String? id, String? userId, String? branchId, String? branchStaffId, String? amount, String? charge, String? postBalance, String? trxType, String? trx, String? details, String? remark, String? createdAt, String? updatedAt}) {
    _id = id;
    _userId = userId;
    _branchId = branchId;
    _branchStaffId = branchStaffId;
    _amount = amount;
    _charge = charge;
    _postBalance = postBalance;
    _trxType = trxType;
    _trx = trx;
    _details = details;
    _remark = remark;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  LatestCreditsData.fromJson(dynamic json) {
    _id = json['id'].toString();
    _userId = json['user_id'].toString();
    _branchId = json['branch_id'].toString();
    _branchStaffId = json['branch_staff_id'].toString();
    _amount = json['amount'] != null ? json['amount'].toString() : '00';
    _charge = json['charge'] != null ? json['charge'].toString() : '0';
    _postBalance = json['post_balance'] != null ? json['post_balance'].toString() : '00';
    _trxType = json['trx_type'].toString();
    _trx = json['trx'].toString();
    _details = json['details'].toString();
    _remark = json['remark'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _userId;
  String? _branchId;
  String? _branchStaffId;
  String? _amount;
  String? _charge;
  String? _postBalance;
  String? _trxType;
  String? _trx;
  String? _details;
  String? _remark;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get userId => _userId;
  String? get branchId => _branchId;
  String? get branchStaffId => _branchStaffId;
  String? get amount => _amount;
  String? get charge => _charge;
  String? get postBalance => _postBalance;
  String? get trxType => _trxType;
  String? get trx => _trx;
  String? get details => _details;
  String? get remark => _remark;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['branch_id'] = _branchId;
    map['branch_staff_id'] = _branchStaffId;
    map['amount'] = _amount;
    map['charge'] = _charge;
    map['post_balance'] = _postBalance;
    map['trx_type'] = _trxType;
    map['trx'] = _trx;
    map['details'] = _details;
    map['remark'] = _remark;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class DashboardData {
  DashboardData({
    String? totalDeposit,
    String? totalFdr,
    String? totalWithdraw,
    String? totalLoan,
    String? totalDps,
    String? totalTrx,
  }) {
    _totalDeposit = totalDeposit;
    _totalFdr = totalFdr;
    _totalWithdraw = totalWithdraw;
    _totalLoan = totalLoan;
    _totalDps = totalDps;
    _totalTrx = totalTrx;
  }

  DashboardData.fromJson(dynamic json) {
    _totalDeposit = json['total_deposit'].toString();
    _totalFdr = json['total_fdr'].toString();
    _totalWithdraw = json['total_withdraw'].toString();
    _totalLoan = json['total_loan'].toString();
    _totalDps = json['total_dps'].toString();
    _totalTrx = json['total_trx'].toString();
  }

  String? _totalDeposit;
  String? _totalFdr;
  String? _totalWithdraw;
  String? _totalLoan;
  String? _totalDps;
  String? _totalTrx;

  String? get totalDeposit => _totalDeposit;
  String? get totalFdr => _totalFdr;
  String? get totalWithdraw => _totalWithdraw;
  String? get totalLoan => _totalLoan;
  String? get totalDps => _totalDps;
  String? get totalTrx => _totalTrx;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_deposit'] = _totalDeposit;
    map['total_fdr'] = _totalFdr;
    map['total_withdraw'] = _totalWithdraw;
    map['total_loan'] = _totalLoan;
    map['total_dps'] = _totalDps;
    map['total_trx'] = _totalTrx;
    return map;
  }
}

//note: this is insigment data

class Insights {
  String? remainingLoanAmount;
  String? runningLoan;
  String? pendingLoan;
  String? nextInstallmentAmount;
  String? nextInstallmentDate;

  Insights({
    this.remainingLoanAmount,
    this.runningLoan,
    this.pendingLoan,
    this.nextInstallmentAmount,
    this.nextInstallmentDate,
  });

  factory Insights.fromJson(Map<String, dynamic> json) => Insights(
        remainingLoanAmount: json["remaining_loan_amount"].toString(),
        runningLoan: json["running_loan"].toString(),
        pendingLoan: json["pending_loan"].toString(),
        nextInstallmentAmount: json["next_installment_amount"].toString(),
        nextInstallmentDate: json["next_installment_date"] == null ? null : json["next_installment_date"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "remaining_loan_amount": remainingLoanAmount,
        "running_loan": runningLoan,
        "pending_loan": pendingLoan,
        "next_installment_amount": nextInstallmentAmount,
        "next_installment_date": nextInstallmentDate,
      };
}
