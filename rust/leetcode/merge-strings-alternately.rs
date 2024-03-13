pub fn merge_alternately(word1: String, word2: String) -> String {
    let w1l = word1.len();
    let w2l = word2.len();
    let w1 = word1.into_bytes();
    let w2 = word2.into_bytes();

    let min_len = if w1l > w2l {w2l} else {w1l};

    let mut r:Vec<u8> = vec![];

    for i in 0..min_len {
        r.push(w1[i]);
        r.push(w2[i]);
    }

    let longer = if w1l > w2l {w1} else {w2};
    for i in min_len..longer.len() {
        r.push(longer[i]);
    }
    return String::from_utf8_lossy(&r).to_string();
}

pub fn main() {
    println!("{}", merge_alternately("".into(), "abc".into()));
    println!("{}", merge_alternately("123".into(), "".into()));
    println!("{}", merge_alternately("123".into(), "abc".into()));
    println!("{}", merge_alternately("1234".into(), "abc".into()));
    println!("{}", merge_alternately("123".into(), "abcd".into()));
}
