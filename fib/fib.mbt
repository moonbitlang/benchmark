fn fib(n : Int) -> Int {
  if n < 2 {
    1
  } else {
    fib(n - 1) + fib(n - 2)
  }
}

fn init {
  @lib.assert(fib(40) == 165580141)
}
