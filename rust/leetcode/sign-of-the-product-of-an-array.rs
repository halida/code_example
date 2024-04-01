struct Solution;


impl Solution {
    pub fn array_sign(nums: Vec<i32>) -> i32 {
        let mut sign: bool = true;

        for n in nums {
            if n == 0 { return 0; }
            else if n < 0 { sign = !sign; }
        }

        return if sign { 1 } else { -1 };
    }
}


fn main(){
    println!("{:?}", Solution::array_sign(vec![1, 3, 0]));
    println!("{:?}", Solution::array_sign(vec![-1, 3, 8]));
    println!("{:?}", Solution::array_sign(vec![1, -3, 8]));
    println!("{:?}", Solution::array_sign(vec![1, -3, -8]));
}
