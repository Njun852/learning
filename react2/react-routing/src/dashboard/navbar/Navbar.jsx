import { Outlet,NavLink, Link } from "react-router"
import './navbar.css'
function Navbar() {
    const cssStyle = {color: "white", textDecoration: "none"}
    
    return (
        <div className="wrapper">
            <header className="navbar">
                <h1>My Website</h1>
                <ul>
                    <NavLink to="/dashboard/home" style={cssStyle}>
                        <li>Home</li>
                    </NavLink>
                    <NavLink to="/dashboard/about" style={cssStyle}>
                        <li>About</li>
                    </NavLink>
                    <NavLink to="/dashboard/contact" style={cssStyle}>
                        <li>Contact</li>
                    </NavLink>
                </ul>
            </header>
            <Outlet/>
        </div>
    )
}

export default Navbar