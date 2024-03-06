use rand::seq::SliceRandom;
use ndarray::{Array2};

type Metrix = Array2<u8>;

#[derive(Clone, Debug)]
enum Direction {
    Right,
    Down,
}
type Path = Vec<Direction>;

use crate::Direction::*;


fn create_metrix(x: usize, y: usize) -> Metrix {
    let mut r = Array2::<u8>::zeros((y, x));
    for iy in 0..y {
        for ix in 0..x {
            r[[iy.into(), ix.into()]] = rand::random::<u8>() % 10;
        }
    }
    return r;
}

fn check_value(table: &Metrix, path: &Path, detail: Option<bool>) -> i32 {
    let mut x = 0;
    let mut y = 0;
    let mut v:i32 = 0;
    let detail = detail.unwrap_or(false);

    v += table[[y,x]] as i32;

    for dir in path {
        match dir {
            Right => {
                x+=1;
                v += table[[y,x]] as i32;
            },
            Down => {
                y+=1;
                v -= table[[y,x]] as i32;
            },
        };
        if detail {
            println!("Move {:?} to ({}, {}), value: {}", dir, x, y, v);
        }
    }

    if (x+1, y+1) != table.dim() {
        panic!("path not goes to the end");
    }

    return v;
}

fn guess_path(table: &Metrix) -> Path {
    let mut path = make_path(&table);
    let mut rng = rand::thread_rng();

    for _ in 0..100000 {
        path.shuffle(&mut rng);
        if check_value(&table, &path, None) == 0 { return path; }
    };
    panic!("cannot find result");
}

enum IterResult {
    Done(Path),
    Failed(i32),
}

fn find_path(table: &Metrix) -> Path {
    let r = iter_path(table, 0, 0, Path::new(), table[[0, 0]].into(), 0);
    match r {
        IterResult::Done(path) => return path,
        IterResult::Failed(_) => panic!("Cannot find path"),
    }
}

fn iter_path(table: &Metrix, cx: usize, cy: usize, cpath: Path, cv: i32, target: i32) -> IterResult {
    if cx < table.dim().0 - 1 {
        let mut path = cpath.clone();
        path.push(Right);
        let r = iter_path(table, cx+1, cy, path, cv + table[[cy, cx+1]] as i32, target);
        if let IterResult::Done(_) = r { return r };
    }

    if cy < table.dim().1 - 1 {
        let mut path = cpath.clone();
        path.push(Down);
        let r = iter_path(table, cx, cy+1, path, cv - table[[cy+1, cx]] as i32, target);
        if let IterResult::Done(_) = r { return r };
    }

    if (cx+1, cy+1) != table.dim() {
        return IterResult::Failed(cv);
    } else if cv != target {
        return IterResult::Failed(cv);
    } else {
        return IterResult::Done(cpath);
    }
}


fn make_path(table: &Metrix) -> Path {
    let mut path = Path::new();
    for _ in  0..(table.dim().0 -1) { path.push(Right); }
    for _ in  0..(table.dim().1 -1) { path.push(Down); }
    return path;
}

fn main() {
    let lx = 4;
    let ly = 4;
    let table = create_metrix(lx, ly);
    println!("{}", table);

    // let path = guess_path(&table);
    // println!("path: {:?}", path);
    // check_value(&table, &path, Some(true));

    let path = find_path(&table);
    println!("path: {:?}", path);
    check_value(&table, &path, Some(true));
}
