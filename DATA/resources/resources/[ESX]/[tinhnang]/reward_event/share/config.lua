Config = {}

Config.Events = {
}

--Config.Xp = {
--      100,   500,  1000,  2000,  3000,  4000,  5000,  6000,  7000,  8000, 
--     9500, 11000, 12500, 14000, 15500, 17000, 18500, 20000, 21500, 23000, 
--    25000, 27000, 29000, 31000, 33000, 35000, 37000, 39000, 41000, 43000
--}

Config.Xp = {
    100,   500,  2000,  4000,  6000,  9000,  12500,  15000,  17000,  18000, 
   19500, 21000, 22500, 24000, 25500, 27000, 28500, 30000, 31500, 33000, 
  35000, 37000, 39000, 41000, 43000, 45000, 47000, 49000, 51000, 53000
}

for i = 1,#Config.Xp do 
    Config.Events[i] =  {   
        free = { },
        premium = {} 
    }
end 

Config.Missions = {
    {
        name = 'nhatrac',
        description = "Nhặt %s túi rác",
        item = 'trash',   
        data = {
            { count =  100, point =  200, level = 1  },
            { count =  200, point =  300, level = 2  },
            { count =  400, point =  500, level = 10 },
            { count =  600, point =  750, level = 16 },
            { count =  800, point = 1000, level = 24 },
        }
    },
    {
        name = 'lamga',
        description = "Bắt gà và chế biến %s gà đóng hộp.",
        item = 'slaughtered_chicken',
        data = {
            { count =   100, point =  200, level = 2  },
            { count =  200, point =  300, level = 9  },
            { count =  300, point =  500, level = 17 },
            { count =  450, point =  750, level = 21 },
            { count =  600, point = 1000, level = 28 },
        }
    },
    { 
        name = 'lampiza',
        description = "Giao pizza và giao được %s cái.",
        item = 'pizza',
        data = { 
            { count =   15, point =  200, level = 2  },
            { count =  30, point =  300, level = 7  },
            { count =  45, point =  500, level = 16 },
            { count =  70, point =  750, level = 21 },
            { count =  100, point = 1000, level = 27 },
        }
    },
    {
        name = 'lamgo',
        description = "Chặt gỗ để lấy %s gỗ ép.",
        item = 'cutted_wood',
        data = {
            { count =  100, point =  200, level = 3  },
            { count =  200, point =  300, level = 6  },
            { count =  300, point =  500, level = 13 },
            { count =  450, point =  750, level = 19 },
            { count =  500, point = 1000, level = 25 },
        }
    },
    {
        name = 'lamvai',
        description = "Làm %s Quần áo.",
        item = 'clothe',
        data = {
            { count =    100, point =  200, level = 1  },
            { count =    200, point =  300, level = 4  },
            { count =    300, point =  500, level = 10 },
            { count =    450, point =  750, level = 17 },
            { count =   500, point = 1000, level = 24 },
        }
    },
    {
        name = 'lamdau',
        description = "Chế biến %s xăng",
        item = 'xang',
        data = {
            { count =   20, point =  200, level = 6  },
            { count =   40, point =  300, level = 9  },
            { count =   80, point =  500, level = 18 },
            { count =   90, point =  750, level = 20 },
            { count =  120, point = 1000, level = 26 },
        }
    },
    {
        name = 'chedong',
        description = "Nung đá để chế ra %s Đồng.",
        item = 'copper',
        data = {
            { count =   100, point =  200, level = 3  },
            { count =  200, point =  300, level = 9  },
            { count =  300, point =  500, level = 12 },
            { count =  450, point =  750, level = 20 },
            { count =  500, point = 1000, level = 26 },
        }
    },
    {
        name = 'cauca',
        description = "Câu %s cá.",
        item = 'fish',
        data = {
            { count =   50, point =  200, level = 1  },
            { count =  100, point =  300, level = 7  },
            { count =  180, point =  500, level = 11 },
            { count =  250, point =  750, level = 18 },
            { count =  350, point = 1000, level = 25 },        
        }
    },
    {
        name = 'nungkimcuong',
        description = "Nung %s kim cương.",
        item = 'diamond',
        data = {
            { count =   5, point =  200, level = 3  },
            { count =   10, point =  300, level = 7  },
            { count =   15, point =  500, level = 16 },
            { count =   25, point =  750, level = 19 },
            { count =  40, point = 1000, level = 27 },
        }
    },
    {
        name = 'haicansa',
        description = "Hái được %s Lá Cần Sa.",
        item = 'cannabis',
        data = {
            { count =  100, point =  200, level = 4  },
            { count =  200, point =  300, level = 12 },
            { count =  400, point =  500, level = 16 },
            { count =  600, point =  750, level = 19 },
            { count =  800, point = 1000, level = 28 },
        }
    },
    {
        name = 'haithuocphien',
        description = "Thu hoạch %s Coca.",
        item = 'coca',
        data = {
            { count =  100, point =  200, level = 4  },
            { count =  200, point =  300, level = 11 },
            { count =  400, point =  500, level = 17 },
            { count =  600, point =  750, level = 22 },
            { count =  800, point = 1000, level = 29 },
        }
    },
    {
        name = 'chematuyda',
        description = "Chế ra %s Heroin.",
        item = 'heroin',
        data = {
            { count =   70, point =  200, level = 6  },
            { count =  140, point =  300, level = 13 },
            { count =  240, point =  500, level = 19 },
            { count =  300, point =  750, level = 22 },
            { count =  380, point = 1000, level = 28 },
        }
    }
    
}


