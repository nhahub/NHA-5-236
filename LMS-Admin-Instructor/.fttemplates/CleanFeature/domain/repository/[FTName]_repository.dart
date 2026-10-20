import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/features/<FTName | snakecase>/data/model/<FTName | snakecase>_model.dart';

abstract class <FTName | pascalcase>Repository {
  Future<Either<String, List<<FTName | pascalcase>Model>>> get<FTName | pascalcase>();
}