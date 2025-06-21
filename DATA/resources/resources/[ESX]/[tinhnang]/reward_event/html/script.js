

const elementBar = document.getElementById("expBar");
const preLv =  document.getElementById("previousLevel");
const nextLv =  document.getElementById("nextLevel");
const loadder = $('.loadingscreen');
const body = $('.container');
const popup = $('.popup');

var levelData = []
var itemsData = []
var missionData = []
var dailyData = {}
var mainData = {}

var topPlayers = []

var pages = ['trangchu' , 'thongtin' , 'nhiemvu', 'bangxephang']
    
var currentPageBody = 'trangchu'
var currentXp = 0
var currentLevel = 0
var currentPage = 1
var isProcessUp = false
var premiumAble = 0
var isLoadingPage = false
var Waiting = false
var isLoadingTop = false

showLoader(true);

$(function () { 

    display(false)

    window.addEventListener('message', function(event) {
      
        let item = event.data;
        
        if (item.type === "ui") {

            showLoader(true);

            showPage("trangchu")

            itemsData = item.configItems;
            premiumAble = item.premium;
            levelData = item.ConfigXp;
            currentXp = item.currentXp;
            missionData = item.ConfigMission;
            dailyData = item.dailyData;
            mainData = item.mainData;

            currentLevel = 0;

            let scanLevel = 0;

            while ( scanLevel < 30 && currentXp >= levelData[scanLevel] ) 
                scanLevel++;
        

            currentLevel = scanLevel 
        
            let previousXpLevel = (currentLevel == 0) ? 0: levelData[currentLevel-1];
            let nextXpLevel = (currentLevel == levelData.length) ? levelData[currentLevel-1] : levelData[currentLevel];

            let percent = (currentXp - previousXpLevel)/  (nextXpLevel - previousXpLevel);
            elementBar.innerHTML = `${currentXp}/${nextXpLevel}`
            elementBar.style.width = (percent > 1)? "100%" : `${percent*100}%`;
            preLv.innerHTML = currentLevel;
            nextLv.innerHTML = (currentLevel == 30) ? "MAX" :currentLevel+ 1;    
            

            LoadLevelPage()
            LoadMissionPage()
            LoadStatusMission()

            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
        else if (item.type == 'update') {
        
            itemsData = item.configItems;
            premiumAble = item.premium;
            levelData = item.ConfigXp;
            currentXp = item.currentXp;
            missionData = item.ConfigMission;
            dailyData = item.dailyData;
            mainData = item.mainData;

            currentLevel = 0;

            let scanLevel = 0;

            while ( scanLevel < 30 && currentXp >= levelData[scanLevel] ) 
                scanLevel++;
        

            currentLevel = scanLevel 
        
            let previousXpLevel = (currentLevel == 0) ? 0: levelData[currentLevel-1];
            let nextXpLevel = (currentLevel == levelData.length) ? levelData[currentLevel-1] : levelData[currentLevel];

            let percent = (currentXp - previousXpLevel)/  (nextXpLevel - previousXpLevel);
            elementBar.innerHTML = `${currentXp}/${nextXpLevel}`
            elementBar.style.width = (percent > 1)? "100%" : `${percent*100}%`;
            preLv.innerHTML = currentLevel;
            nextLv.innerHTML = (currentLevel == 30) ? "MAX" :currentLevel+ 1;    
            
            LoadLevelPage()
            LoadMissionPage()
            LoadStatusMission()
        }
        else if (item.type == 'response') {
            showLoader(false)
            Waiting = false;
            ShowNotif(item.text);
        }
        else if (item.type == 'pyro') {
            $(".pyro").show();
        }

        else if (item.type == 'top') {
            topPlayers = item.data
            isLoadingTop = false;
        }

    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://reward_event/exit', JSON.stringify({}));
            return
        }
    };

    $("#close").click(function () {
        $.post('http://reward_event/exit', JSON.stringify({}));
        return
    })

   
    $("#home").click(function () {  
        showPage('trangchu')
    })

    $("#info").click(function () {
        showPage('thongtin')
    })

    $("#mission").click(function () {
        showPage('nhiemvu')
    })

    $("#top").click(function () {
        showPage('bangxephang')
        LoadTopPage()
    })

    
    $("#prevButton").click(function () {
        if (currentPage == 1) return;
        currentPage--;

        LoadLevelPage();
    })

    
    $("#nextButton").click(function () {
        if (currentPage == 6) return;
        currentPage ++;
        LoadLevelPage();
    })

    $("#closepopup").click(function () {
        body.removeClass("blur");
        popup.hide();
        $(".pyro").hide();
        $("#contentpopup").text("Có lỗi xảy ra vui lòng tắt mở lại menu");
    })
       
})






function rewardItem(type, index ) {
    let level = (currentPage -1)*5 + index;
    if (level > currentLevel) return;
    if (type == 'premium' && premiumAble == 0) return;  // Premium Rewards check
    if (!itemsData[level-1][type] || !itemsData[level-1][type].item ) return;   // Item avaible check
   
    $.post('http://reward_event/rewardItem', JSON.stringify({
        'type': type,
        'level' : level
    }));

    WaitingServerResponse()
}

function rewardMisionDaily(mission, rank ) {
    $.post('http://reward_event/rewardMisionDaily', JSON.stringify({
        'mission': mission,
        'rank' : rank
    }));

    WaitingServerResponse()
}

function rewardMision(mission, rank ) {
    $.post('http://reward_event/rewardMision', JSON.stringify({
        'mission': mission,
        'rank' : rank
    }));

    WaitingServerResponse()
}


function display(bool) {
    if (bool) {
        $('.bodyhtml').show();
    } else {
        $('.bodyhtml').hide();
        body.removeClass("blur");
        loadder.hide();
        popup.hide();
    }
}


async function WaitingServerResponse() {
    Waiting = true;
    showLoader(true)

    let timeout = setTimeout(() => {
        if (Waiting) {
            showLoader(false)
            Waiting = false;
            ShowNotif("Có lỗi xảy ra: Server không phản hồi!")

        }
    },30000)

    while (Waiting) 
        await Delay(100)

    clearTimeout(timeout);
}

function showPage(page) {
    currentPageBody = page;
    pages.forEach(_page => $(`.${_page}`).hide())
   $(`.${currentPageBody}`).show();
}

function showLoader(bool) {
    if (bool) {
        loadder.show();
        body.addClass("blur");
    }
    else  {
        loadder.hide();
        body.removeClass("blur");
    }
    
}

function ShowNotif(content) {
    $("#contentpopup").text(content);
    body.addClass("blur");
    popup.show();
}

async function LoadLevelPage() {

    while (isLoadingPage) 
        await Delay(100)

    isLoadingPage = true; 
    showLoader(true);
 
    let startLevel = 5*(currentPage-1)+1;
    let endLevel = startLevel +4;


    for (let i = startLevel - 1 ; i < endLevel ;i++) {
       
        if (itemsData[i].free && itemsData[i].free.item) {
            html = "";
            classname = "zoomhover-1s  zoomhover-s120"
            if (currentLevel < i+1 ) classname = "cantreward"


            if (mainData.itemrewarded.find(data=> (data.type == 'free' && data.level == i+1))) {
                html= "<div class='danhan'></div>"
                classname = "cantreward"
            }
        
            html  +=   
            `<table class = 'itemtable'> 
            <tr><td height= "130px">
            <img class ="${classname}" src="nui://ox_inventory/web/images/${itemsData[i].free.item}.png" > 
            </td></tr>
            <tr><td class = "count">${itemsData[i].free.count}</td></tr>
            </table> `

        }
        else html = "";


        document.getElementById(`free${i%5 +1}`).innerHTML =html;

        if (itemsData[i].premium  && itemsData[i].premium.item) {
            html = "";
            classname = "zoomhover-1s  zoomhover-s120"
            if (premiumAble == 0 || currentLevel < i+1 ) classname = "cantreward"
            if (mainData.itemrewarded.find(data=> (data.type == 'premium' && data.level == i+1))) {
                html= "<div class='danhan'></div>"
                classname = "cantreward"
            }

            html  +=   
            `<table class = 'itemtable'> 
            <tr><td height= "130px">
            <img class ="${classname}" src="nui://ox_inventory/web/images/${itemsData[i].premium.item}.png" > 
            </td></tr>
            <tr><td class = "count">${itemsData[i].premium.count}</td></tr>
            </table> `
        }
        else  html = "";

        document.getElementById(`premium${i%5 +1}`).innerHTML =html;

        document.getElementById(`level${i%5 +1}`).innerHTML =i+1;

        
    }

    isLoadingPage = false; 
    showLoader(false);
}


async function LoadMissionPage() {

    while (isLoadingPage) 
        await Delay(100)

    isLoadingPage = true; 
    showLoader(true);




    let html = ''

    /// Daily Missions

    html += `\n<tr  class = "titlerow"> <td  colspan = "5">Nhiệm vụ Hằng ngày</td></tr>\n`
 



    // //=== Daily Mission Body === //

    for (let i = 0 ; i < dailyData.missiondata.length; i++)
    {
        let missionIndex = dailyData.missiondata[i].mission- 1
        let mission = missionData[missionIndex] 
        let rank    = dailyData.missiondata[i].rank - 1
        let count = mission.data[rank].count - ((rank == 0)?0:(mission.data[rank-1].count) )


        html += `
        <tr class = "mainrow">
        <td>${mission.description.replace(/%s/g, count)}</td>
        <td>${mission.data[rank].point} điểm</td>
        <td>Level 0</td>
        <td><span id="${mission.item}-daily">0</span>/${count}</td>
        <td class = 'cantreward ' id="daily-${missionIndex}-${rank}-claim" onclick="rewardMisionDaily('${missionIndex + 1}' , '${rank + 1}')"></td>
        </tr>`
    }


    // //===========================// 

    



    html += `\n<tr  class = "titlerow"> <td  colspan = "5">Nhiệm vụ chính</td></tr>\n`


    let maindata = []

    for (let i = 0 ; i < missionData.length; i++)
        for (let j = 0 ; j < 5 ;j++)
            maindata.push({
                mission : i,
                rank    : j,
                level   : missionData[i].data[j].level
            })
    
    maindata.sort((a,b) => a.level - b.level)
    
    
    for (let i = 0 ; i < maindata.length; i++)
    {
        let missionIndex = maindata[i].mission
        let mission  = missionData[missionIndex]
        let rank     = maindata[i].rank
        let classDiv = "cantreward"

        if (currentLevel < mission.data[rank].level) classDiv = "lock" 
        html += `
        <tr class = "mainrow">
        <td>${mission.description.replace(/%s/g, mission.data[rank].count)}</td>
        <td>${mission.data[rank].point} điểm</td>
        <td>Level ${maindata[i].level}</td>
        <td><span id="${mission.item}">0</span>/${mission.data[rank].count}</td>
        <td class = '${classDiv} ' id="main-${missionIndex}-${rank}-claim" onclick="rewardMision('${missionIndex + 1}' , '${rank + 1}')"></td>
        </tr>`
    }




    $(".missionbody tbody").html(html) 

    isLoadingPage = false; 
    showLoader(false);
}



async function LoadStatusMission() {

    // Daily Items
 
    for (let i = 0 ; i < dailyData.missiondata.length; i++) {
        let mission = dailyData.missiondata[i].mission - 1
        let rank    = dailyData.missiondata[i].rank - 1
        let count = dailyData.items[missionData[mission].item]

        $(`[id=${missionData[mission].item}-daily]`).each(function () {
            $(this).text(count)
        })


        let requireCount = missionData[mission].data[rank].count - ( (rank == 0)? 0: missionData[mission].data[rank-1].count )


        if (count >= requireCount &&currentLevel >= missionData[mission].data[rank].level)
        $(`#daily-${mission}-${rank}-claim`).attr('class','zoomhover-1s zoomhover-s105');
    }
    
    // Daily Mission Rewarded  

    dailyData.missionrewarded.forEach((data) => {
        $(`#daily-${data.mission - 1}-${data.rank - 1}-claim`).attr('class','cantreward danhan');
    })

    

    // Main  Items

    for (let item in mainData.items) {
        let count = mainData.items[item]
        $(`[id=${item}]`).each(function () {
            $(this).text(count)
        })
        let mission = missionData.find(data => data.item == item)
        
        if (!mission || !mission.data) continue        

        await mission.data.forEach((data, rank) => {
            if (count >= data.count &&currentLevel >= data.level) {
                $(`#main-${missionData.indexOf(mission)}-${rank}-claim`).attr('class','zoomhover-1s zoomhover-s105');
            }
               
        })
  
    }


    // Main Mission Rewarded  

    mainData.missionrewarded.forEach((data) => {
        $(`#main-${data.mission - 1}-${data.rank - 1}-claim`).attr('class','cantreward danhan');
    })


}


async function LoadTopPage() {
    topPlayers = []
    let secWait = 0 
    isLoadingPage = true
    isLoadingTop  = true

    showLoader(true);

    $.post('http://reward_event/getTopPlayers', JSON.stringify({}));

    while (isLoadingTop) {
        await Delay(100)
        secWait += 0.1

        // === Wait quá 30s sẽ báo lỗi
        if (secWait > 30) {
            isLoadingPage = false
            isLoadingTop = false
            showLoader(false);
            return ShowNotif("Có lỗi xảy ra: Server không phản hồi!")
        }
        //
    }
        
    

    // === Load Top 20 Page Code === //


    for (let i = 0; i < 20; i++) {
        let player = {name : "Chưa Có", point : "Chưa Có"}
        if (topPlayers[i]) player = topPlayers[i]
        
        $(`.topchartsbody .top${i+1} #ten`).text(player.name || "Chưa Có") 
        $(`.topchartsbody .top${i+1} #diem`).text((player.point)? `${player.point} Điểm`:"Chưa Có") 
    }


    //===============================//


    isLoadingPage = false
    showLoader(false);
}


// ========= Không Dùng Tới ========== 

// async function SetCurrentXp(xp) {
//     while (isProcessUp) 
//         await Delay(100)
   
//     isProcessUp = true;

//     if (currentLevel == 30 ) {
//         currentXp = xp
//         elementBar.innerHTML = `${currentXp}/${levelData[currentLevel-1]}`
//         return isProcessUp = false;
//     }


    

//     let previousXpLevel = (currentLevel == 0) ? 0: levelData[currentLevel-1];
//     let nextXpLevel = (currentLevel == levelData.length) ? levelData[currentLevel-1] : levelData[currentLevel];


//     if (xp > nextXpLevel) {
//         await $("#expBar").animate({ width: "100%" } , {
//             duration: 2000,
//             step: function( now, fx ) {
//                 currentXp = previousXpLevel + Math.ceil(now/100*(nextXpLevel - previousXpLevel))
//                 elementBar.innerHTML = `${currentXp}/${nextXpLevel}`
               
//             },
//             complete: function () {
//                 currentXp = nextXpLevel;
//                 currentLevel++;
//                 isProcessUp = false;
//                 preLv.innerHTML = currentLevel;
//                 nextLv.innerHTML = (currentLevel == 30) ? "MAX" :currentLevel+ 1;    
//                 if (currentLevel != 30) $("#expBar").animate({ width: "0%" } , 100, () => SetCurrentXp(xp)); 
//             }
//         }); 
//     }

// }




async function Delay(delayInms) {
    return new Promise(resolve => {
        setTimeout(() => {
         resolve(2);
       }, delayInms);
     });
}

