/*
input:
1-20
45-120
320-1100

7-48
90-360

output:
7-20
45-48
90-120
320-360

 */

use std::io;
use std::cmp::Ordering;
use std::fmt;

#[derive(PartialEq, Eq, PartialOrd, Ord)]
struct Duration {
    start: u32,
    end: u32,
}

impl fmt::Display for Duration {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}-{}", &self.start, &self.end)
    }
}

type Durations = Vec<Duration>;
type Dots = Vec<u32>;
type Intervals = Vec<bool>;


fn scan() -> Durations {
    let mut result = Durations::new();
    
    loop {
        let mut input = String::new();
        io::stdin().read_line(&mut input).ok();
        if input == "\n" {break};

        let vs: Dots = input.trim().split("-")
            .map(|x| x.parse::<u32>().unwrap()).collect();
        let duration = Duration{start: vs[0], end: vs[1]};

        result.push(duration);
    }

    result.sort();
    result
}

fn dots_for(ds: &Durations) -> Dots {
    let mut result = Dots::new();
    for d in ds{
        result.push(d.start);
        result.push(d.end);
    }
    result
}

fn intervals(dots: &Dots, ds: &Durations) -> Intervals {
    let mut intervals = vec![false; dots.len()-1];

    for d in ds {
        let is = dots.binary_search(&d.start).unwrap();
        let ie = dots.binary_search(&d.end).unwrap();
        for i in (is .. ie) {
            intervals[i] = true;
        }
    }
    intervals
}

fn durations(dots: &Dots, intervals: &Intervals) -> Durations {
    let mut isin = false;
    let mut i = 0;
    let mut duration = Duration{start: 0, end: 0};
    let mut result = Durations::new();

    loop {
        let mut v:bool;
        match (dots.len() - 1).cmp(&i) {
            Ordering::Less => break,
            Ordering::Equal => v = false, // out at the end
            Ordering::Greater => v = intervals[i],
        }
        
        if v && !isin {
            // in
            duration.start = dots[i];
            isin = true;
        } else if !v && isin {
            // out
            duration.end = dots[i];
            result.push(duration);
            duration = Duration{start: 0, end: 0};
            isin = false;
        }

        i += 1;
    }
    println!("result {}, i: {}", result.len(), &i);
    result
}

fn show<T: std::fmt::Display>(vs: &Vec<T>){
    for v in vs {print!("{}, ", &v)};
    println!("");
}

fn main() {
    let durations_a = scan();
    let durations_b = scan();
    print!("duration a:");
    show(&durations_a);
    print!("duration b:");
    show(&durations_b);

    let dots_a = dots_for(&durations_a);
    let dots_b = dots_for(&durations_b);
    let mut dots = Vec::new();
    dots.extend(&dots_a);
    dots.extend(&dots_b);
    dots.sort();
    dots.dedup();
    print!("dots: ");
    show(&dots);

    let intervals_a = intervals(&dots, &durations_a);
    print!("intervals a: ");
    show(&intervals_a);
    let intervals_b = intervals(&dots, &durations_b);
    print!("intervals b: ");
    show(&intervals_b);

    let intervals = intervals_a.iter().zip(&intervals_b)
        .map(|x| x.0 & x.1).collect();
    print!("intervals j: ");
    show(&intervals);
    
    let durations = durations(&dots, &intervals);

    print!("durations: ");
    show(&durations);
}
