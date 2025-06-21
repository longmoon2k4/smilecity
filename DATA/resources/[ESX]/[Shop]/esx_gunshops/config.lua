Config = {}
Config.price_format = "~r~$%d" -- %d <- price
Config.cam_coords = vector3(21.988, -1107.593, 30.426)
Config.cam_point_coords = vector3(22.549, -1106.119, 29.789) -- placeholder <- the camera will point at the floating weapon once it spawns
Config.weapon_coords = vector3(22.549, -1106.119, 30.0) -- the floating weapon coords
Config.Xp = 2099
Config.marker = {
    {
        pos = vector3(21.86, -1106.684, 28.797),
        size = vector3(1,1,0.2),
        color = {r = 247, g = 65, b = 71, a = 150},
        cam_coords = vector3(21.988, -1107.593, 30.426),
        cam_point_coords = vector3(22.549, -1106.119, 29.789),
        weapon_coords = vector3(22.549, -1106.119, 30.0)
    },
    {
        pos = vector3(1693.95, 3759.62, 33.98),
        size = vector3(1,1,0.2),
        color = {r = 247, g = 65, b = 71, a = 150},
        cam_coords = vector3(1693.95, 3759.62, 35.71),
        cam_point_coords = vector3(1692.89, 3760.66, 34.9),
        weapon_coords = vector3(1692.89, 3760.66, 34.9)
    },
    {
        pos = vector3(-1117.43, 2698.39, 17.65),
        size = vector3(1,1,0.2),
        color = {r = 247, g = 65, b = 71, a = 150},
        cam_coords = vector3(-1117.62, 2698.67, 19.05),
        cam_point_coords = vector3(-1118.33, 2699.43, 19.0),
        weapon_coords = vector3(-1118.33, 2699.43, 19.0)
    },
    {
        pos = vector3(-329.89, 6083.66, 30.65),
        size = vector3(1,1,0.2),
        color = {r = 247, g = 65, b = 71, a = 150},
        cam_coords = vector3(-330.04, 6083.8, 31.95),
        cam_point_coords = vector3(-330.95, 6084.69, 31.95),
        weapon_coords = vector3(-330.95, 6084.69, 31.95)
    }

}
Config.lang = {
    owned = "Đã sở hữu",
    equipped = "Đã trang bị",
    yes = "Có",
    no = "Không",
    back = "Quay lại",
    attachments_upgrades = "Nâng cấp",
    tints = "Màu",
    free = "Free",
    ammo = "Đạn (%d)", -- %d <- ammo count
    not_enough_money = "~r~Bạn không đủ tiền!",
    marker_text = "Bấm [~g~E~s~] để mở cửa hàng súng"
}
Config.menu = {
    main = {
        title = "Cửa hàng Súng",
        subtitle = "Vũ khí có sẵn",
        x = 0.76,
        y = 0.25,
        titlecolor = {255,255,255,255}, -- r,g,b,a
        backcolor = {247,65,71,255} -- r,g,b,a
    },
    weapon = {
        title = "%s", -- %s <- weapon label
        subtitle = "Phụ kiện có sẵn", -- %s <- weapon label
        x = 0.76,
        y = 0.25,
        titlecolor = {255,255,255,255}, -- r,g,b,a
        backcolor = {247,65,71,255} -- r,g,b,a
    }
}
--[[

Add your own weapons:
https://www.se7ensins.com/forums/threads/weapon-and-explosion-hashes-list.1045035/
https://wiki.rage.mp/index.php?title=Weapons_Components
https://wiki.gtanet.work/index.php?title=Weapons_Tints

--]]
Config.weapons = {
    -- {
    --     weapon = "WEAPON_KNIFE",
    --     label = "Knife",
    --     price = 100000,
    -- },
    -- {
    --     weapon = "WEAPON_MACHETE",
    --     label = "Machete",
    --     price = 100000,
    -- },
    -- {
    --     weapon = "WEAPON_BAT",
    --     label = "Gậy bóng chày",
    --     price = 100000,
    -- },
    -------------------------------------------------------------------------------------------- Pistol ------------------------------------------------------------------------------------
    {
        weapon = "WEAPON_PISTOL",
        label = "Pistol",
        price = false,
        can_buy_ammo = true,
        ammo_price = 10,
        ammo_count = 30,
        upgrades = {
            -- {
            --     label = "Băng đạn thường",
            --     hash = "COMPONENT_PISTOL_CLIP_01",
            --     name = "clip_default_pistol",
            --     price = 0
            -- },
            {
                label = "Băng đạn thêm",
                hash = "COMPONENT_PISTOL_CLIP_02",
                name = "at_clip_extended_pistol",
                price = 50000
            },
            -- {
            --     label = "Băng đạn lớn",
            --     hash = "COMPONENT_SMG_CLIP_03",
            --     name = "clip_extended",
            --     price = 2000
            -- },
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_PI_FLSH",
                name = "at_flashlight",
                price = 1000
            },
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_PI_SUPP_02",
                name = "at_suppressor_light",
                price = 1000
            },
            -- {
            --     label = "Ống ngắm",
            --     hash = "COMPONENT_AT_SCOPE_MACRO_02",
            --     name = "suppressor",
            --     price = 1000
            -- }
        },
        tints = {
            {
                label = "Default tint",
                index = 0,
                price = 0
            },
            {
                label = "Green tint",
                index = 1,
                price = 100000
            },
            {
                label = "Gold tint",
                index = 2,
                price = 100000
            },
            {
                label = "Pink tint",
                index = 3,
                price = 100000
            },
            {
                label = "Camouflage tint",
                index = 4,
                price = 100000
            },
            {
                label = "Blue tint",
                index = 5,
                price = 100000
            },
            {
                label = "Orange tint",
                index = 6,
                price = 100000
            },
            {
                label = "Platinum tint",
                index = 7,
                price = 100000
            }
        }
    },
    -- {
    --     weapon = "WEAPON_COMBATPISTOL",
    --     label = "Combat Pistol",
    --     price = false,
    --     can_buy_ammo = false,
    --     ammo_price = 10,
    --     ammo_count = 30,
    --     upgrades = {
    --         {
    --             label = "Băng đạn thường",
    --             hash = "COMPONENT_COMBATPISTOL_CLIP_01",
    --             name = "clip_default",
    --             price = 0
    --         },
    --         {
    --             label = "Băng đạn thêm",
    --             hash = "COMPONENT_COMBATPISTOL_CLIP_02",
    --             name = "clip_extended",
    --             price = 1000
    --         },
    --         {
    --             label = "Đèn pin",
    --             hash = "COMPONENT_AT_PI_FLSH",
    --             name = "flashlight",
    --             price = 1000
    --         },
    --         {
    --             label = "Giảm thanh",
    --             hash = "COMPONENT_AT_PI_SUPP",
    --             name = "suppressor",
    --             price = 1000
    --         }
    --     },
    --     tints = {
    --         {
    --             label = "Default tint",
    --             index = 0,
    --             price = 0
    --         },
    --         {
    --             label = "Green tint",
    --             index = 1,
    --             price = 5000000
    --         },
    --         {
    --             label = "Gold tint",
    --             index = 2,
    --             price = 5000000
    --         },
    --         {
    --             label = "Pink tint",
    --             index = 3,
    --             price = 5000000
    --         },
    --         {
    --             label = "Army tint",
    --             index = 4,
    --             price = 5000000
    --         },
    --         {
    --             label = "LSPD tint",
    --             index = 5,
    --             price = 5000000
    --         },
    --         {
    --             label = "Platinum tint",
    --             index = 7,
    --             price = 5000000
    --         }
    --     }
    -- },
    {
        weapon = "WEAPON_APPISTOL",
        label = "AP Pistol",
        price = false,
        can_buy_ammo = true,
        ammo_price = 1000,
        ammo_count = 60,
        upgrades = {
            -- {
            --     label = "Băng đạn thường",
            --     hash = "COMPONENT_APPISTOL_CLIP_01",
            --     name = "clip_default",
            --     price = 0
            -- },
            {
                label = "Băng đạn thêm",
                hash = "COMPONENT_APPISTOL_CLIP_02",
                name = "at_clip_extended_pistol",
                price = 50000
            },
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_PI_FLSH",
                name = "at_flashlight",
                price = 1000
            },
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_PI_SUPP",
                name = "at_suppressor_light",
                price = 1000
            }
        },
        tints = {
            {
                label = "Default tint",
                index = 0,
                price = 0
            },
            {
                label = "Green tint",
                index = 1,
                price = 5000000
            },
            {
                label = "Gold tint",
                index = 2,
                price = 5000000
            },
            {
                label = "Pink tint",
                index = 3,
                price = 5000000
            },
            {
                label = "Platinum tint",
                index = 7,
                price = 5000000
            }
        }
    },
    -- {
    --     weapon = "WEAPON_PISTOL50",
    --     label = "Pistol .50",
    --     price = false,
    --     can_buy_ammo = true,
    --     ammo_price = 2000,
    --     ammo_count = 200,
    --     upgrades = {
    --         {
    --             label = "Băng đạn thường",
    --             hash = "COMPONENT_PISTOL50_CLIP_01",
    --             name = "clip_default",
    --             price = 0
    --         },
    --         {
    --             label = "Băng đạn thêm",
    --             hash = "COMPONENT_PISTOL50_CLIP_02",
    --             name = "clip_extended",
    --             price = 1000
    --         },
    --         {
    --             label = "Đèn pin",
    --             hash = "COMPONENT_AT_PI_FLSH",
    --             name = "flashlight",
    --             price = 1000
    --         },
    --         {
    --             label = "Giảm thanh",
    --             hash = "COMPONENT_AT_AR_SUPP_02",
    --             name = "suppressor",
    --             price = 1000
    --         }
    --     },
    --     tints = {
    --         {
    --             label = "Default tint",
    --             index = 0,
    --             price = 0
    --         },
    --         {
    --             label = "Green tint",
    --             index = 1,
    --             price = 5000000
    --         },
    --         {
    --             label = "Gold tint",
    --             index = 2,
    --             price = 5000000
    --         },
    --         {
    --             label = "Pink tint",
    --             index = 3,
    --             price = 5000000
    --         },
    --         {
    --             label = "Platinum tint",
    --             index = 7,
    --             price = 5000000
    --         }
    --     }
    -- },
    ------------------------------------------------------------------------------------------------------ SMG ---------------------------------------------------------------------------
    {
        weapon = "WEAPON_MICROSMG",
        label = "Uzi SMG",
        price = false,
        can_buy_ammo = true,
        ammo_price = 1000,
        ammo_count = 60,
        upgrades = {
            -- {
            --     label = "Băng đạn thường",
            --     hash = "COMPONENT_MICROSMG_CLIP_01",
            --     name = "clip_default_microsmg",
            --     price = 0
            -- },
            {
                label = "Băng đạn thêm",
                hash = "COMPONENT_MICROSMG_CLIP_02",
                name = "at_clip_extended_smg",
                price = 200000
            },

            {
                label = "Ống ngắm",
                hash = "COMPONENT_AT_SCOPE_MACRO",
                name = "at_scope_macro",
                price = 1000
            },
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP_02",
                name = "at_suppressor_heavy",
                price = 1000
            }
        },
        tints = {
            {
                label = "Default tint",
                index = 0,
                price = 0
            },
            {
                label = "Green tint",
                index = 1,
                price = 2000000
            },
            {
                label = "Gold tint",
                index = 2,
                price = 2000000
            },
            {
                label = "Pink tint",
                index = 3,
                price = 2000000
            },
            {
                label = "Army tint",
                index = 4,
                price = 2000000
            },
            {
                label = "LSPD tint",
                index = 5,
                price = 2000000
            },
            {
                label = "Platinum tint",
                index = 7,
                price = 2000000
            }
        }
    },
    {
        weapon = "WEAPON_SMG",
        label = "SMG",
        price = false,
        can_buy_ammo = true,
        ammo_price = 1000,
        ammo_count = 60,
        upgrades = {
            -- {
            --     label = "Băng đạn thường",
            --     hash = "COMPONENT_MICROSMG_CLIP_01",
            --     name = "clip_default_microsmg",
            --     price = 0
            -- },
            {
                label = "Băng đạn thêm",
                hash = "COMPONENT_SMG_CLIP_02",
                name = "at_clip_extended_smg",
                price = 200000
            },

            {
                label = "Ống ngắm",
                hash = "COMPONENT_AT_SCOPE_MACRO_02",
                name = "at_scope_macro",
                price = 1000
            },
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_PI_SUPP",
                name = "at_suppressor_heavy",
                price = 1000
            }
        },
        tints = {
            {
                label = "Default tint",
                index = 0,
                price = 0
            },
            {
                label = "Green tint",
                index = 1,
                price = 2000000
            },
            {
                label = "Gold tint",
                index = 2,
                price = 2000000
            },
            {
                label = "Pink tint",
                index = 3,
                price = 2000000
            },
            {
                label = "Army tint",
                index = 4,
                price = 2000000
            },
            {
                label = "LSPD tint",
                index = 5,
                price = 2000000
            },
            {
                label = "Platinum tint",
                index = 7,
                price = 2000000
            }
        }
    },
    {
        weapon = "WEAPON_ASSAULTSMG",
        label = "Assault SMG",
        price = false,
        can_buy_ammo = true,
        ammo_price = 10,
        ammo_count = 30,
        upgrades = {
            -- {
            --     label = "Băng đạn thường",
            --     hash = "COMPONENT_ASSAULTSMG_CLIP_01",
            --     name = "clip_default",
            --     price = 0
            -- },
            {
                label = "Băng đạn thêm",
                hash = "COMPONENT_ASSAULTSMG_CLIP_02",
                name = "at_clip_extended_smg",
                price = 1000
            },
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                name = "at_flashlight",
                price = 1000
            },
            {
                label = "Ống ngắm",
                hash = "COMPONENT_AT_SCOPE_MACRO",
                name = "at_scope_macro",
                price = 1000
            },
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP_02",
                name = "at_suppressor_heavy",
                price = 1000
            }
        },
        tints = {
            {
                label = "Default tint",
                index = 0,
                price = 0
            },
            {
                label = "Green tint",
                index = 1,
                price = 5000000
            },
            {
                label = "Gold tint",
                index = 2,
                price = 5000000
            },
            {
                label = "Pink tint",
                index = 3,
                price = 5000000
            },
            {
                label = "Army tint",
                index = 4,
                price = 5000000
            },
            {
                label = "LSPD tint",
                index = 5,
                price = 5000000
            },
            {
                label = "Platinum tint",
                index = 7,
                price = 5000000
            }
        }
    },
    {
        weapon = "WEAPON_COMBATPDW",
        label = "Combat PDW",
        price = false,
        can_buy_ammo = true,
        ammo_price = 1000,
        ammo_count = 60,
        upgrades = {
            -- {
            --     label = "Băng đạn thường",
            --     hash = "COMPONENT_ASSAULTSMG_CLIP_01",
            --     name = "clip_default",
            --     price = 0
            -- },
            {
                label = "Băng đạn thêm",
                hash = "COMPONENT_COMBATPDW_CLIP_02",
                name = "at_clip_extended_smg",
                price = 100000
            },
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                name = "at_flashlight",
                price = 1000
            },
            {
                label = "Ống ngắm",
                hash = "COMPONENT_AT_SCOPE_SMALL",
                name = "at_scope_small",
                price = 1000
            },
            {
                label = "Tay cầm",
                hash = "COMPONENT_AT_AR_AFGRIP",
                name = "at_grip",
                price = 1000
            }
        },
        tints = {
            {
                label = "Default tint",
                index = 0,
                price = 0
            },
            {
                label = "Green tint",
                index = 1,
                price = 5000000
            },
            {
                label = "Gold tint",
                index = 2,
                price = 5000000
            },
            {
                label = "Pink tint",
                index = 3,
                price = 5000000
            },
            {
                label = "Army tint",
                index = 4,
                price = 5000000
            },
            {
                label = "LSPD tint",
                index = 5,
                price = 5000000
            },
            {
                label = "Platinum tint",
                index = 7,
                price = 5000000
            }
        }
    },
    ------------------------------------------------------------------------------------------------------------- Shotgun ----------------------------------------------------------------------
   


    {
        weapon = "WEAPON_COMBATSHOTGUN",
        label = "combatshotgun",
        price = false,
        can_buy_ammo = true,
        ammo_price = 5000,
        ammo_count = 40,
        upgrades = { 
            {
                label = "giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP",
                name = "at_suppressor_heavy",
                price = 50000
            },
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                name = "at_flashlight",
                price = 1000
            },

        },
        tints = {
            {
                label = "Default tint",
                index = 0,
                price = 0
            },
            {
                label = "Green tint",
                index = 1,
                price = 2000000
            },
            {
                label = "Gold tint",
                index = 2,
                price = 2000000
            },
            {
                label = "Pink tint",
                index = 3,
                price = 2000000
            },
            {
                label = "Camouflage tint",
                index = 4,
                price = 2000000
            },
            {
                label = "Blue tint",
                index = 5,
                price = 2000000
            },
            {
                label = "Orange tint",
                index = 6,
                price = 2000000
            },
            {
                label = "Platinum tint",
                index = 7,
                price = 2000000
            }
        }
    },
    {
        weapon = "WEAPON_ASSAULTSHOTGUN",
        label = "Shotgun liên thanh",
        price = false,
        can_buy_ammo = true,
        ammo_price = 1000,
        ammo_count = 40,
        upgrades = { 
            -- {
            --     label = "Băng đạn mặc định",
            --     hash = "COMPONENT_ASSAULTSHOTGUN_CLIP_01",
            --     name = "clip_default_assg",
            --     price = 0
            -- },
            {
                label = "Băng đạn thêm",
                hash = "COMPONENT_ASSAULTSHOTGUN_CLIP_02",
                name = "at_clip_extended_shotgun",
                price = 500000
            },
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                name = "at_flashlight",
                price = 1000
            },
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP",
                name = "at_suppressor_heavy",
                price = 1000
            }, 
            {
                label = "Tay cầm",
                hash = "COMPONENT_AT_AR_AFGRIP",
                name = "at_grip",
                price = 100000
            },

        },
        tints = {
            {
                label = "Default tint",
                index = 0,
                price = 0
            },
            {
                label = "Green tint",
                index = 1,
                price = 2000000
            },
            {
                label = "Gold tint",
                index = 2,
                price = 2000000
            },
            {
                label = "Pink tint",
                index = 3,
                price = 2000000
            },
            {
                label = "Camouflage tint",
                index = 4,
                price = 2000000
            },
            {
                label = "Blue tint",
                index = 5,
                price = 2000000
            },
            {
                label = "Orange tint",
                index = 6,
                price = 2000000
            },
            {
                label = "Platinum tint",
                index = 7,
                price = 2000000
            }
        }
    },

    {
        weapon = "WEAPON_PUMPSHOTGUN",
        label = "PUMP SHOTGUN",
        price = false,
        can_buy_ammo = true,
        ammo_price = 10000,
        ammo_count = 300,
        upgrades = { 
            
           
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                name = "at_flashlight",
                price = 1000
            },
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_SR_SUPP",
                name = "at_suppressor_heavy",
                price = 1000
            }, 
           

        },
        tints = {
            {
                label = "Default tint",
                index = 0,
                price = 0
            },
            {
                label = "Green tint",
                index = 1,
                price = 2000000
            },
            {
                label = "Gold tint",
                index = 2,
                price = 2000000
            },
            {
                label = "Pink tint",
                index = 3,
                price = 2000000
            },
            {
                label = "Camouflage tint",
                index = 4,
                price = 2000000
            },
            {
                label = "Blue tint",
                index = 5,
                price = 2000000
            },
            {
                label = "Orange tint",
                index = 6,
                price = 2000000
            },
            {
                label = "Platinum tint",
                index = 7,
                price = 2000000
            }
        }
    },
    ------------------------------------------------------------------------------------------------------------- AR ----------------------------------------------------------------------
    {
        weapon = "WEAPON_SPECIALCARBINE",
        label = "Special Carbine",
        price = false,
        can_buy_ammo = true,
        ammo_price = 1000,
        ammo_count = 60,
        upgrades = {
            -- {
            --     label = "Băng đạn thường",
            --     hash = "COMPONENT_SPECIALCARBINE_CLIP_01",
            --     name = "clip_default",
            --     price = 0
            -- },
            {
                label = "Băng đạn thêm",
                hash = "COMPONENT_SPECIALCARBINE_CLIP_02",
                name = "at_clip_extended_rifle",
                price = 200000
            },
            {
                label = "Băng đạn to",
                hash = "COMPONENT_SPECIALCARBINE_CLIP_03",
                name = "at_clip_drum_rifle",
                price = 2000000
            },
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                name = "at_flashlight",
                price = 1000
            },
            {
                label = "Ống ngắm",
                hash = "COMPONENT_AT_SCOPE_MEDIUM",
                name = "at_scope_medium",
                price = 1000
            },
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP_02",
                name = "at_suppressor_heavy",
                price = 1000
            },
            {
                label = "Tay cầm",
                hash = "COMPONENT_AT_AR_AFGRIP",
                name = "at_grip",
                price = 1000
            }
        },
        tints = {
            {
                label = "Default tint",
                index = 0,
                price = 0
            },
            {
                label = "Green tint",
                index = 1,
                price = 5000000
            },
            {
                label = "Gold tint",
                index = 2,
                price = 5000000
            },
            {
                label = "Pink tint",
                index = 3,
                price = 5000000
            },
            {
                label = "Platinum tint",
                index = 7,
                price = 5000000
            }
        }
    },

    {
        weapon = "WEAPON_SPECIALCARBINE_MK2",
        label = "Special Carbine MK2",
        price = false,
        can_buy_ammo = true,
        ammo_price = 1000,
        ammo_count = 60,
        upgrades = {
            -- {
            --     label = "Băng đạn thường",
            --     hash = "COMPONENT_SPECIALCARBINE_CLIP_01",
            --     name = "clip_default",
            --     price = 0
            -- },
            {
                label = "Băng đạn thêm",
                hash = "COMPONENT_SPECIALCARBINE_MK2_CLIP_02",
                name = "at_clip_extended_rifle",
                price = 200000
            },
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                name = "at_flashlight",
                price = 1000
            },
            {
                label = "Ống ngắm",
                hash = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
                name = "at_scope_medium",
                price = 1000
            },
            {
                label = "Ống ngắm nhỏ",
                hash = "COMPONENT_AT_SCOPE_MACRO_MK2",
                name = "at_scope_macro",
                price = 1000
            },
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP_02",
                name = "at_suppressor_heavy",
                price = 1000
            },
            {
                label = "Tay cầm",
                hash = "COMPONENT_AT_AR_AFGRIP_02",
                name = "at_grip",
                price = 1000
            }
        },
    },


   
    {
        weapon = "WEAPON_CARBINERIFLE_MK2",
        label = "Carbine Rifle MK2",
        price = false,
        can_buy_ammo = true,
        ammo_price = 1000,
        ammo_count = 60,
        upgrades = {
            {
                label = "Băng đạn thường",
                hash = "COMPONENT_CARBINERIFLE_MK2_CLIP_01",
                name = "clip_default",
                price = 0
            },
            {
                label = "Băng đạn thêm",
                hash = "COMPONENT_CARBINERIFLE_MK2_CLIP_02",
                name = "clip_extended",
                price = 1000
            },
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                name = "flashlight",
                price = 1000
            },

            {
                
                label = "Ống ngắm",
                hash = "COMPONENT_AT_SCOPE_MACRO_MK2",
                name = "scope",
                price = 1000
            },
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP",
                name = "suppressor",
                price = 1000
            },
            {
                label = "Tay cầm",
                hash = "COMPONENT_AT_AR_AFGRIP_02",
                name = "grip",
                price = 1000
            }
        },
        tints = {
            {
                label = "Default tint",
                index = 0,
                price = 0
            },
            {
                label = "Green tint",
                index = 1,
                price = 5000000
            },
            {
                label = "Gold tint",
                index = 2,
                price = 5000000
            },
            {
                label = "Pink tint",
                index = 3,
                price = 5000000
            },
            {
                label = "Platinum tint",
                index = 7,
                price = 5000000
            }
        }
    },
    {
        weapon = "WEAPON_ASSAULTRIFLE",
        label = "Assault Rifle",
        price = false,
        can_buy_ammo = true,
        ammo_price = 1000,
        ammo_count = 60,
        upgrades = {
            -- {
            --     label = "Băng đạn thường",
            --     hash = "COMPONENT_ASSAULTRIFLE_CLIP_01",
            --     name = "clip_default_assaultrifle",
            --     price = 0
            -- },
            {
                label = "Băng đạn thêm",
                hash = "COMPONENT_ASSAULTRIFLE_CLIP_02",
                name = "at_clip_extended_rifle",
                price = 300000
            },
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                name = "at_flashlight",
                price = 1000
            },
            {
                label = "Ống ngắm",
                hash = "COMPONENT_AT_SCOPE_MACRO",
                name = "at_scope_macro",
                price = 50000
            },
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP_02",
                name = "at_suppressor_heavy",
                price = 150000
            },
            {
                label = "Tay cầm",
                hash = "COMPONENT_AT_AR_AFGRIP",
                name = "at_grip",
                price = 100000
            },
        },
        tints = {
            {
                label = "Default tint",
                index = 0,
                price = 0
            },
            {
                label = "Green tint",
                index = 1,
                price = 2000000
            },
            {
                label = "Gold tint",
                index = 2,
                price = 2000000
            },
            {
                label = "Pink tint",
                index = 3,
                price = 2000000
            },
            {
                label = "Camouflage tint",
                index = 4,
                price = 2000000
            },
            {
                label = "Blue tint",
                index = 5,
                price = 2000000
            },
            {
                label = "Orange tint",
                index = 6,
                price = 2000000
            },
            {
                label = "Platinum tint",
                index = 7,
                price = 2000000
            }
        }
    },

    {
        weapon = "WEAPON_COMPACTRIFLE",
        label = "AK-cụt",
        price = false,
        can_buy_ammo = true,
        ammo_price = 1000,
        ammo_count = 60,
        upgrades = {
            -- {
            --     label = "Băng đạn thường",
            --     hash = "COMPONENT_ASSAULTRIFLE_CLIP_01",
            --     name = "clip_default_assaultrifle",
            --     price = 0
            -- },
            {
                label = "Băng đạn thêm",
                hash = "COMPONENT_COMPACTRIFLE_CLIP_02",
                name = "at_clip_extended_rifle",
                price = 100000
            },
            {
                label = "Băng đạn thêm 2",
                hash = "COMPONENT_COMPACTRIFLE_CLIP_03",
                name = "at_clip_drum_rifle",
                price = 200000
            },
        },
        tints = {
            {
                label = "Default tint",
                index = 0,
                price = 0
            },
            {
                label = "Green tint",
                index = 1,
                price = 2000000
            },
            {
                label = "Gold tint",
                index = 2,
                price = 2000000
            },
            {
                label = "Pink tint",
                index = 3,
                price = 2000000
            },
            {
                label = "Camouflage tint",
                index = 4,
                price = 2000000
            },
            {
                label = "Blue tint",
                index = 5,
                price = 2000000
            },
            {
                label = "Orange tint",
                index = 6,
                price = 2000000
            },
            {
                label = "Platinum tint",
                index = 7,
                price = 2000000
            }
        }
    },

    {
        weapon = "WEAPON_CARBINERIFLE",
        label = "Carbine Rifle",
        price = false,
        can_buy_ammo = true,
        ammo_price = 1000,
        ammo_count = 60,
        upgrades = {
            -- {
            --     label = "Băng đạn thường",
            --     hash = "COMPONENT_CARBINERIFLE_CLIP_01",
            --     name = "clip_default",
            --     price = 0
            -- },
            {
                label = "Băng đạn thêm",
                hash = "COMPONENT_CARBINERIFLE_CLIP_02",
                name = "at_clip_extended_rifle",
                price = 200000
            },
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                name = "at_flashlight",
                price = 1000
            },
            {
                label = "Ống ngắm",
                hash = "COMPONENT_AT_SCOPE_MEDIUM",
                name = "at_scope_medium",
                price = 1000
            },
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP",
                name = "at_suppressor_heavy",
                price = 50000
            },
            {
                label = "Tay cầm",
                hash = "COMPONENT_AT_AR_AFGRIP",
                name = "at_grip",
                price = 100000
            }
        },
        tints = {
            {
                label = "Default tint",
                index = 0,
                price = 0
            },
            {
                label = "Green tint",
                index = 1,
                price = 200000
            },
            {
                label = "Gold tint",
                index = 2,
                price = 200000
            },
            {
                label = "Pink tint",
                index = 3,
                price = 200000
            },
            {
                label = "Platinum tint",
                index = 7,
                price = 200000
            }
        }
    },

    {
        weapon = "WEAPON_BULLPUPRIFLE",
        label = "Bullbup Rifle",
        price = false,
        can_buy_ammo = true,
        ammo_price = 1000,
        ammo_count = 60,
        upgrades = {
            -- {
            --     label = "Băng đạn thường",
            --     hash = "COMPONENT_BULLPUPRIFLE_CLIP_01",
            --     name = "clip_default_bullpuprifle",
            --     price = 0
            -- },
            {
                label = "Băng đạn thêm",
                hash = "COMPONENT_BULLPUPRIFLE_CLIP_02",
                name = "at_clip_extended_rifle",
                price = 300000
            },
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                name = "at_flashlight",
                price = 1000
            },
            {
                label = "Ống ngắm",
                hash = "COMPONENT_AT_SCOPE_SMALL",
                name = "at_scope_small",
                price = 1000
            },
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP",
                name = "at_suppressor_heavy",
                price = 100000
            },
            {
                label = "Tay cầm",
                hash = "COMPONENT_AT_AR_AFGRIP",
                name = "at_grip",
                price = 50000
            }
        },
        tints = {
            {
                label = "Default tint",
                index = 0,
                price = 0
            },
            {
                label = "Green tint",
                index = 1,
                price = 2000000
            },
            {
                label = "Gold tint",
                index = 2,
                price = 2000000
            },
            {
                label = "Pink tint",
                index = 3,
                price = 2000000
            },
            {
                label = "Camouflage tint",
                index = 4,
                price = 2000000
            },
            {
                label = "Blue tint",
                index = 5,
                price = 2000000
            },
            {
                label = "Orange tint",
                index = 6,
                price = 2000000
            },
            {
                label = "Platinum tint",
                index = 7,
                price = 2000000
            }
        }
    },
   
    {
        weapon = "WEAPON_ADVANCEDRIFLE",
        label = "Advanced Rifle",
        price = false,
        can_buy_ammo = false,
        ammo_price = 1000,
        ammo_count = 60,
        upgrades = {
            {
                label = "Băng đạn thường",
                hash = "COMPONENT_ADVANCEDRIFLE_CLIP_01",
                name = "clip_default_advancedrifle",
                price = 0
            },
            {
                label = "Băng đạn thêm",
                hash = "COMPONENT_ADVANCEDRIFLE_CLIP_02",
                name = "clip_extended_advancedrifle",
                price = 200000
            },
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                name = "flashlight_advancedrifle",
                price = 1000
            },
            {
                label = "Ống ngắm",
                hash = "COMPONENT_AT_SCOPE_SMALL",
                name = "scope_advancedrifle",
                price = 1000
            },
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP",
                name = "suppressor_advancedrifle",
                price = 100000
            }
        },
        tints = {
            {
                label = "Default tint",
                index = 0,
                price = 0
            },
            {
                label = "Green tint",
                index = 1,
                price = 2000000
            },
            {
                label = "Gold tint",
                index = 2,
                price = 2000000
            },
            {
                label = "Pink tint",
                index = 3,
                price = 2000000
            },
            {
                label = "Camouflage tint",
                index = 4,
                price = 2000000
            },
            {
                label = "Blue tint",
                index = 5,
                price = 2000000
            },
            {
                label = "Orange tint",
                index = 6,
                price = 2000000
            },
            {
                label = "Platinum tint",
                index = 7,
                price = 2000000
            }
        }
    },
    {
        weapon = "WEAPON_SCARH",
        label = "Scar",
        price = false,
        can_buy_ammo = true,
        ammo_price = 1000,
        ammo_count = 60,
        upgrades = {
            -- {
            --     label = "Băng đạn thường",
            --     hash = "COMPONENT_scar_CLIP_01",
            --     name = "clip_default",
            --     price = 0
            -- },
            {
                label = "Băng đạn theem",
                hash = "COMPONENT_SCARH_CLIP_02",
                name = "at_clip_extended_rifle",
                price = 200000
            },
            {
                label = "Đèn pin",
                hash = "COMPONENT_AT_AR_FLSH",
                name = "at_flashlight",
                price = 1000
            },
            {
                label = "Ống ngắm",
                hash = "COMPONENT_AT_SCOPE_ACOG",
                name = "at_scope_medium",
                price = 20000
            },
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPP_02",
                name = "at_suppressor_heavy",
                price = 10000
            }  ,    {
                label = "Tay cầm",
                hash = "COMPONENT_AT_AR_AFGRIP",
                name = "at_grip",
                price = 10000
            }
        }
    },

    {
        weapon = "WEAPON_PHANTOM",
        label = "Phantom",
        price = false,
        can_buy_ammo = true,
        ammo_price = 1000,
        ammo_count = 60,
        upgrades = {
            -- {
            --     label = "Băng đạn thường",
            --     hash = "COMPONENT_scar_CLIP_01",
            --     name = "clip_default",
            --     price = 0
            -- },
            {
                label = "Băng đạn thêm",
                hash = "COMPONENT_phantom_CLIP_02",
                name = "at_clip_extended_rifle",
                price = 200000
            },
            -- {
            --     label = "Đèn pin",
            --     hash = "COMPONENT_AT_AR_FLSH",
            --     name = "flashlight",
            --     price = 1000
            -- },
            -- {
            --     label = "Ống ngắm",
            --     hash = "COMPONENT_AT_SCOPE_MEDIUM",
            --     name = "scope",
            --     price = 1000
            -- },
            {
                label = "Giảm thanh",
                hash = "COMPONENT_AT_AR_SUPPT",
                name = "at_suppressor_heavy",
                price = 1000
            },  
            --  {
            --     label = "Tay cầm",
            --     hash = "COMPONENT_AT_AR_AFGRIP",
            --     name = "grip",
            --     price = 1000
            -- }
        }
    },

        {
            weapon = "WEAPON_G36C",
            label = "G36C",
            price = false,
            can_buy_ammo = true,
            ammo_price = 1000,
            ammo_count = 60,
            upgrades = {
                -- {
                --     label = "Băng đạn thường",
                --     hash = "COMPONENT_G36C_CLIP_01",
                --     name = "clip_default",
                --     price = 0
                -- },
                {
                    label = "Băng đạn thêm",
                    hash = "COMPONENT_G36C_CLIP_02",
                    name = "at_clip_extended_rifle",
                    price = 1000
                },
                {
                    label = "Đèn pin",
                    hash = "COMPONENT_AT_AR_FLSH",
                    name = "at_flashlight",
                    price = 1000
                },
                {
                    label = "Ống ngắm",
                    hash = "COMPONENT_AT_SCOPE_MEDIUM",
                    name = "at_scope_medium",
                    price = 1000
                },
                {
                    label = "Giảm thanh",
                    hash = "COMPONENT_AT_AR_SUPP_02",
                    name = "at_suppressor_heavy",
                    price = 1000
                }  ,    {
                    label = "Tay cầm",
                    hash = "COMPONENT_AT_AR_AFGRIP",
                    name = "at_grip",
                    price = 1000
                }
            }
        },

        {
            weapon = "WEAPON_AK12",
            label = "AK-12",
            price = false,
            can_buy_ammo = true,
            ammo_price = 1000,
             ammo_count = 60,
            upgrades = {
                -- {
                --     label = "Băng đạn thường",
                --     hash = "COMPONENT_G36C_CLIP_01",
                --     name = "clip_default",
                --     price = 0
                -- },
                {
                    label = "Băng đạn thêm",
                    hash = "COMPONENT_AK12_CLIP_02",
                    name = "at_clip_extended_rifle",
                    price = 50000
                },
                {
                    label = "Đèn pin",
                    hash = "COMPONENT_AT_AR_FLSH",
                    name = "at_flashlight",
                    price = 1000
                },
                {
                    label = "Ống ngắm",
                    hash = "COMPONENT_AT_SCOPE_SMALL",
                    name = "at_scope_small",
                    price = 20000
                },
                {
                    label = "Giảm thanh",
                    hash = "COMPONENT_AT_AR_SUPP_02",
                    name = "at_suppressor_heavy",
                    price = 20000
                }  ,    {
                    label = "Tay cầm",
                    hash = "COMPONENT_AT_AR_AFGRIP",
                    name = "at_grip",
                    price = 35000
                }
            }
        },

        {
            weapon = "WEAPON_AK47",
            label = "AK-47",
            price = false,
            can_buy_ammo = true,
            ammo_price = 1000,
             ammo_count = 60,
            upgrades = {
                -- {
                --     label = "Băng đạn thường",
                --     hash = "COMPONENT_G36C_CLIP_01",
                --     name = "clip_default",
                --     price = 0
                -- },
                {
                    label = "Băng đạn thêm",
                    hash = "COMPONENT_AK47_CLIP_02",
                    name = "at_clip_extended_rifle",
                    price = 50000
                },
                {
                    label = "Đèn pin",
                    hash = "COMPONENT_AT_AR_FLSH",
                    name = "at_flashlight",
                    price = 1000
                },
                {
                    label = "Ống ngắm",
                    hash = "COMPONENT_AT_SCOPE_MEDIUM",
                    name = "at_scope_medium",
                    price = 20000
                },
                {
                    label = "Giảm thanh",
                    hash = "COMPONENT_AT_AR_SUPP",
                    name = "at_suppressor_heavy",
                    price = 20000
                }  ,    {
                    label = "Tay cầm",
                    hash = "COMPONENT_AT_AR_AFGRIP",
                    name = "at_grip",
                    price = 35000
                }
            }
        },

        {
            weapon = "WEAPON_M4A4",
            label = "M4A4",
            price = false,
            can_buy_ammo = true,
            ammo_price = 1000,
            ammo_count = 60,
            upgrades = {
                -- {
                --     label = "Băng đạn thường",
                --     hash = "COMPONENT_G36C_CLIP_01",
                --     name = "clip_default",
                --     price = 0
                -- },
                {
                    label = "Băng đạn thêm",
                    hash = "COMPONENT_M4A4_CLIP_02",
                    name = "at_clip_extended_rifle",
                    price = 500000
                },
                {
                    label = "Đèn pin",
                    hash = "COMPONENT_AT_AR_FLSH",
                    name = "at_flashlight",
                    price = 10000
                },
                {
                    label = "Ống ngắm",
                    hash = "COMPONENT_AT_SCOPE_MEDIUM",
                    name = "at_scope_medium",
                    price = 100000
                },
                {
                    label = "Giảm thanh",
                    hash = "COMPONENT_AT_AR_SUPP",
                    name = "at_suppressor_heavy",
                    price = 20000
                },   
                {
                    label = "Tay cầm",
                    hash = "COMPONENT_AT_AR_AFGRIP",
                    name = "at_grip",
                    price = 350000
                }
            }
        },

        {
            weapon = "WEAPON_HEAVYRIFLE",
            label = "Heavy rifle",
            price = false,
            can_buy_ammo = true,
            ammo_price = 1000,
            ammo_count = 60,
            upgrades = {
                -- {
                --     label = "Băng đạn thường",
                --     hash = "COMPONENT_G36C_CLIP_01",
                --     name = "clip_default",
                --     price = 0
                -- },
                {
                    label = "Băng đạn thêm",
                    hash = "COMPONENT_HEAVYRIFLE_CLIP_02",
                    name = "at_clip_extended_rifle",
                    price = 500000
                },
                {
                    label = "Đèn pin",
                    hash = "COMPONENT_AT_AR_FLSH",
                    name = "at_flashlight",
                    price = 10000
                },
                {
                    label = "Ống ngắm",
                    hash = "COMPONENT_AT_SCOPE_MEDIUM",
                    name = "at_scope_medium",
                    price = 100000
                },
                {
                    label = "Giảm thanh",
                    hash = "COMPONENT_AT_AR_SUPP",
                    name = "at_suppressor_heavy",
                    price = 20000
                },   
                {
                    label = "Tay cầm",
                    hash = "COMPONENT_AT_AR_AFGRIP",
                    name = "at_grip",
                    price = 350000
                }
            }
        },
    
       
}

