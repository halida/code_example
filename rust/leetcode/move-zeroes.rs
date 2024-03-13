struct Solution;
impl Solution {
    pub fn move_zeroes(nums: &mut Vec<i32>) {
        // api
        // let len = nums.len();
        // nums.retain(|x| *x != 0);
        // nums.resize(len, 0);

        // move
        // let mut i = 0;
        // let mut j;
        // let len = nums.len();

        // 'outer: loop {
        //     while nums[i] != 0 {
        //         i+=1;
        //         if i >= len-1 { break 'outer; }
        //     }
        //     j = i+1;
        //     if j>=len { break; }

        //     while nums[j] == 0 {
        //         j+=1;
        //         if j >= len { break 'outer; }
        //     }
        //     nums.swap(i, j);
        // }

        // move 2
        let mut i = 0;
        let len = nums.len();

        for j in 0..len {
            if nums[j] != 0 {
                if i!=j { nums[i] = nums[j]; }
                i += 1;
            }
        }
        for k in i..len {
            nums[k] = 0;
        }
    }
}


fn main(){
    let mut v = vec![0];
    Solution::move_zeroes(&mut v);
    println!("{:?}", v);
    let mut v = vec![1];
    Solution::move_zeroes(&mut v);
    println!("{:?}", v);
    let mut v = vec![1,0,0,2,0,3];
    Solution::move_zeroes(&mut v);
    println!("{:?}", v);
    let mut v = vec![1,0,0,2,3];
    Solution::move_zeroes(&mut v);
    println!("{:?}", v);
    let mut v = vec![1,0,2,0,3];
    Solution::move_zeroes(&mut v);
    println!("{:?}", v);
    let mut v = vec![1,0,0,2,0,3,0];
    Solution::move_zeroes(&mut v);
    println!("{:?}", v);
}
