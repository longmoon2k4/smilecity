Config = {}
-- Distance Bau Cua
Config.Distance = vector3(228.39, -877.19, 30.49 - 0.95)
-- Vong set nha cai
Config.Key = 51

Config.MinRate = 3 -- recommend

Config.Object = {
    ['lobster'] = {
        money = 0,
        coords = vector3(228.3, -871.85, 30.51 -0.95),
        label = 'Tôm',
        obj = 'ntl_dicetom'
    },
    ['crab'] = {
        money = 0,
        coords = vector3(230.22, -872.56, 30.51 - 0.95),
        label = 'Cua',
        obj = 'ntl_dicecua'
    },
    ['fish'] = {
        money = 0,
        coords = vector3(232.2, -873.43, 30.51 -0.95),
        label = 'Cá',
        obj = 'ntl_diceca'
    },
    ['deer'] = {
        money = 0,
        coords = vector3(231.23, -875.38, 30.51 -0.95),
        label = 'Hươu',
        obj = 'ntl_dicehuou'
    },
    ['gourd'] = {
        money = 0,
        coords = vector3(229.37, -874.97, 30.51- 0.95),
        label = 'Bầu',
        obj = 'ntl_dicebau'
    },
    ['chicken'] = {
        money = 0,
        coords = vector3(227.68, -874.09, 30.51 - 0.95),
        label = 'Gà',
        obj = 'ntl_dicega'
    }
}

Config.Dice = {
   {'lobster','crab','fish','deer','gourd','chicken'}
}
Config.ObjectInteraction = {
    ['bowl'] = {
        coords = vector3(230.88414, -874.1267, 29.5458),
        nameObject = 'ntl_bowl'
    },
    ['dice1'] = {
        coords = vector3(231.03331, -874.206665, 29.6012516),
        nameObject = ''
    },
    ['dice2'] = {
        coords = vector3(230.7432, -874.206665, 29.6012516),
        nameObject = ''
    },
    ['dice3'] = {
        coords = vector3(230.8889, -873.925049, 29.6012516),
        nameObject = ''
    }
}

Config.DistanceMax = 17
Config.TimeStartNewRound = 15
Config.ShowDiceOnCoords = true
Config.ShowDiceCoords = vector3(229.99, -873.86, 30.51)
Config.MinPriceIsHost = 1000000
Config.MoneyType = 'cash' -- bank/cash
Config.MoneyBewteen = {
    ['min'] = 10000,
    ['max'] = 1000000
}

Config.WhereBet = vector3(234.64, -876.65, 30.49 - 0.95)

Config.Languages = {
    too_far = "Đứng quá xa điểm đặt cược",
    not_yet = "Chưa diễn ra phiên đặt cược",
    some_one_hosted = "Đã có nhà cái",
    refund = "Bạn đã được hoàn lại tiền ",
    error_504 = "ERROR 504",
    receiver_player = "Bạn đã nhận ",
    receiver_host = "Bạn đã nhận ",
    money_host = "$ (Nhà cái)",
    bet_money = 'Số tiền cược phải lớn hơn 0',
    bet_money_min_max = 'Số tiền tối thiểu [10000, 100000]',
    not_enough_money = 'Bạn không có đủ tiền',
    bet_success = 'Đặt cược thành công với số tiền ',
    cant_bet = 'Bạn không thể đặt cược',
    deposit_success = 'Nạp tiền thành công!',
    deposit_fail = 'Nạp tiền không thành công!',
    deposit_min = 'Bạn cần tối thiểu ',
    deposit_min2 = '$ để bắt đầu.' ,
    roundnew = 'Đã bắt đầu round mới'
}
