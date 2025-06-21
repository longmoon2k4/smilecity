local labels = {
  ['en'] = {
    ['Entry']       = '<FONT FACE="arial font">Mở',
    ['Exit']        = "Thoát",
    ['Garage']      = "Garage",
    ['Wardrobe']    = '<FONT FACE="arial font">Tủ Quần Áo',
    ['Inventory']   = '<FONT FACE="arial font">Tủ Đồ',
    ['InventoryLocation']   = '<FONT FACE="arial font">Tủ Đồ',

    ['LeavingHouse']      = '<FONT FACE="arial font">Ra Khỏi Nhà',

    ['EquipOutfit']       = "Trang bị Outfit",
    ['DeleteOutfit']      = "Xóa trang phục",
    ['LeftHouse']         = "Bạn rời khỏi nhà và bỏ dở hành động.",

    ['AccessHouseMenu']   = "Truy cập menu nhà",

    ['InteractDrawText']  = "["..Config.TextColors[Config.MarkerSelection].."E~s~] ",
    ['InteractHelpText']  = "~INPUT_PICKUP~ ",

    ['AcceptDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."G~s~] ",
    ['AcceptHelpText']    = "~INPUT_DETONATE~ ",

    ['FurniDrawText']     = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",
    ['CancelDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",

    ['VehicleStored']     = "<FONT FACE='arial font'>Phương tiện được lưu trữ",
    ['CantStoreVehicle']  = "<FONT FACE='arial font'>Bạn không thể cất chiếc xe này",

    ['HouseNotOwned']     = "<FONT FACE='arial font'>Bạn không sở hữu ngôi nhà này",
    ['InvitedInside']     = "<FONT FACE='arial font'>Chấp nhận lời mời đến nhà",
    ['MovedTooFar']       = "<FONT FACE='arial font'>Bạn đã di chuyển quá xa khỏi cửa",
    ['KnockAtDoor']       = "<FONT FACE='arial font'>Ai đó đang gõ cửa nhà bạn",

    ['TrackMessage']      = "<FONT FACE='arial font'>Theo dõi tin nhắn",

    ['Unlocked']          = "<FONT FACE='arial font'>Nhà đã mở khóa",
    ['Locked']            = "<FONT FACE='arial font'>Nhà bị khóa",

    ['WardrobeSet']       = "<FONT FACE='arial font'>Set tủ quần áo",
    ['InventorySet']      = "<FONT FACE='arial font'>Set tủ đồ",

    ['ToggleFurni']       = "<FONT FACE='arial font'>Chuyển đổi giao diện người dùng đồ nội thất",

    ['GivingKeys']        = "<FONT FACE='arial font'>Trao chìa khóa cho người chơi",
    ['TakingKeys']        = "<FONT FACE='arial font'>Lấy chìa khóa từ người chơi",

    ['GarageSet']         = "<FONT FACE='arial font'>Đặt vị trí nhà để xe",
    ['GarageTooFar']      = "<FONT FACE='arial font'>Nhà để xe quá xa",

    ['PurchasedHouse']    = "<FONT FACE='arial font'>Bạn đã mang ngôi nhà với giá $%d",
    ['CantAffordHouse']   = "<FONT FACE='arial font'>Bạn không đủ tiền mua căn nhà này",

    ['MortgagedHouse']    = "<FONT FACE='arial font'>Bạn đã thế chấp căn nhà cho $%d",

    ['NoLockpick']        = "<FONT FACE='arial font'>Bạn không có khóa bấm",
    ['LockpickFailed']    = "<FONT FACE='arial font'>Bạn không bẻ khóa được",
    ['LockpickSuccess']   = "<FONT FACE='arial font'>Bạn đã bẻ khóa thành công",

    ['NotifyRobbery']     = "<FONT FACE='arial font'>Ai đó đang cố gắng cướp một ngôi nhà tại %s",

    ['ProgressLockpicking'] = "Khóa cửa",

    ['InvalidShell']        = "<FONT FACE='arial font'>Vỏ nội bộ không hợp lệ: %s, vui lòng báo cáo cho chủ sở hữu máy chủ của bạn.",
    ['ShellNotLoaded']      = "<FONT FACE='arial font'>Shell sẽ không tải: %s, vui lòng báo cáo cho chủ sở hữu máy chủ của bạn.",
    ['BrokenOffset']        = "<FONT FACE='arial font'>Phần bù được nhầm lẫn với nhà có ID %s, vui lòng báo cáo cho chủ sở hữu máy chủ của bạn.",

    ['UpgradeHouse']        = "<FONT FACE='arial font'>Nâng cấp nhà lên: %s",
    ['CantAffordUpgrade']   = "<FONT FACE='arial font'>Bạn không thể mua bản nâng cấp này",

    ['SetSalePrice']        = "Đặt giá ưu đãi",
    ['InvalidAmount']       = "<FONT FACE='arial font'>Số tiền đã nhập không hợp lệ",
    ['InvalidSale']         = "<FONT FACE='arial font'>Bạn không thể bán một ngôi nhà mà bạn vẫn nợ tiền",
    ['InvalidMoney']        = "<FONT FACE='arial font'>Bạn không có đủ tiền",

    ['EvictingTenants']     = "<FONT FACE='arial font'>Trục xuất người thuê nhà",

    ['NoOutfits']           = "<FONT FACE='arial font'>Bạn không có bất kỳ trang phục nào được lưu trữ",

    ['EnterHouse']          = "Vào nhà",
    ['KnockHouse']          = "Knock On Door",
    ['RaidHouse']           = "Nhà đột kích",
    ['BreakIn']             = "Ngắt lời",
    ['InviteInside']        = "Mời vào trong",
    ['HouseKeys']           = "Chìa khóa nhà",
    ['UpgradeHouse2']       = "Nâng cấp nhà",
    ['UpgradeShell']        = "Nâng cấp Shell",
    ['SellHouse']           = "Bán nhà",
    ['FurniUI']             = "Nội thất",
    ['SetWardrobe']         = "<FONT FACE='arial font'>Set tủ quần áo",
    ['SetInventory']        = "<FONT FACE='arial font'>Set tủ đồ",
    ['SetGarage']           = "<FONT FACE='arial font'>Set Garage",
    ['LockDoor']            = "Khóa nhà",
    ['UnlockDoor']          = "Mở khóa nhà",
    ['LeaveHouse']          = "Rời khỏi nhà",
    ['Mortgage']            = "Thế chấp",
    ['Buy']                 = "Mua",
    ['View']                = "Xem nhà",
    ['Upgrades']            = "Bản nâng cấp",
    ['MoveGarage']          = "Di chuyển Garage",

    ['GiveKeys']            = "Đưa chìa khóa",
    ['TakeKeys']            = "Lấy chìa khóa",

    ['MyHouse']             = "Nhà Của Tôi",
    ['PlayerHouse']         = "Nhà Người Chơi",
    ['EmptyHouse']          = "Nhà Vô Chủ",

    ['NoUpgrades']          = "<FONT FACE='arial font'>Không có bản nâng cấp nào",
    ['NoVehicles']          = "<FONT FACE='arial font'>Không có xe",
    ['NothingToDisplay']    = "<FONT FACE='arial font'>Chẳng có gì để trưng bày",

    ['ConfirmSale']         = "Có, bán nhà của tôi",
    ['CancelSale']          = "Không, đừng bán nhà của tôi",
    ['SellingHouse']        = "Bán nhà ($%d)",

    ['MoneyOwed']           = "Chủ nợ: $%s",
    ['LastRepayment']       = "Lần trả nợ cuối cùng: %s",
    ['PayMortgage']         = "Thanh toán thế chấp",
    ['MortgageInfo']        = "Thông tin thế chấp",

    ['SetEntry']            = "Đặt mục nhập",
    ['CancelGarage']        = "Cancel Garage",
    ['UseInterior']         = "Sử dụng nội thất",
    ['UseShell']            = "Sử dụng Shell",
    ['InteriorType']        = "Đặt loại nội thất",
    ['SetInterior']         = "Chọn nội thất hiện tại",
    ['SelectDefaultShell']  = "Chọn vỏ nhà mặc định",
    ['ToggleShells']        = "Chuyển đổi các vỏ có sẵn cho thuộc tính này",
    ['AvailableShells']     = "Vỏ có sẵn",
    ['Enabled']             = "~g~ĐÃ BẬT~s~",
    ['Disabled']            = "~r~ĐÃ TẮT~s~",
    ['NewDoor']             = "Thêm cửa mới",
    ['Done']                = "Làm xong",
    ['Doors']               = "Cửa ra vào",
    ['Interior']            = "Nội địa",

    ['CreationComplete']    = "<FONT FACE='arial font'>Hoàn thành tạo nhà.",

    ['HousePurchased'] = "Ngôi nhà của bạn đã được mua với giá $%d",
    ['HouseEarning']   = ", bạn kiếm được $%d từ việc bán hàng."
  }
}

Labels = setmetatable({},{
  __index = function(self,k)
    if Config and Config.Locale and labels[Config.Locale] then
      if labels[Config.Locale][k] then
        return labels[Config.Locale][k]
      else
        return string.format("UNKNOWN LABEL: %s",tostring(k))
      end
    elseif labels['en'] then
      if labels[Config.Locale][k] then
        return labels[Config.Locale][k]
      else
        return string.format("UNKNOWN LABEL: %s",tostring(k))
      end
    else
      return string.format("UNKNOWN LABEL: %s",tostring(k))
    end
  end
})

