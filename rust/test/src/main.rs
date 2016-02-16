fn xy() {
    let mut y = 5;
    let x = (y = 6);  // x has the value `()`, not `6`

    println!("x: {}", x);
    println!("y: {}", y);
}

fn main() {
    xy();
}
