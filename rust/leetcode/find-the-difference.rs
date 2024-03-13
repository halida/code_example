struct Solution;

use std::collections::HashMap;
use std::collections::hash_map::Entry::*;

impl Solution {
    pub fn find_the_difference(s: String, t: String) -> char {
        let mut hash: HashMap<char, u32> = HashMap::new();

        for cs in s.chars() {
            *hash.entry(cs).or_insert(0) += 1;
        }
        for ct in t.chars() {
            match hash.entry(ct) {
                Occupied(e) => {
                    let v = e.into_mut();
                    if *v <= 0 { return ct; }
                    *v -= 1;
                }
                Vacant(_) => return ct,
            }
        }
        return 'e';
    }
}


fn main(){
    println!("{}", Solution::find_the_difference("abc".into(), "abc1".into()));
    println!("{}", Solution::find_the_difference("abc".into(), "ab2c".into()));
    println!("{}", Solution::find_the_difference("abc".into(), "a3bc".into()));
    println!("{}", Solution::find_the_difference("abc".into(), "4abc".into()));

    println!("{}", Solution::find_the_difference("abcddd".into(), "abc1ddd".into()));
    println!("{}", Solution::find_the_difference("abcddd".into(), "abcdddd".into()));
}
