$('document').ready(() => {
    $('body > button:nth-of-type(2)').click(() => {
        $('img').hide(2000)
    })
    $('body > button:nth-of-type(1)').click(() => {
        $('img').show(2000)
    })
    $('body > button:nth-of-type(3)').click(() => {
        $('img').toggle(3000)
    })
    $('body > button:nth-of-type(4)').click(() => {
        $('img').fadeIn(3000)
    })
    $('body > button:nth-of-type(5)').click(() => {
        $('img').fadeOut(3000)
    })
    $('body > button:nth-of-type(6)').click(() => {
        $('img').fadeToggle(3000)
    })
    $('body > button:nth-of-type(7)').click(() => {
        $('img').slideUp(3000)
    })
    $('body > button:nth-of-type(8)').click(() => {
        $('img').slideDown(2000)
    })
    $('body > button:nth-of-type(9)').click(() => {
        $('img').slideToggle(2000)
    })
    $('body > button:nth-of-type(10)').click(() => {
        $('img').stop()
    })
})