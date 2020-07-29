/**
 * .
 */

protocol Team {
  var marks: [String] { get }
  var playerPictures: [[String]] { get }
}

struct Owls: Team {
  let marks = ["4/5", "3/5", "4/5", "2/5"]
  let playerPictures = [
    ["Owls-goalkeeper"],
    ["Owls-d1", "Owls-d2", "Owls-d3", "Owls-d4"],
    ["Owls-m1", "Owls-m2", "Owls-m3", "Owls-m4"],
    ["Owls-f1", "Owls-f2"]
  ]
}

struct Tigers: Team {
  let marks = ["1/5", "3/5", "3/5", "5/5"]
  let playerPictures = [
    ["Tigers-goalkeeper",
    "Tigers-d1", "Tigers-d2", "Tigers-d3", "Tigers-d4"],
    ["Tigers-m1", "Tigers-m2", "Tigers-m3", "Tigers-m4"],
    ["Tigers-f1", "Tigers-f2"]
  ]
}

struct Parrots: Team {
  let marks = ["3/5", "2/5", "4/5", "5/5"]
  let playerPictures = [
    ["Parrots-goalkeeper"],
    ["Parrots-d1", "Parrots-d2", "Parrots-d3", "Parrots-d4"],
    ["Parrots-m1", "Parrots-m2", "Parrots-m3", "Parrots-m4"],
    ["Parrots-f1", "Parrots-f2"]
  ]
}

struct Giraffes: Team {
  let marks = ["5/5", "4/5", "3/5", "1/5"]
  let playerPictures = [
    ["Giraffes-goalkeeper"],
    ["Giraffes-d1", "Giraffes-d2", "Giraffes-d3", "Giraffes-d4"],
    ["Giraffes-m1", "Giraffes-m2", "Giraffes-m3", "Giraffes-m4"],
    ["Giraffes-f1", "Giraffes-f2"]
  ]
}
