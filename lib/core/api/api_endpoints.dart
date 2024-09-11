class ApiEndpoints {
  static const String getUserDetails = '/auth/getLoginUserDetail';
  // static const String getDigitalPrd = '/product/listDigitalProductsWithFilters';
  static const String getDigitalPrd = '/product/dealer';
  static const String generateReference = '/wallet/generatePaymentReference';
  static const String createDigitalOrder = '/orders/createDigitalOrder';
  static const String generateInvoice = '/orders/getInvoiceByOrderId';
  static const String fileUpload = '/content/uploadimage';
  static const String receiptUrl = '/orders/';
  static const String invoiceUrl = '/orders/';
  static const String getDigitalOrders = '/orders/getDigitalOrdersByUserId/';
  static const String getBillingInvoice = '/orders/findAllInvoices';
}
