def run
  /ab*/ == Regexp.new [:a, [:*, :b]]
  /(a|b|c)+where/ == Regexp.new [[:+ [:| :a :b :c]] "where"]
end
