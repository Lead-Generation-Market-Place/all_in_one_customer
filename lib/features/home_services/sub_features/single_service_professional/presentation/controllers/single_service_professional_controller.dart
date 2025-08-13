import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class SingleServiceProfessionalController extends ChangeNotifier {
  Map _proDetails = {};
  Map get proDetails => _proDetails;
  bool _proLoading = false;
  bool get proLoading => _proLoading;
  Map _proCompleteDetails = {};
  Map get proCompleteDetails => _proCompleteDetails;

  SingleServiceProfessionalController(this._proDetails) {
    getProCompleteDetails();
  }
  Future getProCompleteDetails() async {
    try {
      _proLoading = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 8));
      _proCompleteDetails = {
        'name': 'alex',
        'ratings': 4.9,
        'isActive': false,
        'timesHired': 84,
        'estimatedPrice': '97\$ - \$113/hour',
        'response': '~56',
        'location': 'Serves Clearwater Beach, FL',
        'starsCount': 33,
        'aboutPro':
            'We are a eveteran-owned business specializing in local and long-distance moving service. in addition to expert moving. we offer a full range of services including junk removal, yard waste removal, and general waster disposal. our team is commited to delivering professional, efficient, and excellent service with a focus on cus tomer satisfaction.  whether youre reloc',
        'lastReviewText':
            "lorem ipsum psdfsdg;asjdgksajd;gjdsa;kgjkdsjgasdkjh;kasdjh;ksdjgjsdfsdkfj;skjdfksdjf",
        'imageUrl': 'https://iili.io/FsejxXp.jpg',
        'businessHours': 'This pro has not been set business hours',
        'timeInBusiness': '8 Years in Business',
        'backgroundStatus': 'Background checked',
        'employeesCount': '10 employees',
        'paymentMethods':
            'This pro acepts payments via Apple Pay, Cash, Credit card and Google Pay',
        'topProStatus': '2024, 2018, 2017',
        'license': '',
        'backgroundCheckedOption':
            'Paased by Quaryshawn Crocket on Jan 24, 2024',
        'serviceOffered': '',
        'moveType': 'Full service labor+truck,labor only',
        'extraService': ['Furniture', 'Packing', 'Storage'],
        'reviewsCompleteDetails': [
          {
            'name': 'sdfsd k.',
            'reviewCount': '4',
            'imageUrl': 'https://iili.io/FseVaVt.jpg',
            'lastOnline': '3 weeks ago',
            'reviewText':
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec varius sit amet neque quis varius. Integer id pretium cursus. Nam volutpat sapien eu justo auctor aliquam. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec varius sit amet neque quis varius. Integer id pretium cursus. Nam volutpat sapien eu justo auctor aliquam.',
          },
          {
            'name': 'ffdddd k.',
            'reviewCount': '4',
            'imageUrl': 'https://iili.io/FseVaVt.jpg',
            'lastOnline': '3 weeks ago',
            'reviewText':
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec varius sit amet neque quis varius. Integer id pretium cursus. Nam volutpat sapien eu justo auctor aliquam.',
          },
          {
            'name': 'gbbbb k.',
            'reviewCount': '4',
            'imageUrl': 'https://iili.io/FseVaVt.jpg',
            'lastOnline': '3 weeks ago',
            'reviewText':
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec varius sit amet neque quis varius. Integer id pretium cursus. Nam volutpat sapien eu justo auctor aliquam.',
          },
          {
            'name': 'sdfsdf k.',
            'reviewCount': '4',
            'imageUrl': 'https://iili.io/FseVaVt.jpg',
            'lastOnline': '3 weeks ago',
            'reviewText':
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec varius sit amet neque quis varius. Integer id pretium cursus. Nam volutpat sapien eu justo auctor aliquam.',
          },
        ],
        'photos': [
          'photo 1',
          'photo 2',

          'photo 3',
          'photo 4',

          'photo 5',
          'photo 6',

          'photo 7',
          'photo 8',
        ],
      };
      Logger().i(_proCompleteDetails);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _proLoading = false;
      notifyListeners();
    }
  }

  Future<void> retry() async {
    try {
      _proLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2));

      _proCompleteDetails = {
        'name': 'alex',
        'ratings': 4.9,
        'isActive': false,
        'timesHired': 84,
        'estimatedPrice': '97\$ - \$113/hour',
        'response': '~56',
        'starsCount': 33,
        'lastReviewText':
            "lorem ipsum psdfsdg;asjdgksajd;gjdsa;kgjkdsjgasdkjh;kasdjh;ksdjgjsdfsdkfj;skjdfksdjf",
        'imageUrl': 'https://iili.io/FsejxXp.jpg',
        'businessHours': 'This pro has not been set business hours',
        'timeInBusiness': '8 Years in Business',
        'backgroundStatus': 'Background checked',
        'employeesCount': '10 employees',
        'paymentMethods':
            'This pro acepts payments via Apple Pay, Cash, Credit card and Google Pay',
        'topProStatus': '2024, 2018, 2017',
        'license': '',
        'backgroundCheckedOption':
            'Paased by Quaryshawn Crocket on Jan 24, 2024',
        'serviceOffered': '',
        'moveType': 'Full service labor+truck,labor only',
        'extraService': ['Furniture', 'Packing', 'Storage'],
        'reviewsCompleteDetails': [
          {
            'name': 'kak k.',
            'reviewCount': '4',
            'imageUrl': 'https://iili.io/FseVaVt.jpg',
            'lastOnline': '3 weeks ago',
            'reviewText':
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec varius sit amet neque quis varius. Integer gravida augue id pretium cursus. Nam volutpat sapien eu justo auctor aliquam. Donec at porta libero. Proin tincidunt accumsan quam vulputate volutpat. Maecenas finibus quam ac neque cursus rhoncus. Phasellus sagittis, risus sit amet tristique euismod, lorem ipsum volutpat dolor, id condimentum turpis sapien vel tellus. Mauris quis semper metus. Praesent id ante ac est tristique bibendum at sed tellus. Sed sit amet euismod turpis. Aenean a enim a lacus rhoncus lacinia vitae vitae mauris.',
          },
        ],
      };
    } catch (e) {
      debugPrint('Error on retry : $e');
    } finally {
      _proLoading = false;
      notifyListeners();
    }
  }
}
