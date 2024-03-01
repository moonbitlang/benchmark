fn qsort(lo : Int, hi : Int, a : Array[Int]) {
  if lo < hi {
    let mut i = lo
    let mut j = hi
    let pivot = a[hi]
    while i < j {
      while i < hi && a[i] <= pivot {
        i = i + 1
      }
      while j > lo && a[j] >= pivot {
        j = j - 1
      }
      if i < j {
        let temp = a[j]
        a[j] = a[i]
        a[i] = temp
      }
    }
    let temp = a[i]
    a[i] = a[hi]
    a[hi] = temp
    qsort(lo, i - 1, a)
    qsort(i + 1, hi, a)
  }
}

fn cmp(a : Int, b : Int) -> Int {
  a - b
}

fn qsort2(lo : Int, hi : Int, a : Array[Int]) {
  if lo < hi {
    let mut i = lo
    let mut j = hi
    let pivot = a[hi]
    while i < j {
      while i < hi && cmp(a[i], pivot) <= 0 {
        i = i + 1
      }
      while j > lo && cmp(a[j], pivot) >= 0 {
        j = j - 1
      }
      if i < j {
        let temp = a[j]
        a[j] = a[i]
        a[i] = temp
      }
    }
    let temp = a[i]
    a[i] = a[hi]
    a[hi] = temp
    qsort2(lo, i - 1, a)
    qsort2(i + 1, hi, a)
  }
}

fn test_sort(sort : (Int, Int, Array[Int]) -> Unit, size : Int) -> Bool {
  let mut seed = 0
  fn random() {
    seed = seed * 25173 + 17431
    seed.land(0xfff)
  }

  let a = Array::make(size, 0)
  let check = Array::make(4096, 0)
  for i = 0; i < size; i = i + 1 {
    let x = random()
    check[x] = check[x] + 1
    a[i] = x
  }
  sort(0, size - 1, a)
  for i = 0; i < size; i = i + 1 {
    check[a[i]] = check[a[i]] - 1
  }
  for i = 1; i < size; i = i + 1 {
    if a[i - 1] > a[i] {
      return false
    }
  }
  for i = 0; i < 4096; i = i + 1 {
    if check[i] != 0 {
      return false
    }
  }
  true
}

fn init {
  @lib.assert(test_sort(qsort, 500000))
  @lib.assert(test_sort(qsort2, 500000))
}
