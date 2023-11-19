
const sayHi = ()=>{
    console.log("Hi!")
    console.log("Hello!")
}
const square = number => number * number

const jobs = [
    { id: 1, isActive: true},
    { id: 2, isActive: true},
    { id: 3, isActive: false},
]

const activeJobs = jobs.filter(job => job.isActive)