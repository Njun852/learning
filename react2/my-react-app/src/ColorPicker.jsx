import { useState } from "react"

export default function MyComponent() {
    const [color, setColor] = useState("#b04f4f");

    function updateColor(e) {
        setColor(e.target.value)
    }
    return (
        <div className="picker-container">
            <h1>Color Picker</h1>
            <div className="color-container" style={{backgroundColor: color}}>
                <p>Selected Color: <br/>{color}</p>
            </div>
            <label ><b>Select a Color:</b></label>
            <input type="color" value={color} name="picker" onChange={updateColor}/>
        </div>
    )
}