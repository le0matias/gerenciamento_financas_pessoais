import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {

  static Future<sql.Database> database() async{
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath,
        'gerenciador_gastos_app.db'
      ),onCreate: (db, version){
        _createDb(db);
    },
    version: 1
    );
  }

  static void _createDb(sql.Database db) {
    db.execute('''
      CREATE TABLE conta(id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome VARCHAR(50), valor REAL
    )''');

    db.execute('''
      CREATE TABLE operacao(id INTEGER PRIMARY KEY AUTOINCREMENT,
      tipo VARCHAR(20), nome VARCHAR(50), resumo VARCHAR(100),
      data DATETIME, custo REAL, conta INTEGER FOREIGN KEY(conta)
      REFERENCES conta (id)
    )''');
  }

  static Future<void> inserirDados(String table, Map<String, dynamic> dados) async {
    final db = await DbUtil.database();
    print(await db.insert(
        table,
        dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace
    )
    );
  }

  static Future<List<Map<String, dynamic>>> pegaDados(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }

}