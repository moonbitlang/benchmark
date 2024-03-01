enum Peg {
  Out
  Emp
  Peg
} derive(Eq)

let board : Array[Array[Peg]] = [
  [Out, Out, Out, Out, Out, Out, Out, Out, Out],
  [Out, Out, Out, Peg, Peg, Peg, Out, Out, Out],
  [Out, Out, Out, Peg, Peg, Peg, Out, Out, Out],
  [Out, Peg, Peg, Peg, Peg, Peg, Peg, Peg, Out],
  [Out, Peg, Peg, Peg, Emp, Peg, Peg, Peg, Out],
  [Out, Peg, Peg, Peg, Peg, Peg, Peg, Peg, Out],
  [Out, Out, Out, Peg, Peg, Peg, Out, Out, Out],
  [Out, Out, Out, Peg, Peg, Peg, Out, Out, Out],
  [Out, Out, Out, Out, Out, Out, Out, Out, Out],
]

struct Direction {
  dx : Int
  dy : Int
}

let direction : Array[Direction] = [
  { dx: 0, dy: 1 },
  { dx: 1, dy: 0 },
  { dx: 0, dy: -1 },
  { dx: -1, dy: 0 },
]

fn solve(m : Int) -> Bool {
  if m == 31 {
    return board[4][4] == Peg
  } else {
    let mut i = 1
    while i <= 7 {
      let mut j = 1
      while j <= 7 {
        if board[i][j] == Peg {
          let mut k = 0
          while k <= 3 {
            let dx = direction[k].dx
            let dy = direction[k].dy
            let i1 = i + dx
            let i2 = i + dx + dx
            let j1 = j + dy
            let j2 = j + dy + dy
            if board[i1][j1] == Peg && board[i2][j2] == Emp {
              board[i][j] = Emp
              board[i1][j1] = Emp
              board[i2][j2] = Peg
              if solve(m + 1) {
                return true
              }
              board[i][j] = Peg
              board[i1][j1] = Peg
              board[i2][j2] = Emp
            }
            k = k + 1
          }
        }
        j = j + 1
      }
      i = i + 1
    }
  }
  return false
}

fn init {
  @lib.assert(solve(0))
}
