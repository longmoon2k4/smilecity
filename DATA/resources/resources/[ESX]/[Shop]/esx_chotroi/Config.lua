
-- Add here the items you want to allow to be sold.
-- Images must be included in the img folder in png, jpg or gif format
-- name = name of the item in the database
-- label = name of the item that is shown to the player
-- price_recommended is the recommended price for each item.

Config = {
    positionX   = "50%",
    positionY   = "50%",
    size        = "1.0",
}

-- Configure the public and log WEBHOOK here
WEBHOOKS = {
    -- Here is placed the Webhook of the public discord channel
    PUBLIC_WEBHOOK      = "https://discord.com/api/webhooks/tatwebhooks/1103523357837762651/OU8cqqVidZPkvsch2g8EyqJUjSJLkVlh49G79a2tGY8Np-dlQqkXeE72KjmKgCIhsERB",
    TITLE_ANNOUNCE_ITEM = "Chợ Trời: Mặt hàng mới được đăng bán!",
    COLOR_ANNOUNCE      = 3066993, -- GREEN

    -- Here is the Webhook of logs for admin.
    ADMIN_WEBHOOK       = "https://discord.com/api/webhooks/tatwebhooks/1103523357837762651/OU8cqqVidZPkvsch2g8EyqJUjSJLkVlh49G79a2tGY8Np-dlQqkXeE72KjmKgCIhsERB",
    TITLE_BUY_ITEM      = "Chợ Trời: mặt hàng đã mua",
    COLOR_BUY           = 3066993, -- GREEN
    TITLE_REMOVE_ITEM   = "Chợ Trời: mặt hàng đã bị xóa",
    COLOR_REMOVE        = 15158332, -- red

    -- Put Footer with a name you want and your server image.
    DISCORD_IMAGE       = "",
    DISCORD_FOOTER      = "Trời",
    DISCORD_FOOTER_IMG  = "",


    -- COLORS = {
    --     AQUA                = 1752220,
    --     GREEN               = 3066993,
    --     BLUE                = 3447003,
    --     PURPLE              = 10181046,
    --     GOLD                = 15844367,
    --     ORANGE              = 15105570,
    --     RED                 = 15158332,
    --     GREY                = 9807270,
    --     DARKER_GREY         = 8359053,
    --     NAVY                = 3426654,
    --     DARK_AQUA           = 1146986,
    --     DARK_GREEN          = 2067276,
    --     DARK_BLUE           = 2123412,
    --     DARK_PURPLE         = 7419530,
    --     DARK_GOLD           = 12745742,
    --     DARK_ORANGE         = 11027200,
    --     DARK_RED            = 10038562,
    --     DARK_GREY           = 9936031,
    --     LIGHT_GREY          = 12370112,
    --     DARK_NAVY           = 2899536,
    --     LUMINOUS_VIVID_PINK = 16580705,
    --     DARK_VIVID_PINK     = 12320855
    -- }
}

translate = {
    -- Graphical interface translations
    TR_TITLE            = "Chợ Trời",
    TR_SUBTITLE         = "Giao dịch mua bán",
    TR_OPTIONS_TITLE    = "Thị trường buôn bán",
    TR_OPTIONS_1        = "Các mặt hàng:",
    TR_OPTIONS_2        = "Đăng bán:",
    TR_ANNOUNCES        = "Các mặt hàng",
    TR_SEARCH           = "Tìm kiếm một sản phẩm",
    TR_BY_OWNER         = "Bởi:",
    TR_SIMBOL_MONEY     = "$ ",
    TR_WEIGHT           = "Cân nặng:",
    TR_DISPONIBLE       = "Số lượng:",
    TR_UNITS            = "/ 1 giá tiền",
    TR_TOTAL_PRICE      = "Tổng giá:",
    TR_BUTTON_BUY       = "Mua",
    TR_BUTTON_ANNOUNCE  = "Đăng bán",
    TR_BUTTON_REMOVE    = "Xóa",
    TR_BUTTON_CANCEL    = "Hủy",
    TR_MODAL_TITLE      = "Đăng bán sản phẩm",
    TR_MODAL_ITEM       = "Vật phẩm",
    TR_MODAL_AMOUNT     = "Số lượng:",
    TR_MODAL_PRICE      = "Giá tiền mỗi cái",
    TR_MODAL_ANONYMOUS  = "Ẩn danh",

    -- Notification translations
    TR_DONT_FULL        = "Kho đồ của bạn đã full vật phẩm này",
    TR_DONT_MONEY       = "Bạn không có đủ tiền",
    TR_SUCESS           = "Mua thành công",
    TR_REMOVED_ITEM     = "Đã xóa mục thành công",
    TR_DONT_AMOUNT      = "Không có nhiều mặt hàng để bán",
    TR_NOT_FOUND        = "Sản phẩm đã được bán hoặc không được tìm thấy",
    TR_ADVERTISE_ITEM   = "Đã quảng cáo thành công mặt hàng",
    TR_DONT_AMOUNT2     = "Bạn không có đủ số lượng",    
    TR_DONT_AMOUNT3     = "Bạn đã đăng bán quá nhiều",  
    TR_DONT_SELF        = "Bạn không thể mua mặt hàng của bạn",

    -- Translations of the public Webhook.
    TR_WEBHOOK_OWNER    = "Người bán bời: ",
    TR_WEBHOOK_AMOUNT   = "Số lượng: ",
    TR_WEBHOOK_PRICE    = "Giá tiền: ",

    -- Translations from Webhook to Log admin.
    TR_WEBHOOK_LOG_BUY          = "Mặt hàng đã mua",
    TR_WEBHOOK_LOG_BUY_BY       = "Người bán bởi: ",
    TR_WEBHOOK_LOG_BUY_AMOUNT   = "Số lượng: ",
    TR_WEBHOOK_LOG_BUY_PRICE    = "Giá tiền: ",
    TR_WEBHOOK_LOG_REMOVE       = "Mục đã bị xóa: ",
}