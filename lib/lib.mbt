pub fn todo[T]() -> T {
  abort("")
}

pub fn assert(ok : Bool) {
  if not(ok) {
    abort("")
  }
}
