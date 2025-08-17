import { useParams } from "react-router"
import Navbar from "./dashboard/navbar/Navbar"

function App() {
  let params = useParams()
  return (
    <>
     <h1>Hello {params.name}</h1>
    </>
  )
}

export default App
