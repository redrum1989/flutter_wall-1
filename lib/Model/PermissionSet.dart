class PermissionData{
  String permission;

  PermissionData({
    this.permission
  });

  Map<String, dynamic> returnPermissionData(){
    return {
      "permission" : this.permission
    };
  }
}