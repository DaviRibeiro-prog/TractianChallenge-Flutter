import 'package:tractian_challenge/models/assets/asset_model.dart';

abstract class IAssetsRepository {
  Future<List<Asset>> getAssets();
  Future<Asset> getSingleAsset(int id);
}
