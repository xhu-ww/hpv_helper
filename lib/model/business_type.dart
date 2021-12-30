enum BusinessTypeEnum {
  // 约苗
  yuemiao,
  // 知苗易约
  zhimiao
}

String getBusinessTypeDesc(BusinessTypeEnum type) {
  switch (type) {
    case BusinessTypeEnum.yuemiao:
      return '约苗';
    case BusinessTypeEnum.zhimiao:
      return '知苗易约';
  }
}

List<String> getAllBusinessTypeDesc() {
  return BusinessTypeEnum.values.map((e) => getBusinessTypeDesc(e)).toList();
}
