function menuToggle(state, send) {
    if(state) {
        $("html").show();
    } else {
        $(".html").hide();
    }
    if(send){
        $.post("http://sulu_mohom/toggle",JSON.stringify({state:state}));
    }
}


function startRoll(list, seed, pick){
  $("#openCase").hide();
  var obj = document.createElement("audio");
    obj.src = "mohom.ogg"; 
    obj.play(); 
  setTimeout(function(){
    var landLine = seed;
    $(".itemBoxAn").animate(
      {right: landLine},
        {
          duration: 9000,
          easing: 'easeOutQuint'
        }
    );

    var item = $("#item_" + pick).attr('key');
    setTimeout(function(){
      $(".reward").append('<img class="reward_img smoll" src="nui://ox_inventory/web/images/'+pick+'.png">');
      cleanup()
    }, 8000);
  }, 500);      
}


$(function(){
  menuToggle(false,false);
  var datacache = null;
  var itemcache = null;

  $("#openCase").click(function(){
    if ($(this).hasClass('disabled')) {
      return false;
    }
    startRoll();
  });

  document.onkeyup = function (data) {
      if (data.which == 27) {
          menuToggle(false,true);
          location.reload();
      }
  };

  window.addEventListener('message', function(event){
    if(event.data.type == "mohom") {
      var list = event.data.list;
      var datacrate = event.data.crate;
      var datacratelabel = event.data.label;
      var rarity = Config.rarity;
      $('.bgcrateimg').attr('src','img/' + datacrate + '.png');
      $(".bgcratetitle").html(datacratelabel);
      for (var i = 0; i <= list.length; i++) {
        $(".itemcontainer").append('<div class="itemBoxAn itemboxbg_'+i+'" id="item_'+i+'" key="'+list[i]+'">  </div>');
        $('#item_' + i).append('<img class="itemimg itemimg_'+i+'"></div>');
        $('.itemimg_' + i).attr('src','nui://ox_inventory/web/images/' + list[i] + '.png');
        for (var j = 0; j < rarity.length; j++) {
          if(rarity[j].item == list[i]){
            $('.itemboxbg_' + i).css('background-image', 'url("img/' + rarity[j].rarity + '.png")');
            break;
          } else{
            $('.itemboxbg_' + i).css('background-image', 'url("img/blue.png")');
          }
        }
      }
      startRoll(event.data.list, event.data.seed, event.data.pick);
    }
    if(event.data.type == "toggle"){
        menuToggle(event.data.state,false);
    }
  });
});

function cleanup(){
  $(".animationAreaItems").hide();
  $("#yeet").removeClass('bgcover');
  $(".bgcrateimg").hide();
  $(".bglogo").hide();
  $(".bgcratetitle").hide();
  $(".reward").fadeIn();
  setTimeout(function(){
    $(".reward").fadeOut();
    menuToggle(false,true);
    location.reload();
  }, 2000);
}