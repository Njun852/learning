function Page(){
    return (
        <div className="page">
            <Header/>
            <Content/>
            <Footer/>
        </div>
    )
}
const root = ReactDOM.createRoot(document.querySelector(".root"))
root.render(<Page/>)