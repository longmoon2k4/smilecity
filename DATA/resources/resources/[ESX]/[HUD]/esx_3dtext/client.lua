

    RegisterFontFile('Helvetica')
    fontId = RegisterFontId('Helvetica')


Citizen.CreateThread(function()
    Holograms()
	
end)





local function RGBRainbow( frequency )
	local result = {}
	local curtime = GetGameTimer() / 500

	result.r = math.floor( math.sin( curtime * frequency + 10 ) * 127 + 128 )
	result.g = math.floor( math.sin( curtime * frequency + 12 ) * 127 + 128 )
	result.b = math.floor( math.sin( curtime * frequency + 14 ) * 127 + 128 )

	return result

end

function Holograms()
		while true do
			local time = 1000
			local coords = GetEntityCoords(PlayerPedId())
			-- for k,v in pairs(Config.Zones) do
			-- 	if #(coords-v.Pos) < 20 then
			-- 		time = 1
			-- 		Draw3DText(v.Pos2.x,v.Pos2.y, v.Pos2.z, v.name, fontId, 0.1, 0.1)
			-- 	end
			-- end
			-- if GetDistanceBetweenCoords(-592.79644775391, -914.75384521484, 23.886629104614 , GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
			-- 	Draw3DText(-592.79644775391, -914.75384521484, 23.886629104614 , "  🔧  Bảng Giá Độ Xe  🔧  ", fontId, 0.1, 0.1)
			-- end
			-- if GetDistanceBetweenCoords(-592.79644775391, -914.75384521484, 23.586629104614 , GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
			-- 	Draw3DText(-592.79644775391, -914.75384521484, 23.586629104614 , "  🚗     XE INGAME : không quá 20% giá trị xe   🚗 ", fontId, 0.1, 0.1)
			-- end
			-- if GetDistanceBetweenCoords(-592.79644775391, -914.75384521484, 23.286629104614 , GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
			-- 	Draw3DText(-592.79644775391, -914.75384521484, 23.286629104614 , "  🚙     XE MOD : ", fontId, 0.1, 0.1)
			-- end
			-- if GetDistanceBetweenCoords(-592.79644775391, -914.75384521484, 22.986629104614 , GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
			-- 	Draw3DText(-592.79644775391, -914.75384521484, 22.986629104614 , " + độ màu : 80000$ ", fontId, 0.1, 0.1)
			-- end
			-- if GetDistanceBetweenCoords(-592.79644775391, -914.75384521484, 22.686629104614 , GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
			-- 	Draw3DText(-592.79644775391, -914.75384521484, 22.686629104614 , " + độ giáp : 300000$ ", fontId, 0.1, 0.1)
			-- end
			-- if GetDistanceBetweenCoords(-592.79644775391, -914.75384521484, 22.386629104614 , GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
			-- 	Draw3DText(-592.79644775391, -914.75384521484, 22.386629104614 , " + động cơ : 500000$ ", fontId, 0.1, 0.1)
			-- end
			-- if GetDistanceBetweenCoords(-592.79644775391, -914.75384521484, 22.086629104614 , GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
			-- 	Draw3DText(-592.79644775391, -914.75384521484, 22.0386629104614 , " + cần số : 95000$ ", fontId, 0.1, 0.1)
			-- end
			-- if GetDistanceBetweenCoords(-592.79644775391, -914.75384521484, 21.786629104614 , GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
			-- 	Draw3DText(-592.79644775391, -914.75384521484, 21.786629104614 , " + đèn gầm : 20000$ 🚙", fontId, 0.1, 0.1)
			-- end
			-- if GetDistanceBetweenCoords(-615.60046386719, -109.84548187256, 39.008129119873 , coords) < 20.0 then
			-- 	time =1 
			-- 	Draw3DText(-615.60046386719, -109.84548187256, 39.008129119873, "  👕  Bán Quần Áo  👕  ", fontId, 0.1, 0.1)
			-- end

			if GetDistanceBetweenCoords(1521.45,  -2114.22,  76.81, coords) < 20.0 then
				time =1
				Draw3DText(1521.45,  -2114.22,  76.81, "  ☠️  Bán đồ bẩn  ☠️ ", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords(-3257.3269042969, 991.306640625, 11.504459381104, coords) < 20.0 then
				time =1
				Draw3DText(-3257.3269042969, 991.306640625, 11.504459381104, "  🐟  Bán Cá  🐟 ", fontId, 0.1, 0.1)
			end
			-- if GetDistanceBetweenCoords(2510.5874023438, 4214.6381835938, 38.931621551514, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
			-- 	Draw3DText(2510.5874023438, 4214.6381835938, 38.931621551514, "  🦈  Bán Cá Mập 🦈 ", fontId, 0.1, 0.1)
			-- end
			-- if GetDistanceBetweenCoords(3803.8415527344, 4444.2495117188, 3.0764336585999, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
			-- 	Draw3DText(3803.8415527344, 4444.2495117188, 3.0764336585999, "  🐢  Bán Rùa 🐢 ", fontId, 0.1, 0.1)
			-- end
			-- if GetDistanceBetweenCoords(-287.63806152344, 2535.6818847656, 74.692161560059, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
			-- 	Draw3DText(-287.63806152344, 2535.6818847656, 74.692161560059, "  ☠️  Phạm Quang Vượng  ☠️ ", fontId, 0.1, 0.1)
			-- end
			if GetDistanceBetweenCoords(388.75, -356.05, 47.02 , coords) < 20.0 then
				time = 1
				Draw3DText(388.75, -356.05, 47.02 , "  ️🛒  Chợ Trời  ️🛒  ", fontId, 0.1, 0.1)
			end
			-- if GetDistanceBetweenCoords(-1171.4129638672, -1575.3919677734, 3.6592168807983 , GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
			-- 	Draw3DText(-1171.4129638672, -1575.3919677734, 3.6592168807983 , "  ☠️  Chợ Đen  ☠️  ", fontId, 0.1, 0.1)
			-- end
			if GetDistanceBetweenCoords(-266.74, -968.14, 31.22 , coords) < 20.0 then
				time = 1
				Draw3DText(-266.74, -968.14, 30.22 , "  💼  Nhân Viên Tư Vấn  💼  ", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords(1705.27, 3780.3, 32.76 , coords) < 20.0 then
				time = 1
				Draw3DText(1705.27, 3780.3, 33.76 , "  💼  Nhân Viên Tư Vấn  💼  ", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords(-260.82, -965.0, 30.22 , coords) < 20.0 then
				time = 1
				Draw3DText(-260.82, -965.0, 30.22 , "  Quà tặng tân thủ 🎀 ", fontId, 0.1, 0.1)
			end
			-- if GetDistanceBetweenCoords(-259.93, -965.48, 30.30 , GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
			-- 	Draw3DText(-259.93, -965.48, 30.30 , "  👕 Thay Đồng Phục 👕  ", fontId, 0.1, 0.1)
			-- end

			-- if GetDistanceBetweenCoords(562.26, 2741.6, 41.86 , GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
			-- 	Draw3DText(562.26, 2741.6, 41.86 , "  🐶 Cửa Hàng Thú Cưng 🐶 ", fontId, 0.1, 0.1)
			-- end
			-- if GetDistanceBetweenCoords(348.02, 3405.99, 35.43 , GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
			-- 	Draw3DText(348.02, 3405.99, 35.43 , "  🐶 Huấn Luyện Thú Cưng 🐶 ", fontId, 0.1, 0.1)
			-- end
			-- if GetDistanceBetweenCoords(-949.23, 332.05, 70.33 , GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
			-- 	Draw3DText(-949.23, 332.05, 70.33 , "  🐶 Chăm Sóc Thú Cưng 🐶 ", fontId, 0.1, 0.1)
			-- end
			-- if GetDistanceBetweenCoords( -588.48, -135.6, 38.61, coords) < 20.0 then
			-- 	time = 1
            -- Draw3DText( -588.48, -135.6, 38.61, "  ⚙️  Thu Mua Vật Liệu  ⚙️  ", fontId, 0.1, 0.1)
			-- end 
			-- if GetDistanceBetweenCoords( -623.96, -119.34, 38.61, coords) < 20.0 then
			-- 	time = 1
			-- 	Draw3DText( -623.96, -119.34, 38.61, "  🍖  Thu Mua Thịt  🍖  ", fontId, 0.1, 0.1)
			-- end 
			-- if GetDistanceBetweenCoords( -578.47, -128.33, 39.0, coords) < 20.0 then
			-- 	time = 1
			-- 	Draw3DText( -578.47, -128.33, 39.0, "  ⛽  Thu Mua Xăng  ⛽  ", fontId, 0.1, 0.1)
			-- end
			-- if GetDistanceBetweenCoords( -625.24780273438, -131.76351928711, 38.008560180664, coords) < 20.0 then
			-- 	time = 1
			-- 	Draw3DText( -625.24780273438, -131.76351928711, 38.008560180664, "  🌳  Thu Mua Gỗ  🌳  ", fontId, 0.1, 0.1)
			-- end  
			--[[ if GetDistanceBetweenCoords( 221.75, -868.92, 30.49, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 221.75, -868.92, 30.49 -1.100, "  🍊  Cửa Hàng Cam Ép  🍊  ", fontId, 0.1, 0.1)
			end	
			if GetDistanceBetweenCoords( 246.48, -877.71, 30.49, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 246.48, -877.71, 30.49 -1.100, "  🍌  Cửa Hàng Chuối  🍌  ", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords( 244.66, -882.2, 30.49, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 244.66, -882.2, 30.49 -1.100, "  🍯  Cửa Hàng Mật Ong  🍯  ", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords( 220.2, -873.87, 30.49, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 220.2, -873.9, 30.49 -1.100, "  🍍  Cửa Hàng Dứa  🍍  ", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords( 222.11, -880.73, 30.49, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 222.11, -880.73, 30.49 -1.100, "  🎃  Cửa Hàng Bí  🎃  ", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords( 242.89, -886.76, 30.49, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 242.89, -886.76, 30.49 -1.100, "  🥦  Cửa Hàng Dưa Cải  🥦  ", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords( 221.73, -891.69, 30.49, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 221.73, -891.69, 30.49 -1.100, "  🍙  Cửa Hàng Gạo  🍙  ", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords( 237.74, -891.0, 30.49, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 237.74, -891.0, 30.49 -1.100, "  🍄  Cửa Hàng Nấm  🍄  ", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords( 218.8, -896.16, 30.69, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 218.8, -896.16, 30.69 -1.100, "  📏  Cửa Hàng Gỗ  📏  ", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords( 215.07, -901.06, 30.69, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 215.07, -901.06, 30.69 -1.100, "  🍉  Cửa Hàng Dưa  🍉  ", fontId, 0.1, 0.1)
			end ]]
--[[ 			if GetDistanceBetweenCoords( 212.19, -905.31, 30.69, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 212.19, -905.31, 30.69 -1.100, " 💎 Bán Quặng 💎 ", fontId, 0.1, 0.1)
			end ]]
			--[[ if GetDistanceBetweenCoords( 231.15, -898.59, 30.69, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 231.15, -898.59, 30.69 -1.100, "  ⚙️  Cửa Hàng Scrap Metal  ⚙️  ", fontId, 0.1, 0.1)
			end ]]
			--[[ if GetDistanceBetweenCoords( 221.58, -912.28, 30.69, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 221.58, -912.28, 30.69 -1.100, " 🥩 Bán Thịt Đóng Gói 🥩 ", fontId, 0.1, 0.1)
			end ]]
			--[[ if GetDistanceBetweenCoords( 224.17, -907.77, 30.69, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 224.17, -907.77, 30.69 -1.100, " 🥩 Cửa Hàng Thịt 🥩 ", fontId, 0.1, 0.1)
			end ]]
			--[[ if GetDistanceBetweenCoords( 227.83, -903.33, 30.69, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 227.83, -903.33, 30.69 -1.100, "  💎  Cửa Hàng Quặng  💎  ", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords( 223.64, -886.24, 30.69, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 223.64, -886.24, 30.69 -1.100, "  🥩  Cửa Hàng Thịt  🥩  ", fontId, 0.1, 0.1)
			end ]]
			--[[ if GetDistanceBetweenCoords( 212.91, -909.71, 30.69, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 212.91, -909.71, 30.69 -1.100, " ร้านขายหิน ", fontId, 0.1, 0.1)
			end ]]
			-- if GetDistanceBetweenCoords( 215.62, -818.33, 30.64, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            -- Draw3DText( 215.62, -818.33, 30.64 -0.700, "  🎁  Quà Tặng Tân Thủ  🎁  ", fontId, 0.1, 0.1)
			-- end
			--[[ if GetDistanceBetweenCoords( 216.58, -912.87, 30.69, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 216.58, -912.87, 30.69 -1.100, " ร้านขายผ้าห่ม", fontId, 0.1, 0.1)
			end ]]
			--[[ if GetDistanceBetweenCoords( -338.72, -1001.76, 30.54, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( -338.72, -1001.76, 30.54 -1.100, "โต๊ะทำอาหาร", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords( 1154.86, 3028.02, 45.88, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 1154.86, 3028.02, 45.88 -1.100, "โต๊ะคราฟบัตร", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords( 296.12, -598.25, 43.33, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 296.12, -598.25, 43.33 -1.100, "โต๊ะคราฟหมอ", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords( 468.93, -997.35, 43.69, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 468.93, -997.35, 43.69 -1.100, "โต๊ะคราฟตำรวจ", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords( 937.02, -3179.39, 5.9, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 937.02, -3179.39, 5.9 -1.100, "โต๊ะคราฟอาวุธ", fontId, 0.1, 0.1)
			end
			if GetDistanceBetweenCoords( 239.35, -819.72, 29.1, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
            Draw3DText( 239.35, -819.72, 29.1, "ร้านขายขนมปัง", fontId, 0.1, 0.1)
			end ]]

					--Hologram No. 2
		-- if GetDistanceBetweenCoords( -259.73, -975.6, 31.22, GetEntityCoords(GetPlayerPed(-1))) < 10.0 then
		-- 	--Draw3DText( -259.73, -975.6, 31.30  -1.400, "☎   Discord : https://discord.gg/tnVQa7c ☎", 4, 0.1, 0.1)
		-- 	--Draw3DText( -259.73, -975.6, 31.22  -1.600, "📨    Chào Mừng Bạn Đến Với Homies Over Bitch 💕", 4, 0.1, 0.1)
		-- end	
		Citizen.Wait(time)		
	end
end




function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)


         local px,py,pz=table.unpack(GetGameplayCamCoords())


         local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    


         local scale = (1/dist)*13


         local fov = (1/GetGameplayCamFov())*100


         local scale = scale*fov   


		 local ra = RGBRainbow(1.0)


         SetTextScale(scaleX*scale, scaleY*scale)


         SetTextFont(fontId)


         SetTextProportional(1)


         SetTextColour(ra.r, ra.g, ra.b, 255)		-- You can change the text color here


         SetTextDropshadow(1, 1, 1, 1, 255)


         SetTextEdge(2, 0, 0, 0, 150)


         SetTextDropShadow()


         SetTextOutline()


         SetTextEntry("STRING")


         SetTextCentre(1)


         AddTextComponentString(textInput)


         SetDrawOrigin(x,y,z+2, 0)


         DrawText(0.0, 0.0)


         ClearDrawOrigin()


        end