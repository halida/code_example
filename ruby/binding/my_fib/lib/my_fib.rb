class MyFib

  def self.ruby_fib(number)
    if number <= 1
      1
    else
      ruby_fib(number-1) + ruby_fib(number-2)
    end
  end

end

# my_fib/my_fib will be the shared object built when the gem is
# installed then copied into lib/my_fib/.

require 'my_fib/my_fib'
