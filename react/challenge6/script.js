function Header(){
    return(
        <header>
            <nav>
                <img src="../react-logo.png" width="50px"/>
            </nav>
        </header>
    )
}

function Footer(){
    return (
    <footer>
        c 2023 Junla development. All rights reserved.
    </footer>)
}

function Content(){
    return(
        <div>
            <h1>I'm Learning React</h1>
            <ol>
                <li>I want to expand my Web Development Skills</li>
                <li>I want to create Apps more efficiently</li>
                <li>I want to become a better developer</li>
            </ol>
        </div>
    )
}

function Page(){
    return (
        <div>
            <Header/>
            <Content/>
            <Footer/>
        </div>
    )
}

const root = ReactDOM.createRoot(document.querySelector(".root"))
root.render(<Page/>)