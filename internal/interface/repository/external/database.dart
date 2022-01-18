import '../../../entity/user.dart';

abstract class Database {
  Future<Map<String, dynamic>> single(ctx, sql);
  Future<Map<String, dynamic>> insert(ctx, sql);
  Future<Map<String, dynamic>> update(ctx, sql, getSQL);
}