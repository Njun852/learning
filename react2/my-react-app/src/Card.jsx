import profilePic from "./assets/profile.jpg";

export default function Card() {
    return (
        <div className="card">
            <img className="card-img" alt="profile picture" src={profilePic}/>
            <h2 className="card-title">Njun</h2>
            <p className="card-text">I'm Njun and I study Computer Science and play video games.</p>
        </div>
    )
}