struct Solution;

impl Solution {
    pub fn str_str(haystack: String, needle: String) -> i32 {
        return match haystack.find(&needle) {
            None => -1,
            Some(e) => e as i32,
        };
    }
}


fn main(){
    println!("{}", Solution::str_str("abc".into(), "bc".into()));
    println!("{}", Solution::str_str("abc".into(), "bcd".into()));
    println!("{}", Solution::str_str("abc".into(), "ab".into()));
}


#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(Solution::str_str("abc", "bc"), 1);
    }
}
