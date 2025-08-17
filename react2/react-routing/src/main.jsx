import { createRoot } from 'react-dom/client'
import App from './App.jsx'
import './index.css'
import Navbar from './dashboard/navbar/Navbar.jsx'
import { BrowserRouter, Routes, Route } from 'react-router'
import About from './dashboard/about/About.jsx'
import Contact from './dashboard/contact/Contact.jsx'

const root = document.querySelector("#root")

createRoot(root).render(
  <BrowserRouter>
    <Routes>
      <Route path="dashboard" element={<Navbar/>}>
        <Route path="home" index element={<App/>}/>
        <Route path="about" element={<About/>}/>
        <Route path="contact" element={<Contact/>}/>
      </Route>
    </Routes>
  </BrowserRouter>
)
