$( document ).ready(function() {
    window.addEventListener('message', function(e){
        evenCallback[e.data.event](e.data)
    })
    var evenCallback = {
        toggle: function(data){
            switch (data.name){
                case "request_menu":
                    if(data.open == true){
                        $("#request_menu").show()
                    }else{
                        $("#request_menu").hide()
                    }
                    break;
                default:
            }
        },
        init: function(data){
            switch (data.name){
                case "request_menu":
                    var initData = data.initData;
                    $("#request_table tbody").empty()
                    for(i = 0; i < initData.length; i++){
                        $("#request_table tbody").append(`
                            <tr>
                                <td>
                                    ${initData[i].name}
                                </td>
                                <td>
                                    ${initData[i].time}
                                </td>
                                <td>
                                    ${initData[i].by}
                                </td>
                                <td>
                                    ${initData[i].reason}
                                </td>
                                <td>
                                    <button class="btn btn-danger" id="remove" identifier="${initData[i].identifier}" type="submit">Xóa</button>
                                </td>
                            </tr>
                        `)
                    }
                    break;
                default:
            }
        }
    }
    ////////////////////////WEAPON WHEEL/////////////////////////////
    
    /////////////////////////////REQUESTMENU/////////////////////////////
    const $requestTable = $('#request_table');
    $requestTable.on('click', '#remove', function () {
        //var id = $(this).parents('tr').find("td:nth-child(1)").html().trim();
        var identifier = $(this).attr('identifier');
       // console.log(id);
        $.post("http://esx_blacklist/request:remove", JSON.stringify({identifier: identifier}));
    })
    
    /////////////////////////////WHEEL/////////////////////////////
    $(document).ready(function(){
        
        
    });
    /////////////////////////////KEYLISTENER/////////////////////////////
    window.addEventListener("keyup", function(event){
        if(event.key == "Escape"){
            $.post('http://esx_blacklist/closeNUI', JSON.stringify({}));
            $("#request_menu").hide();
            $("#request-menu-modal").modal('hide');
        }
    })
    /////////////////////////////NOTIFICATION/////////////////////////////
    // function SendNotification(msg){
    //     $.post('http://esx_blacklist/Notification', JSON.stringify({msg:msg}));
    // }
    // $.post("http://esx_blacklist/ready", JSON.stringify({}));
});