$(document).ready(function () {
    window.addEventListener('message', function (e) {
        if (e.data.event === 'sound') {
            document.getElementById("my_audio").play()
        } else {
            evenCallback[e.data.event](e.data)
        }
    })
    var evenCallback = {
        toggle: function (data) {
            switch (data.name) {
                case "request_menu":
                    if (data.open == true) {
                        $("#request_menu").show()
                    } else {
                        $("#request_menu").hide()
                    }
                    break;
                default:
            }
        },
        init: function (data) {
            switch (data.name) {
                case "request_menu":
                    var initData = data.initData;
                    $("#request_table tbody").empty()
                    for (i = 0; i < initData.length; i++) {
                        var status;
                        var _button = "";
                        var _cancel = "";
                        if (initData[i].isAccept == 1) {
                            _cancel = '<button class="btn btn-warning" id = "cancel" type="submit">Hủy</button>'

                            _button = '<button class="btn btn-info" id = "getPos" type="submit">Lấy tọa độ</button>'
                        }
                        if (initData[i].status != 0) {
                            status = initData[i].status;

                        } else {
                            status = "Chưa nhận";
                            _button = '<button class="btn btn-success" id = "accept" type="submit">Nhận</button>'
                        }
                        $("#request_table tbody").append(`
                            <tr>
                                <td>
                                    ${initData[i].id}
                                </td>
                                <td>
                                    ${initData[i].name}
                                </td>
                                <td>
                                    ${initData[i].distance}
                                </td>
                                <td>
                                    ${status}
                                </td>
                                <td>
                                    ${initData[i].time}
                                </td>
                                <td>
                                    
                                    <button class="btn btn-danger" id="remove" type="submit">Xóa</button>
                                    ${_button}
                                    ${_cancel}
                                </td>
                            </tr>
                        `)
                    }
                    break;
                default:
            }
        }
    }
    // <button class="btn btn-primary" id="info" info="${initData[i].info}" type="submit">Chi Tiết</button>
    ////////////////////////WEAPON WHEEL/////////////////////////////

    /////////////////////////////REQUESTMENU/////////////////////////////
    const $requestTable = $('#request_table');
    $requestTable.on('click', '#remove', function () {
        Swal.fire({
            title: 'Bạn có muốn xóa đơn?',
            text: "Bạn sẽ không thể hoàn tác!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Có, làm đi!'
        }).then((result) => {
            if (result.isConfirmed) {
                var id = $(this).parents('tr').find("td:nth-child(1)").html().trim();
                console.log(id);
                $.post("http://esx_request/request:remove", JSON.stringify({ id: id }));
            }
        })

    })
    $requestTable.on('click', '#info', function () {
        console.log($(this).attr('info'));
        $("#request-menu-modal .modal-body").text($(this).attr('info'));
        $("#request-menu-modal").modal('toggle')
    })
    $requestTable.on('click', '#getPos', function () {
        var id = $(this).parents('tr').find("td:nth-child(1)").html().trim();
        console.log(id);
        $.post("http://esx_request/request:getPos", JSON.stringify({ id: id }));
    })
    $requestTable.on('click', '#cancel', function () {
        var id = $(this).parents('tr').find("td:nth-child(1)").html().trim();
        $.post("http://esx_request/request:cancel", JSON.stringify({ id: id }));
    })
    $requestTable.on('click', '#accept', function () {
        var id = $(this).parents('tr').find("td:nth-child(1)").html();
        var status = $(this).parents('tr').find("td:nth-child(4)").html().trim();
        if (status == "Chưa nhận") {
            $.post("http://esx_request/request:accept", JSON.stringify({ id: id }));
        } else {
            SendNotification(status + " đã nhận người này")
        }
    })
    /////////////////////////////WHEEL/////////////////////////////
    $(document).ready(function () {


    });
    /////////////////////////////KEYLISTENER/////////////////////////////
    window.addEventListener("keyup", function (event) {
        if (event.key == "Escape") {
            $.post('http://esx_request/closeNUI', JSON.stringify({}));
            $("#request_menu").hide();
            $("#request-menu-modal").modal('hide');
        }
    })
    /////////////////////////////NOTIFICATION/////////////////////////////
    function SendNotification(msg) {
        $.post('http://esx_request/Notification', JSON.stringify({ msg: msg }));
    }
    $.post("http://esx_request/ready", JSON.stringify({}));
});