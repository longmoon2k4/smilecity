---------------------------------------------------------- HÙNG KIRO DEVELOPMENT ---------------------------------------------
config = {
	['displayText'] = '<FONT FACE="arial font">~y~Nhấn ~g~[E] ~y~dịch chuyển đến mặt đất!', -- tin nhắn sẽ được hiển thị
	['key'] = 38, 													-- chìa khóa kích hoạt dịch chuyển tức thời (https://docs.fivem.net/docs/game-references/controls/)
	['preset'] = false,												-- false: đặt bàn đạp tại vị trí hiện tại trên mặt đất | true: đặt ped ở vị trí đặt trước trong cấu hình
	['coords'] = { x=0.0, y=0.0, z=0.0 },							-- tọa độ cho vị trí đặt trước
	['z_check'] = 0.0,												-- z phối hợp để nhắc người chơi tại, tìm thấy 0,0 là tốt nhất
	['freeze'] = false,												-- có đóng băng trình phát với số lượng đã chỉ định sau khi dịch chuyển hay không
	['freeze_time'] = 2,											-- số giây để đóng băng trình phát
	['check_swimming'] = true,										-- bỏ qua những người chơi đang bơi
	['check_falling'] = true,										-- bỏ qua những người chơi không rơi
	['check_inside'] = true,										-- bỏ qua những người chơi đang ở bên trong các tòa nhà - thử nghiệm -
}
