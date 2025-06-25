import { useState } from "react"

export default function MyComponent() {
    const [name, setName] = useState("Guest");
    const [age, setAge] = useState(0)
    const [isEmployee, setIsEmployed] = useState(false)

    const updateName = () => {
        setName("Njun")
    }

    const incrementAge = () => {
        setAge(prev => prev+1)
    }

    const toggleEmployedStatus = () => {
        setIsEmployed(prev => !prev)
    }
    return (
        <div>
            <p>Name: {name}</p>
            <button onClick={updateName}>Set Name</button>
        
            <p>Age: {age}</p>
            <button onClick={incrementAge}>Increment Age</button>

            <p>Is employed: {isEmployee ? "Yes" : "No"}</p>
            <button onClick={toggleEmployedStatus}>Toggle Employed</button>
        </div>
    )
}