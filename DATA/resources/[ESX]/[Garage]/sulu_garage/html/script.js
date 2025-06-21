$(function () {
    const timer = ms => new Promise(res => setTimeout(res, ms))
    window.addEventListener('message', async function (event) {
        if (event.data.type == 'shop') {
            $('.total').fadeIn();
            var i;
            for (i = 0; i < event.data.result.length; i++) {
                await timer(100);
                var dongco = Math.floor(event.data.result[i].vehicle.engineHealth / 1000 * 100) || 100
                var thanxe = Math.floor(event.data.result[i].vehicle.bodyHealth / 1000 * 100) || 100
                if (event.data.result[i].impound == "0") {
                    $('#wrapper').append(
                        ` <li class="dropdown ${event.data.result[i].stored == '1' ? "bg-green":"bg-red"}">
                                <input type="checkbox" />
                                <div data-toggle="dropdown">${event.data.result[i].type == 'car' ? `🚘` : event.data.result[i].type == 'boat' ? `⛵` : event.data.result[i].type == 'aircraft' ? `🚁` : `🚘`} ${event.data.result[i].name}</div>
                                    <ul class="dropdown-menu">
                                        <li>🔧 Thân xe: ${dongco}%</li>
                                        <li>🔩 Động cơ: ${thanxe}%</li>
                                        <li>🤝 Lượt chuyển: ${event.data.result[i].soluong}</li>
                                        <li>💳 Biển số: ${event.data.result[i].plate}</li>
                                        <li>
                                            ${event.data.result[i].stored == '1' ? `<button class="btn btn-success" id = "buybutton" number = ${i}>Lấy</button>` : `<button class="btn btn-danger"  id = "buybutton" number = ${i}>Chuộc</button>`}
                                            <button class="btn btn-success"  id="changename" number=${i}>Đổi tên</button>
                                            <button class="btn btn-danger" id = "delete" number = ${i}>Xóa</button>
                                        </li>
                                    </ul>
                            </li>`
                    )
                } else {
                    $('#wrapper').append(
                        `<li class="dropdown bg-red">
                            <input type="checkbox" />
                            <div data-toggle="dropdown">${event.data.result[i].name == 'car' ? `🚘` : event.data.result[i].name == 'boat' ? `⛵` : event.data.result[i].name == 'aircraft' ? `🚁` : `🚘`} ${event.data.result[i].name} đã bị giam</div>
                            <ul class="dropdown-menu">
                                <li>
                                    <button class="btn btn-danger" id = "unimpound" number = ${i}>Chuộc</button>
                                </li>
                            </ul>
                        </li>`
                    )
                }

            }
            $("body").on("click", "#changename", function () {
                var number = $(this).attr('number');
                var plate = event.data.result[number].plate;
                $.post('https://sulu_garage/escape', JSON.stringify({}));
                location.reload(true);
                $('.total').hide("fast");
                $.post('https://sulu_garage/changeName', JSON.stringify({ plate: plate }))
            });

            $("body").on("click", "#unimpound", function () {
                var number = $(this).attr('number');
                var plate = event.data.result[number].plate;
                var vehicle = event.data.result[number].value.vehicle;
                var body = event.data.result[number].vehBody;
                var engine = event.data.result[number].vehEngine;
                $.post('https://sulu_garage/escape', JSON.stringify({}));
                location.reload(true);
                $('.total').hide("fast");
                $.post('https://sulu_garage/unimpoundVehice', JSON.stringify({ vehicle: vehicle, plate: plate,vehBody: body, vehEngine: engine  }))
            });
            $("body").on("click", "#delete", function () {
                var number = $(this).attr('number');
                var plate = event.data.result[number].plate;
                var name = event.data.result[number].name;
                $.post('https://sulu_garage/escape', JSON.stringify({}));
                location.reload(true);
                $('.total').hide("fast");
                $.post('https://sulu_garage/deleteVehicle', JSON.stringify({ plate: plate ,name: name}))
            });
            $("body").on("click", "#buybutton", function () {
                var number = $(this).attr('number');
                var vehicle = event.data.result[number].value.vehicle;
                var plate = event.data.result[number].plate;
                var stored = event.data.result[number].stored;
                var body = event.data.result[number].vehBody;
                var engine = event.data.result[number].vehEngine;
                if (stored == '1') {
                    $.post('https://sulu_garage/spawnVehicle', JSON.stringify({ vehicle: vehicle, plate: plate, vehBody: body, vehEngine: engine }));
                    $.post('https://sulu_garage/escape', JSON.stringify({}));
                    location.reload(true);
                    $('.total').hide("fast");
                } else {
                    $.post('https://sulu_garage/returnVehicle', JSON.stringify({ vehicle: vehicle, plate: plate, vehBody: body, vehEngine: engine }));
                    $.post('https://sulu_garage/escape', JSON.stringify({}));
                    location.reload(true);
                    $('.total').hide("fast");
                }
            });
        }
    });




    document.onkeyup = function (data) {
        if (data.which == 27) { // Escape key
            $.post('https://sulu_garage/escape', JSON.stringify({}));
            location.reload(true);
            $('.total').hide("fast");
        }
    }
});