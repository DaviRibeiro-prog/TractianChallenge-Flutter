import 'package:tractian_challenge/repos/i_assets_repository.dart';

import '../../models/assets/asset_model.dart';

class AssetsController {
  final IAssetsRepository repo;

  AssetsController(this.repo);

  Future<List<Asset>> getAssets() async {
    var response = await repo.getAssets();
    return response;
  }

  Future<Asset> getSingleAsset(int id) async {
    var response = repo.getSingleAsset(id);
    return response;
  }
}
