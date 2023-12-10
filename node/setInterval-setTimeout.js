function interval(callback, time, i){
    setTimeout(()=>{
        callback(i)
        interval(callback, time, i)
    }, time)
}

let i = 0
interval((i)=>{
    console.log(i);
}, 1000, i)