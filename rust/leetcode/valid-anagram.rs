struct Solution;

use std::collections::HashMap;
use std::collections::hash_map::Entry::*;

impl Solution {
    pub fn is_anagram(s: String, t: String) -> bool {
        let mut hash: HashMap<char, u32> = HashMap::new();

        for cs in s.chars() {
            *hash.entry(cs).or_insert(0) += 1;
        }
        for ct in t.chars() {
            match hash.entry(ct) {
                Occupied(e) => {
                    let v = e.into_mut();
                    if *v <= 0 { return false; }
                    *v -= 1;
                }
                Vacant(_) => return false,
            }
        }
        return hash.values().sum::<u32>() == 0;
    }
}


fn main(){
    println!("{}", Solution::is_anagram("abc".into(), "abc".into()));
    println!("{}", Solution::is_anagram("abc".into(), "cba".into()));
    println!("{}", Solution::is_anagram("abc".into(), "ccc".into()));
    println!("{}", Solution::is_anagram("abc".into(), "".into()));
    println!("{}", Solution::is_anagram("abc".into(), "".into()));
}