Config.Events[1] = {
    free    = {item= "money", count = 10000},
    premium = {item= "money", count = 50000}
}

Config.Events[3] = {
    free    = {item= "gold",  count = 20},
    premium = {item= "gold",  count = 50}
}

Config.Events[5] = {
    free    = {item= "medlangbam",  count = 3},
    premium = {item= "medlangbam",  count = 10}
}

Config.Events[7] = {
    free    = {item= "diamond",  count = 5},
    premium = {item= "diamond",  count = 10}
}

Config.Events[9] = {
    free    = {item= "armor",  count = 5},
    premium = {item= "armor",  count = 10}
}

Config.Events[10] = {
    free    = {},
    premium = {item= "money",  count = 300000}
}

Config.Events[11] = {
    free    = {item= "black_money",  count = 50000},
    premium = {item= "black_money",  count = 100000}
}

Config.Events[12] = {
    free    = {},
    premium = {item= "diamond",  count = 15}
}

Config.Events[13] = {
    free    = {item= "hommayman",  count = 10},
    premium = {item= "hommayman",  count = 30}
}

Config.Events[15] = {
    free    = {},
    premium = {item= "gocaocap",  count = 5}
}

Config.Events[16] = {
    free    = {item= "vaicaocap",  count = 2},
    premium = {item= "vaicaocap",  count = 5}
}

Config.Events[18] = {
    free    = {},
    premium = {item= "hopkim",  count = 5}
}

Config.Events[19] = {
    free    = {item= "daucaocap",  count = 2},
    premium = {item= "daucaocap",  count = 5}
}   

Config.Events[20] = {
    free    = {},
    premium = {item= "bluesky",  count = 10}
}

Config.Events[21] = {
    free    = {item= "black_money",  count = 150000},
    premium = {item= "black_money",  count = 300000}
}

Config.Events[22] = {
    free    = {},
    premium = {item= "diamond",  count = 20}
}

Config.Events[23] = {
    free    = {item= "gacaocap",  count = 2},
    premium = {item= "gacaocap",  count = 5}
}

Config.Events[25] = {
    free    = {item= "cainit",  count = 10},
    premium = {item= "xecat",  count = 1}
}

Config.Events[26] = {
    free    = {item= "chicken2",  count = 1},
    premium = {item= "chicken3",  count = 1}
}

Config.Events[27] = {
    free    = {item= "hom_skin_ig",  count = 5},
    premium = {item= "hom_skin_donate",  count = 5}
}

Config.Events[28] = {
    free    = {item= "badge1",  count = 2},
    premium = {item= "badge2",  count = 1}
}

Config.Events[29] = {
    free    = {},
    premium = {item= "WEAPON_LIGHTSABER_YELLOW",  count = 1}
}

Config.Events[30] = {
    free    = {item= "badge2"     ,  count = 1},
    premium = {item= "badge3",  count = 1}
}


