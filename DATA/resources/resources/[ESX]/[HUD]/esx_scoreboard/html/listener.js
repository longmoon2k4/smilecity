var visable = false;
function menuToggle(state, send) {
	visable = false;
	if(state) {
	    $("#wrap").fadeIn();
	} else {
	    $("#wrap").fadeOut();
	}
    if(send){
        $.post("http://esx_scoreboard/toggle",JSON.stringify({state:state}));
    }
}

$(function () {
	document.onkeyup = function (data) {
	    if (data.which == 27) {
	        menuToggle(false,true);
	    }
	    // if (data.which == 121) {
	    // 	menuToggle(false,true);
	    // }
	    // if (data.which == 120) {
	    // 	menuToggle(false,true);
	    // }
	};
	window.addEventListener('message', function (event) {

		

		switch (event.data.action) {
			case 'toggle':
				menuToggle(event.data.state, false)
				break;

			case 'close':
				menuToggle(false, false)
				break;

			case 'toggleID':

				if (event.data.state) {
					$('td:nth-child(3),th:nth-child(3)').show();
					$('td:nth-child(6),th:nth-child(6)').show();
					$('td:nth-child(9),th:nth-child(9)').show();
				} else {
					$('td:nth-child(3),th:nth-child(3)').hide();
					$('td:nth-child(6),th:nth-child(6)').hide();
					$('td:nth-child(9),th:nth-child(9)').hide();
				}

				break;

			case 'updatePlayerJobs':
				var jobs = event.data.jobs;

				$('#player_count').html(jobs.player_count);

				$('#ems').html(jobs.ems);
				$('#police').html(jobs.police);
				$('#mechanic').html(jobs.mechanic);
				break;

			case 'updatePlayerList':
				$('#playerlist tr:gt(0)').remove();
				$('#playerlist').append(event.data.players);
				sortPlayerList();
				break;

			case 'updateServerInfo':
				if (event.data.maxPlayers) {
					$('#max_players').html(event.data.maxPlayers);
				}

				if (event.data.uptime) {
					$('#server_uptime').html(event.data.uptime);
				}

				if (event.data.playTime) {
					$('#play_time').html(event.data.playTime);
				}

				break;

			default:
				console.log('esx_scoreboard: unknown action!');
				break;
		}
	}, false);
});


function sortPlayerList() {
	var table = $('#playerlist'),
		rows = $('tr:not(.heading)', table);

	rows.sort(function(a, b) {
		var keyB = $('td', b).eq(0).html();
		var keyA = $('td', a).eq(0).html();

		return (keyB - keyA);
	});

	rows.each(function(index, row) {
		table.append(row);
	});
}

