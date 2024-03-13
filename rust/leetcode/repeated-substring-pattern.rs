struct Solution;

//  a b c a b c a b c
//  0  -  se
//        i - i+se

impl Solution {
    pub fn repeated_substring_pattern(s: String) -> bool {
        let s_len = s.len();

        for se in 1 ..= s_len/2 {
            if s_len % se != 0 { continue; }

            let sub = &s[0 .. se];

            let mut i = se;
            loop {
                if i == s_len {
                    // matched
                    return true;
                } else if i+se > s_len {
                    // remains smaller than sub
                    break;
                } else if &s[i .. i+se] != sub {
                    // not match
                    break;
                } else {
                    // advance
                    i += se;
                }
            }
        }
        return false;
    }
}

fn main(){
    println!("{}", Solution::repeated_substring_pattern("abcabc".into()));
    // println!("{}", Solution::repeated_substring_pattern("abcab".into()));
    println!("{}", Solution::repeated_substring_pattern("aabaaba".into()));
}
