class Url {

  /* Base Url */
  static final String baseUrl = 'http://misteams.com/';
  
  static final String projectName = '';
  static final String baseProjectUrl = baseUrl + projectName;
  static final String postPath = 'uploads/assets/media/';
  static  final String bannerPath = 'uploads/assets/banners/';

  /* Route */
  static const String route404NotFound = '/404_not_found';
  static const String routeProduct = '/product';
  static const String routeService = '/service';
  static const String routeOurPartner = '/our_partner';
  static const String routeTemplate = '/template';
  static const String routeVideoCategory = '/video_category';
  static const String routeContact = '/contact';

  /* Generate Route  */
  static const String routeProductList = 'product_list';
  static const String routeServiceList = 'service_list';
  static const String routeOurPartnerList = 'our_partner_list';
  static const String routeTemplateList = 'template_list';
  static const String routeVideo = 'video';

  
  /* No Image */
   static final String noImage = 'assets/no_image.jpeg';

  /* API Key */
  static final String apiKeyIos = 'AIzaSyALkC9gj4v6GN0UOmJdEw9MtpYjAC6U6O0';
  static final String apiKeyAndroid = 'AIzaSyALkC9gj4v6GN0UOmJdEw9MtpYjAC6U6O0';
  static final String apiKeyStaticMap = '';

  static String checkNullString(str) {
    return str == null ? '' : str;
  }

}
