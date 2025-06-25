export default function ProfilePicture() {
    const imgUrl = './src/assets/dog.gif'
    const handleClick = (e) => e.target.style.display = "none"
    return <img src={imgUrl} onClick={(e)=>handleClick(e)}/>
}