import gleeunit
import gleeunit/should
import d01

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  1
  |> should.equal(1)
}

pub fn d01_test() {
  d01.main()
}