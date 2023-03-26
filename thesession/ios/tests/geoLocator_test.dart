// Import the test package, Counter class, and the necessary dependencies
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoder/geocoder.dart';
import 'package:thesession/utils/dataManager.dart';
import 'package:thesession/utils/geoLocator.dart';

void main() {
  test('Correct address should be returned from coordinates', () async {
    // Arrange
    Coordinates coordinates =
        Coordinates(53.337813051937914, -6.411841946822383);

    // Act
    String address = await GeoLocator.getAddress(coordinates);

    // Assert
    expect(address,
        'Some expected address'); // Replace 'Some expected address' with the actual expected address
  });
}
