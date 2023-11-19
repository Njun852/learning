// const first = [1, 2, 3]
// const second = [4, 5, 6]

// //old way to combine
// const oldCombine = first.concat(second)

// //new way to combine
// const newCombine = [...first, 3.5,...second, 7]

// //cloning an array

// const clone = [...first]

// console.log(first)
// console.log(clone)

const first = { name: "Mosh"}
const second = { job: "Instructor"}

const combined = {...first, ...second, location: "Australia"}
const clone = {...first}
console.log(combined)
