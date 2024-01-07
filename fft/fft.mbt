fn cos(n : Double) -> Double = "math" "cos"

fn sin(n : Double) -> Double = "math" "sin"

fn abs(n : Double) -> Double {
  if n < 0.0 {
    -n
  } else {
    n
  }
}

let pi = 3.14159265358979323846

let tpi : Double = 2.0 * pi

fn fft(px : Array[Double], py : Array[Double], np : Int) {
  var i = 2
  var m = 1
  while i < np {
    i = i + i
    m = m + 1
  }
  let n = i
  if n != np {
    var i = np + 1
    while i <= n, i = i + 1 {
      px[i] = 0.0
      py[i] = 0.0
    }
  }
  var n2 = n + n
  var i = 1
  while i <= m - 1, i = i + 1 {
    n2 = n2 / 2
    let n4 = n2 / 4
    let e = tpi / n2.to_double()
    var j = 1
    while j <= n4, j = j + 1 {
      let a = e * (j - 1).to_double()
      let a3 = 3.0 * a
      let cc1 = cos(a)
      let ss1 = sin(a)
      let cc3 = cos(a3)
      let ss3 = sin(a3)
      var is = j
      var id = 2 * n2
      while is < n {
        var i0r = is
        while i0r < n {
          let i0 = i0r
          let i1 = i0 + n4
          let i2 = i1 + n4
          let i3 = i2 + n4
          let r1 = px[i0] - px[i2]
          px[i0] = px[i0] + px[i2]
          let r2 = px[i1] - px[i3]
          px[i1] = px[i1] + px[i3]
          let s1 = py[i0] - py[i2]
          py[i0] = py[i0] + py[i2]
          let s2 = py[i1] - py[i3]
          py[i1] = py[i1] + py[i3]
          let s3 = r1 - s2
          let r1 = r1 + s2
          let s2 = r2 - s1
          let r2 = r2 + s1
          px[i2] = r1 * cc1 - s2 * ss1
          py[i2] = -s2 * cc1 - r1 * ss1
          px[i3] = s3 * cc3 + r2 * ss3
          py[i3] = r2 * cc3 - s3 * ss3
          i0r = i0r + id
        }
        is = 2 * id - n2 + j
        id = 4 * id
      }
    }
  }
  var is = 1
  var id = 4
  while is < n {
    var i0r = is
    while i0r <= n {
      let i0 = i0r
      let i1 = i0 + 1
      let r1 = px[i0]
      px[i0] = r1 + px[i1]
      px[i1] = r1 - px[i1]
      let r1 = py[i0]
      py[i0] = r1 + py[i1]
      py[i1] = r1 - py[i1]
      i0r = i0r + id
    }
    is = 2 * id - 1
    id = 4 * id
  }
  var j = 1
  var i = 1
  while i <= n - 1, i = i + 1 {
    if i < j {
      let xt = px[j]
      px[j] = px[i]
      px[i] = xt
      let xt = py[j]
      py[j] = py[i]
      py[i] = xt
    }
    var k = n / 2
    while k < j {
      j = j - k
      k = k / 2
    }
    j = j + k
  }
}

fn test(np : Int) {
  let enp = np.to_double()
  let npm = np / 2 - 1
  let pxr = Array::make(np + 2, 0.0)
  let pxi = Array::make(np + 2, 0.0)
  let t = pi / enp
  pxr[1] = (enp - 1.0) * 0.5
  pxi[1] = 0.0
  let n2 = np / 2
  pxr[n2 + 1] = -0.5
  pxi[n2 + 1] = 0.0
  var i = 1
  while i <= npm, i = i + 1 {
    let j = np - i
    pxr[i + 1] = -0.5
    pxr[j + 1] = -0.5
    let z = t * i.to_double()
    let y = -0.5 * (cos(z) / sin(z))
    pxi[i + 1] = y
    pxi[j + 1] = -y
  }
  fft(pxr, pxi, np)
  var zr = 0.0
  var zi = 0.0
  var kr = 0
  var ki = 0
  var i = 0
  while i < np, i = i + 1 {
    let a = abs(pxr[i + 1] - i.to_double())
    if zr < a {
      zr = a
      kr = i
    }
    let a = abs(pxi[i + 1])
    if zi < a {
      zi = a
      ki = i
    }
  }
  @lib.assert(abs(zr) <= 1.0e-9 && abs(zi) <= 1.0e-9)
}

fn init {
  var np = 16
  var i = 1
  while i <= 16, i = i + 1 {
    test(np)
    np = np * 2
  }
}
