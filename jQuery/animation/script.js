$('document').ready(()=>{
    $('button').click('Hi', (e)=>{
        // $('img').animate({
        //     rotate: '1turn',
        //     opacity: 1,
        //     left: '200px'
        // }, 2000)
        // $('p').removeClass('italic blue')
        // $('p').remove()
        // $('body').empty()
        // $('body').html(
        //     `<div>
        //         <h1>Hi!</h1>
        //         <p>Hello World</p>
        //     </div>`
        //     )
        // $('p:first').text('Yoo')
        // $('p').css({color: 'white', backgroundColor: 'black', fontSize: '2rem'}).fadeToggle(200)
        $('div').width('40%')
        $('div').height('100px')
        // $('div').innerWidth(300)
        // $('div').innerHeight(300)
        // $('div').outerWidth(200).outerHeight(300)
        // console.log('hi')
        // console.log($('input').value())
        console.log(e.target)
    })
    $('input').attr('value', 'Hello!')
    // $('window').resize(function(){
    //     console.log('hi')
    // })
    // $(window).resize(function(){
    //     console.log('hi')
    // });
    // function eventHandler(e){
    //     console.log(e.pageX)
    // }
    // $(window).mousemove(eventHandler)
})
