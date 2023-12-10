
function getThing(){
    return new Promise((resolve, reject)=>{
        resolve("Yoooo")
    })
}
getThing()
.then(data => console.log(data))
console.log("Hi!")