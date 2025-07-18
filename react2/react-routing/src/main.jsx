import { createRoot } from 'react-dom/client'
import App from './App.jsx'
import './index.css'
import Navbar from './components/navbar/Navbar.jsx'
import { BrowserRouter, Routes, Route } from 'react-router'

const root = document.querySelector("#root")

createRoot(root).render(
  <BrowserRouter>
    <Routes>
      <Route path="/" element={<Navbar/>}>
        <Route path=":name" element={<App/>}/>
      </Route>
    </Routes>
  </BrowserRouter>
)
