import etc.c.sqlite3;
import std.stdio;

extern (C) int cb(void *NotUsed, int argc, char **argv, char **azColName) {
    foreach(i; 0 .. argc){
        writefln("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
    }
    writeln();
    return 0;
}


void main(string[] args) {
    sqlite3 *db;
    char *zErrMsg;
    int rc;
  
    if( args.length!=3 ){
        writefln("Usage: %s DATABASE SQL-STATEMENT\n", args[0]);
        return;
    }

    rc = sqlite3_open(cast(char *)args[1], &db);
    if( rc ){
        writefln("Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return;
    }

    rc = sqlite3_exec(db, cast(char *)args[2], &cb, null, &zErrMsg);
    if( rc!=SQLITE_OK ){
        writefln("SQL error: %s\n", zErrMsg);
        sqlite3_free(zErrMsg);
    }

    sqlite3_close(db);
    return;
}
