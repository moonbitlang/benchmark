fn tak(x : Int, y : Int, z : Int) -> Int {
  if x > y {
    tak(tak(x - 1, y, z), tak(y - 1, z, x), tak(z - 1, x, y))
  } else {
    z
  }
}

fn repeat(n : Int, acc : Int) -> Int {
  if n <= 0 {
    acc
  } else {
    repeat(n - 1, acc + tak(18, 12, 6))
  }
}

fn init {
  @lib.assert(repeat(2000, 0) == 14000)
}
