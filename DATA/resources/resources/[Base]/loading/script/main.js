// Hàm để tăng hoặc giảm âm lượng trong nền
var play = false;
var vid = document.getElementById("loading");
vid.volume = 0.2;
window.addEventListener('keyup', function(e) {
    if (e.which == 38) { // Mũi tên xuống
        vid.volume = Math.min(vid.volume + 0.025, 1);
    } else if (e.which == 40) { // Mũi tên lên
        vid.volume = Math.max(vid.volume - 0.025, 0);
    };
});

// Hàm để tạm dừng hoặc phát nhạc nền
var audio = document.querySelector('audio');

if (audio) {

    window.addEventListener('keydown', function(event) {

        var key = event.which || event.keyCode;
        var x = document.getElementById("text").innerText;
        var y = document.getElementById("text");

        if (key === 32 && x == "MUTE") { // phím cách

            event.preventDefault();

            audio.paused ? audio.play() : audio.pause();
            y.innerHTML = "UNMUTE";

        } else if (key === 32 && x == "UNMUTE") {

            event.preventDefault();

            audio.paused ? audio.play() : audio.pause();
            y.innerHTML = "MUTE";
        }
    });
}

// SHADED-TEXT - Hàm để chuyển từ trong animation tải
var shadedText = document.querySelector('.shaded-text');
var texts = ["THAM GIA MÁY CHỦ", "CHUẨN BỊ TÀI NGUYÊN", "THIẾT LẬP KẾT NỐI"];
var currentText = 0;

setInterval(function() {
    currentText = (currentText + 1) % texts.length;
    shadedText.classList.remove('fade-out');
    void shadedText.offsetWidth;
    shadedText.classList.add('fade-out');
    setTimeout(function() {
        shadedText.textContent = texts[currentText];
    }, 1000);
}, 4000);

// PLACEHOLDER - Hàm để nhận dữ liệu chuyển đổi từ kịch bản Lua
window.addEventListener('DOMContentLoaded', () => {
    console.log(`Bạn đang kết nối đến Viking City`);

    // Điều cần lưu ý là việc sử dụng innerText, không phải innerHTML: tên là đầu vào của người dùng và có thể chứa HTML xấu!
    document.querySelector('#namePlaceholder > span').innerText = window.nuiHandoverData.name;
});

// RANDOMPHRASES - Câu chữ được tạo sau tên Steam của bạn
(function welcometext() {
    var welcomes = ['Bắt đầu cuộc phiêu lưu mới thú vị.', 'Khám phá những kỳ diệu của thành phố mới của bạn.', 'Mở cánh cửa cho một chương mới hoàn toàn.', 'Bước vào một thế giới của những cơ hội mới.', 'Đón nhận sự khởi đầu mới của bạn.',];
    var randomWelcome = Math.floor(Math.random() * welcomes.length);
    document.getElementById('welcomeDisplay').innerHTML = welcomes[randomWelcome];
})();
