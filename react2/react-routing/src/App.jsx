import { useParams } from "react-router"

function App() {
  let params = useParams()
  return (
   <h1>Hello {params.name}</h1>
  )
}

export default App
