function ReasonsImExcitedToLearnReact(){
    return (
        <div>
        <header>
            <nav>
                <img src="react-logo.png" width="50px"/>
                </nav>
        </header>
        <h1>I'm Learning React</h1>
        <ol>
            <li>I want to expand my Web Development Skills</li>
            <li>I want to create Apps more efficiently</li>
            <li>I want to become a better developer</li>
        </ol>
        <footer>c 2023 Junla development. All rights reserved.</footer>
        </div>
    )
}

const root = ReactDOM.createRoot(document.querySelector(".root"))
root.render(<ReasonsImExcitedToLearnReact/>)