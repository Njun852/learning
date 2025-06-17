export default function List(props) {
    const category = props.category
    const itemList = props.items

    const elems = itemList.map(e => <li key={e.id}>{e.name}: &nbsp; <b>{e.calories}</b></li>)
    
    return (
        <>
            <h3 className="list-category">{category}</h3>
            <ol className="list-items">
                {elems}
            </ol>
        </>
    )
}
