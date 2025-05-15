import './index.css'
import reactLogo from './react.webp'
import { createRoot } from 'react-dom/client'

const root = createRoot(document.getElementById('root'))
function TemporaryName() {
    return (
        <main>
            <img src={reactLogo} width={80}/>
            <h1>Fun facts about React!</h1>
            <ul>
                <li>Was first released in 2013</li>
                <li>Was originally created by Jordan Walke</li>
                <li>Has well over 100K stars on GitHub</li>
                <li>Is maintained by Meta</li>
                <li>Powers thousands of enterprise apps, including mobile apps</li>
            </ul>
        </main>
    )
}
root.render(
    <TemporaryName/>
)

