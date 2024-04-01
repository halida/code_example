struct Solution;

use std::convert::TryInto;
use std::cmp;

impl Solution {
    pub fn trap1(height: Vec<i32>) -> i32 {
        let mut water:i32 = 0;
        let max_height = height.iter().max().unwrap_or(&0);

        for h in 1 ..= *max_height {
            let mut min:Option<usize> = None;
            let mut max = 0;
            let mut len = 0;

            // find max
            for i in (0 .. height.len()).rev() {
                if height[i] >= h { max = i; break; }
            }

            for i in 0 ..= max {
                if height[i] < h { continue; }

                len += 1;
                if min == None { min = Some(i); }
            }
            if max == min.unwrap() { continue; }
            // println!("{}: {}-{}", h, min, max);

            let v:i32 = (max - min.unwrap() + 1 - len).try_into().unwrap();
            if v > 0 { water += v; }
        }
        return water;
    }
}

impl Solution {
    pub fn trap2(height: Vec<i32>) -> i32 {
        let mut water:i32 = 0;
        let mut l = 0;
        let mut lh = height[l];
        let mut r = height.len() - 1;
        let mut rh = height[r];

        // current height
        let mut ch = 0;

        loop {
            // find l
            for i in l ..= r {
                lh = height[i];
                l = i;
                if lh > ch { break; }
            }

            // find r
            for j in (l ..= r).rev() {
                rh = height[j];
                r = j;
                if rh > ch { break; }
            }
            if l >= r {break;}

            // count
            let nh = cmp::min(lh, rh); // new height

            for k in l+1 ..= r-1 {
                let kh = height[k];
                if nh > kh {
                    let t = cmp::max(kh, ch);
                    water += nh - t;
                }
            }
            // println!("{}: {}-{} {}", ch, l, r, water);
            ch = nh;
        }

        return water;
    }
}

impl Solution {
    pub fn trap(height: Vec<i32>) -> i32 {
        let mut water:i32 = 0;
        let mut l = 0;
        let mut r = height.len() - 1;
        let mut lh = height[l];
        let mut rh = height[r];

        while l < r {
            // current water height
            let ch = cmp::min(lh, rh);

            // grow from short side
            if lh < rh {
                while ch >= lh && l < r {
                    water += ch - lh;
                    l += 1;
                    lh = height[l];
                }
            } else {
                while ch >= rh && l < r {
                    water += ch - rh;
                    r -= 1;
                    rh = height[r];
                }
            }
        }

        return water;
    }
}


fn main(){
    println!(": {}", Solution::trap(vec![1]));
    println!(": {}", Solution::trap(vec![0,1,0,2,1,0,1,3,2,1,2,1]));
    println!(": {}", Solution::trap(vec![4,2,0,3,2,5]));
    println!(": {}", Solution::trap(vec![4,2,3]));
}
