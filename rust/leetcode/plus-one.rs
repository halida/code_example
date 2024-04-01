struct Solution;

impl Solution {
    pub fn plus_one(digits: Vec<i32>) -> Vec<i32> {
        let mut add: bool = true;
        let mut r = digits.clone();

        for i in (0..digits.len()).rev() {
            // println!("{}", i);
            if add {
                r[i] += 1;
                add = false;
            }
            if r[i] >= 10 {
                r[i] -= 10;
                add = true;
            }
        }

        if add { r.insert(0, 1); }

        return r;
    }
}


fn main(){
    println!("{:?}", Solution::plus_one(vec![0]));
    println!("{:?}", Solution::plus_one(vec![1,4,9]));
    println!("{:?}", Solution::plus_one(vec![9,9,9]));
}
