$(document).ready(function () {
    const $rangeInput = $("#vol");
    const $imgCros = $(".imgCros");

    $rangeInput.on("input", function() {
        const currentValue = $rangeInput.val();
        $imgCros.css("width", currentValue + "px");
        $imgCros.css("height", currentValue + "px");
    });
});
window.addEventListener("message", function(event) {
    var v = event.data
    // var datos = v.data
    
    switch (v.action) {
        case 'openMenu':
            $('.container').fadeIn(100)
        break;


        case 'Load': 
            $('.cuerpocontainer').append(`
                <div class="itemscontainer">
                <h1>${v.label}</h1>
                    <div class="alignImg">
                    <img class="${v.valor}-img" src="${v.imagenes}" alt="">
                    </div>
                    <div class="alignItems">
                    <a class="${v.valor}-click" href="#">Select Crosshair</a>
                    </div>
                </div>
            `)

            $(`.${v.valor}-click`).click(function(){
               var imagen = $(`.${v.valor}-img`)
               var sourceimg = imagen[0].src
               $('.crosshair img').attr('src', sourceimg)
            //    var width = $imgCros.css("width");
               localStorage.setItem('Roda_CrosshairImg', sourceimg)
            //    localStorage.setItem('Roda_CrosshairWidth', width)
               CloseAll()
            })
        break;
    }
});


$(function(){
    $('.salir').click(function(){
        CloseAll()
    })
    $('.matar').click(function(){
        $('.crosshair img').attr('src', '')
        localStorage.setItem('Roda_CrosshairImg', '')
        CloseAll()
    })
})


function CloseAll() {
    $('.container').fadeOut(100)
    $.post('https://sulu_cros/exit', JSON.stringify({}));
}

$(document).keyup((e) => {
    if (e.key === "Escape") {
        CloseAll()
    }
});

function LoadCrosshair() {
    var srcimgpe = localStorage.getItem('Roda_CrosshairImg')
    // var widthScore = localStorage.getItem('Roda_CrosshairWidth')
    $('.crosshair img').attr('src', srcimgpe || '')
    // $('.imgCros').attr('width', widthScore || '20px')
    // $('.imgCros').attr('height', widthScore || '20px')
}



window.addEventListener('load', () => {
    $.post('https://sulu_cros/loadData', JSON.stringify({}));
    LoadCrosshair()
});