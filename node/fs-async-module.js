const {readFile, writeFile} = require("fs")


function getResponse(data){
    return new Promise((resolve, reject)=>{
        readFile(`./content/${data}`, "utf-8", (err, result)=>{
            if(err) reject("Something went wrong")
            resolve(result)
        })
    })
}
async function getData(){
    try{
        const first = await getResponse("data.txt")
        const second = await getResponse("data-2.txt")
        return [first, second]
    }catch(err){
        console.log("Oh no")
    }
}

async function writeData(file, data){
    writeFile(`./content/${file}`, data, (err)=>{
        if(err){
            console.log("there is an error")
            return
        }
    })
}

getData()
.then(data => console.log(data))
writeData("data-async.txt", "This is an text writing using async ok")

