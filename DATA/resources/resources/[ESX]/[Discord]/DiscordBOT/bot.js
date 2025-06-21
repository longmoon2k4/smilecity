const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');   
const fetch = require('node-fetch');
const PORT = 18952
const app = express();
 let ESX = null;


main()

giveCarResponse = {}

async function main() {

    await LoadESX();

app
.get("/testconnection", async (req, res) => {
    res.json({ "status": "OK"})
})
.get("*", async (req, res) => {
    res.send("")
})
.use(bodyParser.json())
.use(bodyParser.urlencoded({
  extended: true
}))
.post("/revive" , async (req, res) =>{  
    try
    {
        if (!ESX) {
            LoadESX()
            res.json("Đang Load ESX vui lòng thử lại sau")
        }else {
            let data = Object(req.body)
            let xPlayer = ESX.GetPlayerFromId(data.id)
            
            if (xPlayer == null) return res.json("ID người chơi không Online" )
            emitNet('esx_ambulancejob:revive',xPlayer.source)
            console.log(`DiscordBOT: hồi sinh ${xPlayer.name}`)
            res.json( `Đã hồi sinh người chơi **${xPlayer.name}**`)
        }
    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})
.post("/tp" , async (req, res) =>{  
    try
    {
        if (!ESX) {
            LoadESX()
            res.json({"error" : "Đang Load ESX vui lòng thử lại sau" })
        }else {
            let data = Object(req.body)
            let xPlayer = ESX.GetPlayerFromId(data.id)
            if (xPlayer == null) return res.json({"error" : "ID người chơi không Online" })
            let coords = {
                x: 213.69,
                y: -808.49,
                z: 31.01
            }
            emitNet('bringAmbulanceCl',xPlayer.source,coords)
            console.log(`DiscordBOT: Teleport người chơi ${xPlayer.name}`)
            res.json({"success" : `đã teleport người chơi **${xPlayer.name}**.`})
        }
    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})

.post("/kick" , async (req, res) =>{  
    try
    {
        if (!ESX ) {
            LoadESX()
            res.json({"error" : "Đang Load ESX vui lòng thử lại sau" })
        }else {
            let data = Object(req.body)
            let xPlayer = ESX.GetPlayerFromId(data.id)
            if (xPlayer == null) return res.json({"error" : "ID người chơi không Online" })
            emitNet('chat:addMessage', -1, {
                args : ["^1DISCORD",`^2${xPlayer.name}^0 bị kick bởi ^2${data.name}^0. Lý Do: ${data.reason}`]
            })
            xPlayer.kick(`Bạn đã bị kick bởi ${data.name}. Lý Do: ${data.reason}`)

            res.json({"success" : `Đã kick người chơi **${xPlayer.name} - ${xPlayer.getIdentifier()}**.`})
        }
    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})

.post("/giveitem" , async (req, res) =>{  
    try
    {
        if (!ESX || !ESX.Items || ESX.Items.length == 0) {
            LoadESX()
            res.json({"error" : "Đang Load ESX vui lòng thử lại sau" })
        }else {
            let data = Object(req.body)
            let itemAmount = parseInt(data.amount || 0)
            let itemName = data.name
            let xPlayer = ESX.GetPlayerFromId(data.id)
            if (xPlayer == null) return res.json({"error" : "ID người chơi không Online" })
            if (ESX.GetItemLabel(itemName)== null) return res.json({"error" : "Item không tồn tại" })
            TriggerEvent('discord:giveitem',data.id, itemName, itemAmount)
            xPlayer.showNotification(`Bạn đã nhận được ${itemAmount}x ${itemName} từ ~b~Admin~s~`)
            res.json({"success" : `Đã chuyển ${itemAmount}x ${itemName} cho **${xPlayer.name} - ${xPlayer.getIdentifier()}**`})
        }
    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})

.post("/giveall" , async (req, res) =>{  
    try
    {
        if (!ESX) {
            LoadESX()
            res.json({"error" : "Đang Load ESX vui lòng thử lại sau" })
        }else {
            let data = Object(req.body)
            let item = data.name
            let soluong = parseInt(data.amount)
            if (ESX.GetItemLabel(item) == null) return res.json({"error" : "Item không tồn tại" })
            TriggerEvent("esx:giveallitem", source, item,soluong)
            res.json({"success" : `Đã chuyển item ***${item}*** cho tất cả mọi người`})
        }
    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})


.post("/setjob" , async (req, res) =>{  
    try
    {
        if (!ESX) {
            LoadESX()
            res.json({"error" : "Đang Load ESX vui lòng thử lại sau" })
        }else {
            let data = Object(req.body)
            let jobName = data.job
            let jobGrade = data.grade 
            let xPlayer = ESX.GetPlayerFromId(data.id)
            if (xPlayer == null) return res.json({"error" : "ID người chơi không Online" })

            if (!ESX.DoesJobExist(jobName,jobGrade) )
                return res.json({"error" : `Tên hoặc Cấp Bậc Job không tồn tại`})
            
            xPlayer.setJob(jobName,jobGrade)
        
            res.json({"success" : `Đã Set Job thành công cho **${xPlayer.name} - ${xPlayer.getIdentifier()}**`})
        }
    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})

.post("/setjob2" , async (req, res) =>{  
    try
    {
        if (!ESX || !ESX.Items || ESX.Items.length == 0) {
            LoadESX()
            res.json({"error" : "Đang Load ESX vui lòng thử lại sau" })
        }else {
            let data = Object(req.body)
            let jobName = data.job
            let jobGrade = data.grade 
            let xPlayer = ESX.GetPlayerFromId(data.id)
            if (xPlayer == null) return res.json({"error" : "ID người chơi không Online" })

            if (!ESX.DoesJobExist(jobName,jobGrade) )
                return res.json({"error" : `Tên hoặc Cấp Bậc Job 2 không tồn tại`})
            
            xPlayer.setJob2(jobName,jobGrade)
        
            res.json({"success" : `Đã Set Job 2 thành công cho **${xPlayer.name} - ${xPlayer.getIdentifier()}**`})
        }
    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})

.post("/givecar" , async (req, res) =>{  
    try
    {
        if (!ESX) {
            LoadESX()
            res.json({"error" : "Đang Load ESX vui lòng thử lại sau" })
        }else {

            let data = Object(req.body)
            let carName = data.model
            let carPlate = ""
            // let carModel = GetHashKey(carName)
            let xPlayer = ESX.GetPlayerFromId(data.id)
            if (xPlayer == null) return res.json({"error" : "ID người chơi không Online" })
            let ten = xPlayer.name
            res.json({"success" : `**Đang khởi tạo phương tiện**`})
            emitNet("DiscordBOT:givecar", xPlayer.source , carName, carPlate , xPlayer.source,ten)
        }

    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})


.post("/ban" , async (req, res) =>{  
    try
    {
        if (!ESX) {
            LoadESX()
            res.json({"error" : "Đang Load ESX vui lòng thử lại sau" })
        }else {

            let data = Object(req.body)
            let xPlayer = ESX.GetPlayerFromId(data.id)
            if (xPlayer == null) return res.json({"error" : "ID người chơi không Online" })
            TriggerEvent('triggerbansuluAbcas12398adfcnalwuascnx',0, [data.id, data.duree, data.reason])
            res.json({"error" : `Đã ban nguoi choi ${xPlayer.name} ${xPlayer.identifier} voi ly do ${data.reason}` })
        }

    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})

.post("/mutechat" , async (req, res) =>{  
    try
    {
        if (!ESX) {
            LoadESX()
            res.json({"error" : "Đang Load ESX vui lòng thử lại sau" })
        }else {

            let data = Object(req.body)
            let xPlayer = ESX.GetPlayerFromId(data.id)
            if (xPlayer == null) return res.json({"error" : "ID người chơi không Online" })
            TriggerEvent('chat:banChatBot', data.id, data.time)
            res.json({"error" : `Da mute chat ${xPlayer.name} ${xPlayer.identifier}` })
        }

    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})

.post("/searchsteam" , async (req, res) =>{  
    try
    {
        if (!ESX) {
            LoadESX()
            res.json({"error" : "Đang Load ESX vui lòng thử lại sau" })
        }else {

            let data = Object(req.body)
            let dataPlayer = await exports.sulu_ban.getDataSteam(data.steam)
            res.json(dataPlayer)
        }

    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})

.post("/searchlicense" , async (req, res) =>{  
    try
    {
        if (!ESX) {
            LoadESX()
            res.json({"error" : "Đang Load ESX vui lòng thử lại sau" })
        }else {

            let data = Object(req.body)
            let dataPlayer = await exports.sulu_ban.getDataLicense(data.license)
            res.json(dataPlayer)
        }

    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})

.post("/banoffline" , async (req, res) =>{  
    try
    {
        if (!ESX) {
            LoadESX()
            res.json({"error" : "Đang Load ESX vui lòng thử lại sau" })
        }else {

            let data = Object(req.body)
            TriggerEvent('triggerOffbansuluAbcas12398adfcnalwuascnx',0, [data.id, data.duree, data.reason])
            res.json({"error" : `Đã ban offline id  ${data.id} voi ly do ${data.reason}` })
        }


    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})

.post("/giveluotchuyen" , async (req, res) =>{  
    try
    {
        if (!ESX) {
            LoadESX()
            res.json({"error" : "Đang Load ESX vui lòng thử lại sau" })
        }else {
            let data = Object(req.body)
            exports.oxmysql.update_async('UPDATE owned_vehicles SET  `soluong` = `soluong` + 1 WHERE plate = ?', [
                data.plate
              ])
            res.json('Give lượt chuyển thành công')
        }


    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})

.post("/xoaluotchuyen" , async (req, res) =>{  
    try
    {
        if (!ESX) {
            LoadESX()
            res.json({"error" : "Đang Load ESX vui lòng thử lại sau" })
        }else {
            let data = Object(req.body)
            exports.oxmysql.update_async('UPDATE owned_vehicles SET  `soluong` = 0 WHERE plate = ?', [
                data.plate
              ])
            res.json('Xoa lượt chuyển thành công')
        }


    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})

.post("/searchcar" , async (req, res) =>{  
    try
    {
        if (!ESX) {
            LoadESX()
            res.json({"error" : "Đang Load ESX vui lòng thử lại sau" })
        }else {

            let data = Object(req.body)
            // let response = await exports.sulu_garage.getCar(data.plate)
            const response = await exports.oxmysql.query_async('SELECT u.identifier, u.name, o.plate, o.model, o.soluong FROM users u INNER JOIN owned_vehicles o ON u.identifier = o.owner WHERE o.plate = ?', [
                data.plate
              ])
            res.json(response)
        }


    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})

.post("/unbanwaveshield" , async (req, res) =>{  
    try
    {
        if (!ESX) {
            LoadESX()
            res.json({"error" : "Đang Load ESX vui lòng thử lại sau" })
        }else {

            let data = Object(req.body)
            exports.WaveShield.unbanPlayer(data.id)
            res.json('Check log unban')
        }


    }
    catch (err)
    {
        console.log(err)
        res.json({"error" : err })
    }
})

.listen(PORT, () =>console.log(`Listening on ${ PORT }`))

}

function LoadESX() {
   ESX = exports.es_extended.getSharedObject()
       
    //  emit("esx:getSharedObject", (obj) => ESX = obj);
}
