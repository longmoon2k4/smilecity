====REWARD EVENT====

*LƯU Ý TRƯỚC KHI SETUP:
+ Chạy file sql để insert item kích hoạt Premium và các cột lưu data Event
+ Source sửa dụng ESX và mysql-async
+ Các hàm ESX sử dụng:
	- Client: ESX.TriggerServerCallback, ESX.ShowNotification. 
	- Server: ESX.GetPlayers, ESX.GetPlayerFromId, ESX.RegisterServerCallback, ESX.RegisterUsableItem.
+ Các hàm MySQL: MySQL.Async.execute, MySQL.Async.fetchAll
+ Event ESX sử dụng: 'esx:saveplayer', 'esx:playerLoaded', 'esx:getSharedObject' 
+ Nếu muốn đổi tên source thì phải đổi event NUI

*HƯỚNG DẪN SETUP:
1/CONFIG (File : /share/config.lua): 
- Trước khi vào phần Setup Config thì phải nói sơ lược về cơ chế của event:
* Hiện tại hệ thống nhiệm vụ sẽ bao gồm 2 loại là NV chính và NV Hằng ngày
+ NV Chính gồm 12 loại nhiệm vụ, mỗi loại gồm 5 mốc => 5x12 = 60 Nhiệm vụ chính
+ NV Hằng ngày sẽ được random ngẫu nhiên mốc 1,2,3 của 3 loại NV khác nhau (ngoại trừ NV thứ 10,11,12 vì 3 NV chất cấm sẽ k rơi vào NV hằng ngày)

* Hệ thống cấp bậc điểm Event sẽ gồm có 30 cấp với điểm đạt được cấp 30 là 43000 điểm
* Source được Config mặc định với thời gian mở sự kiện từ 2-4 tuần: hoàn thành nhiệm vụ chính sẽ được 33000 Điểm, hoàn thành nhiệm vụ hằng ngày sẽ nhận được 1000 điểm mỗi ngày. 
* Không khuyến khích thay đổi mốc điểm của các Level, điểm event và cấp độ Event.

- Nếu như không muốn tính lại quá nhiều thì có thể sử dụng công thức tính toán sau.
Ví dụ: bạn muốn mở event trong vòng 4 tuần nhưng cần ít nhất 2 tuần để có thể hoàn thành được mốc điểm 30. Và bạn muốn 2 tuần cày đó người chơi phải dành ra 6 tiếng để cày event.
=> Tổng số giờ phải cày là 6x14 = 84 tiếng
Vì ngoài làm NV chính ra thì người chơi còn phải làm thêm NV hằng ngày mới có thể đạt được cấp độ cao nhất. nên ở đây sẽ trừ hao làm NV chính cần 70 tiếng.
Vậy ta có thời gian hoàn thành Nhiệm vụ chính là 70 tiếng.
Mà Nhiệm vụ chính sẽ gồm có 12 loại => mỗi loại cần phải cày ít nhất 70/12 = 5,8(3) tiếng = 350 phút
Như vậy ta sẽ có quy chuẩn mốc 5 của mỗi loại cần phải bỏ ra 350 phút điểm hoàn thành.
Ví dụ ta có loại NV là đi nhặt rác. với Source Nhặt Rác Ví dụ ta trải nghiệm sẽ cần 10p làm 1 chuyến và nhặt được 10 bịt rác
=> 350 phút sẽ nhặt đc 35x10 = 350 bịt rác
=> Mốc 5 của NV nhặt rác là 350 bịt rác
như vậy ta set Mốc 1 2 3 4 sẽ  rải rác sao cho độ khó dồn về sau
Ta có thể Config như sau: 

+ Mốc 1: count = 10
+ Mốc 2: count = 50
+ Mốc 3: count = 100
+ Mốc 4: count = 200
+ Mốc 5: count = 350

Việc này sẽ làm tương tự với các Source Job nghề khác.


* Nói thêm về phần Nhiệm vụ: Ví dụ ta đã config nghề Nhặt rác như trên thì ở mốc 2 ta chỉ cần làm thêm 40 bịt rác sẽ hoàn thành được vì số lượng sẽ được cộng dồn qua các mốc.Đối Với NV hằng ngày các mốc sẽ được tự trừ ra để phù hợp với số lượng mốc đã quy định. Ví Dụ NV hằng ngày random ra loại Nhặt rác ở mốc 3 thì NV hằng ngày sẽ cần hoàn thành 100-50 = 50 bịt rác

- Còn về phần name, description, item của từng loại NV
+ name: để bừa cũng được vì nó không quan trọng
+ description: là chi tiết mà sẽ hiện trong game lưu ý phải có '%s' trong chuỗi vì '%s' sẽ được thay bằng số lượng theo từng mốc
+ item: setting theo item trong database hoặc tự đặt cũng được miễn sau các nhiệm vụ không được trùng tên Item còn về tại sao nó tồn tại sẽ hiểu trong phần Settup để nó đếm số lượng.

- Về Phần quà thì chỉ cần điều chỉnh các mục Config.Events
sẽ có 2 loại Free và Premium mỗi loại đều bao gồm tên item và số lượng nhận được, cần phải đặt giống trong Database. Nếu muốn phần quà là Súng, Xe, hoặc những gì khác ngoài item thì phải tạo thêm Item mới và tạo thêm hàm ESX.RegisterUsableItem trong file "server/useitems.lua" để khi người chơi nhận Item đó trong event thì sẽ sử dụng item đó để nhận được Xe hoặc Súng,...

2/ TRIGGER TÍNH SỐ LƯỢNG HOÀN THÀNH: Với 2 bước
-B1: Vào các file source nghề vào file server phần code additem khi người chơi hoàn thành.
-B2: Thêm dòng code Trigger với cú pháp sau:
TriggerEvent('reward_event:additem', [Player ID] , [Tên Item] , [Số lượng Item])
với Tên Item là trùng với phần Config Nhiệm vụ mà đã đặt, số lượng item sẽ trùng với số lượng theo nghề.

