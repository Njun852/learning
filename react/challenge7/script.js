function Header(){
    return(
        <header>
            <nav className="nav">
                <img src="triangle.jpg" className="nav-img"/>
                <h1>Love Foundation</h1>
                <ul className="nav-items">
                    <li>Area 51</li>
                    <li>Judgement Day</li>
                    <li>Flat Earth</li>
                </ul>
            </nav>
        </header>
    )
}

function MainContent(){
    return (
        <div className="main-content">
            <p>Hello, we are humans from the planet Earth. 
                We come in peace and wish to communicate and learn from you. 
                We are a species that values knowledge, empathy, and the exploration of the universe. 
                We hope to establish a peaceful and beneficial relationship with you. 
                Please respond if you receive this message.</p>
            <img src="hello.jpg"/>
        </div>
    )
}
function SideContent(){
    return (
        <div className="side-content">
            <div className="vaccine article">
                <p>
                    The Unseen Puppeteers: An Exploration of Vaccines and Government Mind Control
                </p>
                <img src="cure.jpg"/>
            </div>
            <div className="earth article">
                <p>A Journey to the Edge of the World</p>
                <img src="earth.jpg"/>
            </div>
            <div className="article">
                <p>5G Waves: The Unseen Brain Meltdown</p>
                <img src="wifi.jpg"/>
            </div>
        </div>
    )
}
function Content(){
    return (
        <div className="contents">
            <MainContent/>
            <SideContent/>
        </div>
    )
}
function Page(){
    return (
        <div>
            <Header/>
            <Content/>
        </div>
    )
}

const root = ReactDOM.createRoot(document.querySelector(".root"))
root.render(<Page/>)