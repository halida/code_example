def run
  pwd
  # ~/data/workspace/test
  ls
  # a.txt b.txt
  ls :l
  # -rw-r--r--   1 halida  staff     91 Mar 11  2015 a.txt
  # -rwxr-xr-x   1 halida  staff   2664 Jul 27 20:04 b.txt
  mkdir :p "f.txt"
  cat "f.txt" "haha\nyes"
  chmod :u :+x "f.txt"
end
