import '../../usecase/repository/user_repository.dart';
import './external/database.dart';
import '../../entity/export.dart';

class UserRepositoryImpl implements UserRepository {

  Database database;
  
  UserRepositoryImpl(this.database);

  Future<User> getUser(ctx, id) async {
    String sql = '''
SELECT * FROM users WHERE id=${id}
''';
    var data = await database.single(ctx, sql);

    User user = User(
      data['id'],
      data['name'],
      data['created_at'].toString(),
      data['updated_at'].toString(),
      data['deleted_at'].toString()
    );
    return user;
  }

  Future<User> insertUser(ctx, name) async {
    String sql = '''
INSERT INTO users (name) VALUES ("$name") returning *;
''';

    var data = await database.insert(ctx, sql);
    if (data["id"] == 0) {
      print("error at UserRepository.insertUser");
    }

    User user = User(
      data["id"],
      data["name"],
      data["created_at"].toString(),
      data["updated_at"].toString(),
      data["deleted_at"].toString()
    );
    return user;
  }

  Future<User> updateUser(ctx, user) async {
    String sql = '''
UPDATE users SET name="${user.name}" WHERE id=${user.id};
''';
    String returningSQL = '''
SELECT * FROM users WHERE id=${user.id};
''';

    var data = await database.update(ctx, sql, returningSQL);
    User resultUser = User(
      data["id"],
      data["name"],
      data["created_at"].toString(),
      data["updated_at"].toString(),
      data["deleted_at"].toString()
    );
    return resultUser;
  }

  Future<User> deleteUser(ctx, user) async {
    String sql = '''
UPDATE users SET deleted_at=NOW() WHERE id=${user.id};
''';
    String returningSQL = '''
SELECT * FROM users WHERE id=${user.id};
''';

    var data = await database.update(ctx, sql, returningSQL);
    User resultUser = User(
      data["id"],
      data["name"],
      data["created_at"].toString(),
      data["updated_at"].toString(),
      data["deleted_at"].toString()
    );
    return resultUser;
  }
}