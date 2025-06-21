$(function () {
	window.addEventListener('message', function(event) {
		if (event.data.action == "setValue") {
			setValue(event.data.value);
		} else if (event.data.action == "toggle") {
			if (event.data.show) {
				$('#ui').show();
			} else {
				$('#ui').hide();
			}
		}
	});
});

function setValue(value){
	if (value.top1 != undefined)
		$('#top1 span').html(value.top1.name + "[ " + value.top1.diem + " ]");
	else
		$('#top1 span').html("Đang Load");
	if (value.top2 != undefined)
		$('#top2 span').html(value.top2.name + "[ " + value.top2.diem + " ]");
	else
		$('#top2 span').html("Đang Load");
	if (value.top3 != undefined)
		$('#top3 span').html(value.top3.name + "[ " + value.top3.diem + " ]");
	else
		$('#top3 span').html("Đang Load");
	if (value.mytop != undefined)
		$('#mytop span').html(value.myvt + ": " + value.mytop.name + "[ " + value.mytop.diem+ " ]");
}