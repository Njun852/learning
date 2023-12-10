setTimeout(()=>{
    console.log("async task")
}, 0)

for(let i = 1; i < 100; i++){
    console.log(`task number: ${i}`)
}