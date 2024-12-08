import gleam/io
import gleam/int
import gleam/list
import gleam/string
import simplifile

pub fn main() {
  let data_path = "./data/d01/input.txt"
  io.println("> Day 1")
  io.println("Input: " <> data_path)
  io.println(">> Part 1")
  let #(list_a, list_b) = read_id_lists(data_path)
  let diff_sum = diff_id_lists(list_a, list_b) |> list.fold(0, int.add)
  io.println(int.to_string(diff_sum))
  io.println(">> Part 2")
  let counts = list_a |> list.map(fn (a) { list_b |> list.count(fn(b) { a == b }) })
  let similarity_score =
    list.zip(list_a, counts)
    |> list.map(fn(entry) {
        let #(a, count) = entry
        a * count
    })
    |> list.fold(0, int.add)
  io.println(int.to_string(similarity_score))
}

pub fn read_id_lists(path) {
  simplifile.read(path)
  |> fn(content) {
    let assert Ok(text) = content
    string.split(text, "\n")
    |> list.map(fn(line) {
      string.split(line, " ")
      |> list.filter(fn(v) { string.trim(v) != "" })
      |> fn(entry) {
        let assert Ok(#(str_a, entry)) = list.pop(entry, fn(_) { True })
        let assert Ok(#(str_b, _)) = list.pop(entry, fn(_) { True })
        let assert Ok(a) = int.parse(str_a)
        let assert Ok(b) = int.parse(str_b)
        #(a, b)
      }
    })
    |> list.unzip
  }
}

pub fn diff_id_lists(list_a, list_b) {
    let sorted_a = list.sort(list_a, int.compare)
    let sorted_b = list.sort(list_b, int.compare)
    list.zip(sorted_a, sorted_b)
    |> list.map(fn (entry) {
        let #(a, b) = entry
        int.absolute_value(b - a)
    })
}
