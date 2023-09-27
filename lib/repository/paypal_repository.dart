
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';

class PaypalRepository {

  String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
//  String domain = "https://api.paypal.com"; // for production mode

  // change clientId and secret with your own, provided by paypal
  String clientId = 'AQrUNiqeaUR5hFL1CRzuAwZQCPQ2KD35hVAM0s_jIhw6mgydgbxvPFVfd3GQ7r3Z-wEyX8FPN3bxJyxL';
  String secret = 'EHMKQodo5H0TYyXGBbaj7PtpkTXjUlZMLj1YEV0j6oKv-9rYM4wG1D3Zdwc6Kyk9FFjtvbHo7dHWTE2F';

  // for getting the access token from Paypal
  Future<String> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post(Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials'));
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return "null";
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>?> createPaypalPayment(
      transactions, accessToken) async {
    try {
      var response = await http.post(Uri.parse("$domain/v1/payments/payment"),
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);

      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return null;
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<String> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        return body["id"];
      }
      return "null";
    } catch (e) {
      rethrow;
    }
  }


  Map<String, dynamic> getParams({return_url, cancel_url,projectName,price,quantity}) {

    bool isEnableShipping = false;
    bool isEnableAddress = false;
    Map<dynamic,dynamic> defaultCurrency = {"symbol": "ILS ", "decimalDigits": 2, "symbolBeforeTheNumber": true, "currency": "ILS"};
    List items = [
      {
        "name": projectName.toString(),
        "quantity": '1',
        "price": price.toString(),
        "currency": defaultCurrency["currency"]
      }
    ];


    // checkout invoice details
    String totalAmount = '$price';
    String subTotalAmount = '$price';
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = 'test';
    String userLastName = 'test';
    String addressCity = 'test';
    String addressStreet = 'test';
    String addressZipCode = '00972';
    String addressCountry = 'test';
    String addressState = 'test';
    String addressPhoneNumber = '+972123456789';

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount":
              ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {
        "return_url": return_url,
        "cancel_url": cancel_url
      }
    };
    return temp;
  }
}
