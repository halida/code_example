extern crate rusqlite;
extern crate time;



// fn create_version

// fn create_db() {
//     let conn = SqliteConnection::open_in_memory().unwrap();
//     if ! create_version(conn, 1) return;

//     let first_names = ["James", "Bob", "Dexter", "Mary", "Bill", "Steven", "Ann"];
//     let second_names = ["Stone", "Doe", "Page", "Dinne"];

//     conn.execute("INSERT INTO person (name, time_created, data)
//                   VALUES ($1, $2, $3)",
//                  &[, ]).unwrap();    
// }

fn main() {
    let x = rand::random::<u8>();
    println!("{}", x);
    println!("Hello, world!");
}
