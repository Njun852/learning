import reactLogo from './React.webp'

export default function Header() {
  return (
    <header className="header">
      <img src={reactLogo} width={50} height={50}/>
      <nav >
        <ul className="nav-list">
          <li>Pricing</li>
          <li>About</li>
          <li>Contact</li>
        </ul>
      </nav>
    </header>
  )
}