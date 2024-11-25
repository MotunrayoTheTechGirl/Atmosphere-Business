class GetAdsByAdvertiserIdResModel {
    GetAdsByAdvertiserIdResModel({
        required this.id,
        required this.advertiserId,
        required this.title,
        required this.description,
        required this.type,
        required this.size,
        required this.deviceType,
        required this.displayContentUrl,
        required this.targetUrl,
        required this.budget,
        required this.category,
        required this.callToActionText,
        required this.duration,
        required this.startDate,
        required this.endDate,
        required this.status,
        required this.dateCreated,
        required this.updatedAt,
        required this.isDeleted,
        required this.amountSpent,
        required this.totalReach,
        required this.totalImpressions,
        required this.totalVisits,
        required this.totalClicks,
        required this.totalViews,
        required this.businessCategory,
        required this.adspaceId,
        required this.adSpaceSectionId,
        required this.declineReason,
        required this.approvelUserId,
        required this.approvalNote,
        required this.reason,
        required this.screens,
        required this.isApproved,
        required this.lastTotalViews,
        required this.lastTotalReachs,
        required this.lastTotalImpressions,
        required this.lastTotalVisits,
        required this.lastTotalClicks,
        required this.metricDate,
        required this.questions,
        required this.regionIds,
        required this.advertiser,
    });

    final int? id;
    final int? advertiserId;
    final String? title;
    final String? description;
    final String? type;
    final String? size;
    final String? deviceType;
    final String? displayContentUrl;
    final String? targetUrl;
    final int? budget;
    final String? category;
    final String? callToActionText;
    final int? duration;
    final DateTime? startDate;
    final DateTime? endDate;
    final String? status;
    final DateTime? dateCreated;
    final DateTime? updatedAt;
    final int? isDeleted;
    final dynamic amountSpent;
    final dynamic totalReach;
    final dynamic totalImpressions;
    final dynamic totalVisits;
    final dynamic totalClicks;
    final int? totalViews;
    final String? businessCategory;
    final dynamic adspaceId;
    final dynamic adSpaceSectionId;
    final dynamic declineReason;
    final dynamic approvelUserId;
    final String? approvalNote;
    final String? reason;
    final String? screens;
    final bool? isApproved;
    final dynamic lastTotalViews;
    final dynamic lastTotalReachs;
    final dynamic lastTotalImpressions;
    final dynamic lastTotalVisits;
    final dynamic lastTotalClicks;
    final dynamic metricDate;
    final dynamic questions;
    final List<dynamic> regionIds;
    final Advertiser? advertiser;

    factory GetAdsByAdvertiserIdResModel.fromJson(Map<String, dynamic> json){ 
        return GetAdsByAdvertiserIdResModel(
            id: json["id"],
            advertiserId: json["advertiserId"],
            title: json["title"],
            description: json["description"],
            type: json["type"],
            size: json["size"],
            deviceType: json["device_type"],
            displayContentUrl: json["displayContentUrl"],
            targetUrl: json["target_url"],
            budget: json["budget"],
            category: json["category"],
            callToActionText: json["callToActionText"],
            duration: json["duration"],
            startDate: DateTime.tryParse(json["startDate"] ?? ""),
            endDate: DateTime.tryParse(json["endDate"] ?? ""),
            status: json["status"],
            dateCreated: DateTime.tryParse(json["dateCreated"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            isDeleted: json["isDeleted"],
            amountSpent: json["amountSpent"],
            totalReach: json["totalReach"],
            totalImpressions: json["totalImpressions"],
            totalVisits: json["totalVisits"],
            totalClicks: json["totalClicks"],
            totalViews: json["totalViews"],
            businessCategory: json["businessCategory"],
            adspaceId: json["adspaceID"],
            adSpaceSectionId: json["adSpaceSectionID"],
            declineReason: json["declineReason"],
            approvelUserId: json["approvelUserId"],
            approvalNote: json["approval_note"],
            reason: json["reason"],
            screens: json["screens"],
            isApproved: json["isApproved"],
            lastTotalViews: json["lastTotalViews"],
            lastTotalReachs: json["lastTotalReachs"],
            lastTotalImpressions: json["lastTotalImpressions"],
            lastTotalVisits: json["lastTotalVisits"],
            lastTotalClicks: json["lastTotalClicks"],
            metricDate: json["metricDate"],
            questions: json["questions"],
            regionIds: json["region_ids"] == null ? [] : List<dynamic>.from(json["region_ids"]!.map((x) => x)),
            advertiser: json["advertiser"] == null ? null : Advertiser.fromJson(json["advertiser"]),
        );
    }

}

class Advertiser {
    Advertiser({
        required this.id,
        required this.name,
        required this.businessName,
        required this.businessCategory,
        required this.businessAddress,
        required this.userId,
        required this.email,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? name;
    final String? businessName;
    final dynamic businessCategory;
    final dynamic businessAddress;
    final int? userId;
    final String? email;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Advertiser.fromJson(Map<String, dynamic> json){ 
        return Advertiser(
            id: json["id"],
            name: json["name"],
            businessName: json["business_name"],
            businessCategory: json["business_category"],
            businessAddress: json["business_address"],
            userId: json["userId"],
            email: json["email"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

}
