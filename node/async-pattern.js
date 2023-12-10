const {readFile, writeFile} = require("fs")
const util = require("util")

const getReadPromise = util.promisify(readFile)
const getWriteFilePromise = util.promisify(writeFile)

async function read(){
    const first = await getReadPromise("./content/data.txt", "utf-8")
    const second = await getReadPromise("./content/data-2.txt", "utf-8")
    console.log(first, second);
}

async function write(path, data){
    await getWriteFilePromise(path, data)
}

read()