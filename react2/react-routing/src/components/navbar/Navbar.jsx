import { Outlet } from "react-router"
import './navbar.css'
function Navbar() {
    return (
        <div className="wrapper">
            <header className="navbar">
                <h1>My Website</h1>
                <ul>
                    <li>Home</li>
                    <li>About</li>
                    <li>Contact</li>
                </ul>
            </header>
            <div className="content">
                <Outlet/>
            </div>
        </div>
    )
}

export default Navbar