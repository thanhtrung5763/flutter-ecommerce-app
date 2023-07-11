class AppQuery {
  const AppQuery._();

  static const _productWithReviews = 
    '''
      title
      Reviews {
        items {
          id
          rating
        }
      }
      brand {
        id
        title
      }
      description
      discountOffer
      discountPrice
      finercategory {
        broadcategoryID
        id
        title
      }
      id
      images
      originalPrice
      sizeOption
    ''';
  // static String getSaleProducts = 
  //   '''
  //     query getSaleProducts {
  //       listProducts(filter: {discountOffer: {ne: ""}}, limit: 30) {
  //         items {
  //           $_productWithReviews
  //         }
  //         nextToken
  //       }
  //     }
  //   ''';
  // static String getNewProducts = 
  //   '''
  //     query getNewProducts {
  //       listProducts(filter: {discountOffer: {eq: ""}}, limit: 10) {
  //         items {
  //           $_productWithReviews
  //         }
  //         nextToken
  //       }
  //     }
  //   ''';    
  static String getProductByID(String id) {
    return '''
      query getProductByID {
        getProduct(id: "$id") {
          $_productWithReviews
        }
      }
    ''';   
  }

  static String getSaleProducts(String? nextToken) {
    if (nextToken == null) {
      return '''
        query getSaleProducts {
          listProducts(filter: {discountOffer: {ne: ""}}, limit: 30) {
            items {
              $_productWithReviews
            }
            nextToken
          }
        }
      '''; 
    }
    return '''
      query getSaleProducts {
        listProducts(filter: {discountOffer: {ne: ""}}, limit: 30, nextToken: "$nextToken") {
          items {
            $_productWithReviews
          }
          nextToken
        }
      }
    '''; 
  }
  static String getNewProducts(String? nextToken) {
    if (nextToken == null) {
      return '''
        query getNewProducts {
          listProducts(filter: {discountOffer: {eq: ""}}, limit: 10) {
            items {
              $_productWithReviews
            }
            nextToken
          }
        }
      '''; 
    }
    return '''
      query getNewProducts {
        listProducts(filter: {discountOffer: {eq: ""}}, limit: 10, nextToken: "$nextToken") {
          items {
            $_productWithReviews
          }
          nextToken
        }
      }
    '''; 
  }
}