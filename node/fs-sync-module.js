const {readFileSync, writeFileSync} = require("fs")

const firstData = readFileSync("./content/data.txt", "utf-8")
const secondData = readFileSync("./content/data-2.txt", "utf-8")

console.log(firstData)
console.log(secondData);

writeFileSync("./content/data-sync.txt", "Hello this is the file created using writeFileSync")

const person = {
    name: "Bob",
    age: 24
}
writeFileSync("./content/person.json", JSON.stringify(person))

const personData = JSON.parse(readFileSync("./content/person.json", "utf-8"))
console.log(personData)

writeFileSync("text.txt", "Bye", {flag: "a"})