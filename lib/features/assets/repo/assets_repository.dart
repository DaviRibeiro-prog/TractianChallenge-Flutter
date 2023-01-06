import 'package:dio/dio.dart';
import 'package:tractian_challenge/models/assets/asset_model.dart';
import 'package:tractian_challenge/repos/api_url.dart';
import 'package:tractian_challenge/repos/i_assets_repository.dart';

class AssetsRepository extends IAssetsRepository {
  final Dio _dio = Dio();

  @override
  Future<List<Asset>> getAssets() async {
    var response = await _dio.get('${Api.base}assets');

    List<Asset> assets =
        response.data.map<Asset>((element) => Asset.fromJson(element)).toList();

    print(assets);

    return assets;
  }

  @override
  Future<Asset> getSingleAsset(int id) async {
    var response = await _dio.get('${Api.base}assets/$id');
    Asset asset = Asset.fromJson(response.data);

    print(asset);

    return asset;
  }
}
