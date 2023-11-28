fetch("https://reqres.in/api/users", {
    method: "POST",
    headers: {
        "Content-Type": "application/json"
    },
    body: JSON.stringify({
        name: "User 1"
    })
})
    .then(response => {
        if(response.ok){
            console.log("SUCCESS")
        }else{
            console.log("FAILED")
        }
        return response.json()
    })
        .then(data => console.log(data))

fetch("https://reqres.in/api/users")
    .then(response => response.json())
        .then(data => console.log(data))

