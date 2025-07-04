import { useState } from "react"
export default function MyComponent(props) {
    const [foods, setFoods] = useState([])

    const handleAddFood = () => {
        const food = document.querySelector("input").value
        setFoods(f => [...f, food])
        document.querySelector("input").value = ""
    }
    const handleRemoveFood = (index) => {
        setFoods(f=> foods.filter((_, i)=>i!=index))
    }
    return (
        <>
            <h1>List of Food</h1>
            <ul>
                {foods.map((f, i) => <li key={i} onClick={()=>handleRemoveFood(i)}>{f}</li>)}
            </ul>
            <input type="text" />
            <button onClick={handleAddFood}>Add Food</button>
        </>
    )
}