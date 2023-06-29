var xhr = new XMLHttpRequest();
var baseUrl = contextPath + '/mvc';
var agvList;
// var stations = {1: 'Station1', 2: 'Station2', 3: 'Station3', 4: 'Station4'};
// taskprogress <div class=\"progress\"><div id=\"taskProgress"+tasks[i].taskNumber+"\" class=\"progress-bar\" /*style=\"width: 30%;\"*/></div></div>
var stations;
var agvListImg = {1: "agv_250.png", 2: "agv_250.png", 3: "agv_250.png"};
window.onresize =  function(){
    setWindow();
    setStationPositions();
    updateAGVPositions();
}

window.onload = async function(){
    setWindow();
    setStationPositions();
    // updateAGVPositions();
    try {
        await setAGVList();
        await setAGVListBatteryChart();
        await getStations();
        await setTasks();
        await setNotifications();
    } catch (error) {
        console.error('發生錯誤：', error);
    }
    // console.log("success");

    // 更新資料
    updateAGVStatus();  //  取得狀態資料
    setInterval(updateAGVStatus, 1000);  //  每秒更新
};

function setWindow(){
    var AGVTask = document.querySelectorAll('.AGVTask');
    if (window.innerWidth < 1197) {
        for(let i=0;i<AGVTask.length;i++)
            AGVTask[i].style.display = "none";
    } else {
        for(let i=0;i<AGVTask.length;i++)
            AGVTask[i].style.display = "block";
    }
}

function updateAGVStatus() {
    xhr.open('GET', baseUrl + "/api/homepage/agv", true);
    xhr.send();
    xhr.onload = function(){
        if(xhr.status == 200){
            var agvStatus = JSON.parse(this.responseText);
            agvUpdate(agvStatus);
        }
    };
}
function agvUpdate(agvStatus){  // 更新資料
    for(let i=0;i<agvStatus.length;i++){ // agv遍歷
        // 更新電量百分比
        var batteryString = "battery"+(i+1);
        document.getElementById(batteryString).innerHTML = agvStatus[i].battery+"%";  

        // 更新電量圓餅圖
        var updateBattery = [agvStatus[i].battery, 100-agvStatus[i].battery]; 
        var agvBatteryChart = Chart.instances[i];
        if(agvStatus[i].battery < 50)
            agvBatteryChart.data.datasets[0].backgroundColor = ['rgb(255, 0, 0)','rgb(26, 28, 30)'];
        else
            agvBatteryChart.data.datasets[0].backgroundColor = ['rgb(118, 212, 114)','rgb(26, 28, 30)'];
        agvBatteryChart.data.datasets[0].data = updateBattery;
        agvBatteryChart.update();

        // 更新信號強度
        var signalString = "agvSignal"+(i+1);
        var agvSignal = document.getElementById(signalString);
        agvStatus[i].signal < 1 ? agvSignal.setAttribute("xlink:href", "#wifi-unconnect") : 
            agvStatus[i].signal > 80 ? agvSignal.setAttribute("xlink:href", "#wifi-3") :
            agvStatus[i].signal > 50 ? agvSignal.setAttribute("xlink:href", "#wifi-2") :
            agvSignal.setAttribute("xlink:href", "#wifi-1");
        
        // 更新AGV狀態
        document.getElementById('agvStatus'+(i+1)).classList.remove('error');
        document.getElementById('agvStatus'+(i+1)).classList.remove('normal');
        switch (agvStatus[i].status) {
            case 0:
                document.getElementById('agvStatus'+(i+1)).classList.add('normal');
                document.getElementById('agvStatus'+(i+1)).innerHTML = '<div class="dstatus working"></div><p class="agvStatus working">Working'+agvStatus[i].task+'</p>';
                break;
            case 1:
                document.getElementById('agvStatus'+(i+1)).classList.add('normal');
                document.getElementById('agvStatus'+(i+1)).innerHTML = '<div class="dstatus obstacle"></div><p class="agvStatus obstacle">Obstacle'+agvStatus[i].task+'</p>';
                break;
            case 2:
                document.getElementById('agvStatus'+(i+1)).classList.add('error');
                document.getElementById('agvStatus'+(i+1)).innerHTML = '<p class="agvStatus error" id="agvStatus1">Error'+agvStatus[i].task+'</p>';
                break;
            default:
                break;
        }

        // 更新AGV位置
        updateAGVPositions(agvStatus[i].place);
    }
}

function setAGVList() {
    return new Promise((resolve, reject) => {
        xhr.open('GET', baseUrl + "/api/homepage/agvlist", true);
        xhr.send();
        xhr.onload = function(){
            if(xhr.status == 200){
                agvList = JSON.parse(this.responseText);
                addAGVList(agvList);
                resolve(); // 解析成功时，将 Promise 设置为已完成状态
            }else {
                reject(new Error('AGV列表獲取失敗')); // 解析失败时，将 Promise 设置为拒绝状态
            }
        };
    });
}

function addAGVList(agvList){  // 更新資料
    var agvListHTML = "";
    var html1 = '<div class="col-4 gx-5"><div class="row"><div class="col agvCard"><div class="row cardTop"><div class="col cardInfo"><div class="row" style="padding-top: 1.5%;"><div class="col" style=" display: inline-flex;align-items: center;">';
    var html2 = '</div></div><div class="row"><div class="col">';
    var html3 = '</div></div><div class="row align-self-end" style="padding-bottom: 1%;"><div class="col-2" style="margin-right: 1em;"><div class="ratio ratio-1x1 cardBattery"><div class="canvas-wrap">';
    var html4 = '</div><label class="batteryLabel">Battery</label></div></div><div class="col-2"><div class="ratio ratio-1x1 cardSignal"><svg style="fill: #000000;" class="bi bi-wifi-off wifi" width="16" height="16" viewBox="0 0 16 16">';
    var html5 = '<label class="signalLabel">Signal</label></div></div></div></div><div class="col-3 cardImg">';
    var html6 = '</div></div><div class="row cardBottom">';
    var html7 = '</div></div></div></div></div>';
// "<div class="dstatus obstacle"></div>
//                     <p class="agvStatus obstacle">obstacle</p>
    for(let i=0;i<agvList.length;i++){
        agvListHTML += html1 + '<p class="title AGVTitle" id="AGV'+(i+1)+'Title">'+agvList[i].name+'</p>' +
                       html2 + '<p class="AGVName" id="AGV'+(i+1)+'Name">'+agvList[i].memo+'</p>' +
                       html3 + '<canvas class="cover-fit" id="AGV_battery_'+(i+1)+'"></canvas><p id="battery'+(i+1)+'"></p>' +
                       html4 + '<use id="agvSignal'+(i+1)+'" xlink:href="#wifi-unconnect"/></svg>' +
                       html5 + '<img class="img-fluid" style="width: 100%;" src="'+contextPath+'/image/'+agvListImg[agvList[i].id]+'" alt="image error">' +
                       html6 + '<div id="agvStatus'+(i+1)+'" class="col AGVstatus">' + html7;
    }
    document.getElementById("agvList").innerHTML = agvListHTML;
}

function setAGVListBatteryChart() {
    return new Promise((resolve, reject) => {
        try {
            for(let i=0;i<agvList.length;i++){
                var agvBattery = document.getElementById('AGV_battery_'+(i+1)).getContext('2d');
                var agvBatteryChart = new Chart(agvBattery, {
                    type: 'doughnut',
                    data: {
                        datasets: [{
                            data: [100, 0],
                            backgroundColor: [
                            'rgb(118, 212, 114)',
                            'rgb(26, 28, 30)'
                            ],
                            borderWidth: 0
                        }]
                    },
                    options: {
                        cutout: "60%",
                        responsive: true,
                        radius: "60%",
                        animation: {
                            animateRotate: true
                        }
                    }
                });
                agvBatteryChart.customIndex = i;  //  建立agvBatteryChart實例索引值
            }
            resolve(); // 完成新增電量圓餅圖實例
        } catch (error) {
            reject(new Error('新增電量圓餅圖實例失敗')); // 新增電量圓餅圖實例失敗
        }
    });
}

function getStations() {
    return new Promise((resolve, reject) => {
        xhr.open('GET', baseUrl + "/api/homepage/stations", true);
        xhr.send();
        xhr.onload = function(){
            if(xhr.status == 200){
                stations = JSON.parse(this.responseText);
                console.log(stations);
                resolve(); // 解析成功时，将 Promise 设置为已完成状态
            }else {
                reject(new Error('起始站點資訊獲取失敗')); // 解析失败时，将 Promise 设置为拒绝状态
            }
        };
    });
}

function setTasks() {
    return new Promise((resolve, reject) => {
        // xhr.open('GET', baseUrl + "/api/homepage/task/today", true);
        xhr.open('GET', baseUrl + "/api/homepage/tasks", true);
        xhr.send();
        xhr.onload = function(){
            if(xhr.status == 200){
                var tasks = JSON.parse(this.responseText);
                addTasks(tasks);
                resolve(); // 解析成功時，將 Promise 設置為已完成狀態
            }else {
                reject(new Error('任務列表獲取失敗')); // 解析失敗時，將 Promise 設置為拒絕狀態
            }
        };
    });
}

function addTasks(tasks){  // 更新資料
    var tasksHTML = "";
    if (!tasks.length){
        tasksHTML = '<h1 style="color: #C9C9C9;float: center;">目前沒有任務</h1>';
    }else{
        for(let i=0;i<tasks.length;i++){
            var datetime = tasks[i].createTaskTime;
            var year = datetime.substring(0, 4);
            var month = datetime.substring(4, 6);
            var day = datetime.substring(6, 8);
            var hour = datetime.substring(8, 10);
            var minute = datetime.substring(10, 12);
            var second = datetime.substring(12, 14);
            var st;
            if(tasks[i].startId)
                st = stations[tasks[i].startId-1].name;
            else 
                st= 'undefined';
            tasksHTML += "<div class=\"row task\"><div class=\"col agvTask\"><div class=\"row\"><div class=\"col\"><div class=\"row taskTitle\"><div class=\"col\">" +
                        "<p>"+tasks[i].taskNumber+"</p></div></div><div class=\"row taskContent\"><div class=\"col\">" +
                        "<p>AGV: "+agvList[tasks[i].agvId-1].name+"</p><p>Start: "+st+"</p><p>End: "+stations[tasks[i].terminalId-1].name+"</p></div></div></div><div class=\"col-6\"><div class=\"row taskTB\">" +
                        "<div id=progressDiv\"tasks[i].taskNumber\" class=\"col-5 taskBar\"></div><div class=\"col-5\"><div class=\"row\"><div class=\"col\"><labe class=\"right\">"+year+"/"+month+"/"+day+"</label></div></div><div class=\"row\">" +
                        "<div class=\"col\"><label class=\"right\">"+hour+":"+minute+":"+second+"</label></div></div></div><div class=\"col-2\"><button type=\"button\" onclick=\"alert(\'remove: "+tasks[i].taskNumber+"\')\" class=\"btn btn-danger right\">" +
                        "<svg width=\"16\" height=\"16\" viewBox=\"0 0 16 16\" style=\"fill: white;\"><use xlink:href=\"#trash\"/></svg></button></div></div></div></div></div></div>";
        }
    }
    document.getElementById("taskQueue").innerHTML = tasksHTML;
}

function setNotifications() {
    return new Promise((resolve, reject) => {
        xhr.open('GET', baseUrl + "/api/homepage/notification/all", true);
        xhr.send();
        xhr.onload = function(){
            if(xhr.status == 200){
                var notifications = JSON.parse(this.responseText);
                addNotifications(notifications);
                resolve(); // 解析成功時，將 Promise 設置為已完成狀態
            }else {
                reject(new Error('通知列表獲取失敗')); // 解析失敗時，將 Promise 設置為拒絕狀態
            }
        };
    });
}

function addNotifications(notifications){  // 更新資料
    var notificationsHTML = "";
    for(let i=0;i<notifications.length;i++){
        var datetime = notifications[i].createTime;
        var year = datetime.substring(0, 4);
        var month = datetime.substring(4, 6);
        var day = datetime.substring(6, 8);
        var hour = datetime.substring(8, 10);
        var minute = datetime.substring(10, 12);
        var second = datetime.substring(12, 14);
        var level;
        switch (notifications[i].level) {
            case 0:
                level = 'normal';
                break;
            case 1:
                level = 'info';
                break;
            case 2:
                level = 'warning';
                break;
            case 3:
                level = 'danger';
                break;
            default:
                level = 'normal';
                break;
        }
        notificationsHTML += '<div class="row"><div class="col message"><div class="nfStatus '+level+'"></div><div class="messageContent">' +
                    '<label>'+notifications[i].title+'</label><p>'+notifications[i].content+'</p></div></div></div>';
    }
    document.getElementById("notification").innerHTML = notificationsHTML;
}

function setStationPositions() {
    var map = document.getElementById("map");
    var mapWidth = map.clientWidth;
    var stationHeight = map.clientHeight/3.9;

    for(let i=0;i<4;i++){
        stationString = "station"+(i+1);
        document.getElementById(stationString).style.transform = "translate(" +
            (-mapWidth*(0.973-i*0.31))+"px, "+stationHeight+"px)"; // i*0.31 (0.93/(站點-1)) (0.93/(4-1))=0.31|(0.93/(5-1))
    }
}

function updateAGVPositions(station) {
    var map = document.getElementById("map");
    var mapWidth = map.clientWidth;
    var stationHeight = map.clientHeight/2.53;
    var place = parseInt(station.slice(-1)) - 1;
    /*** 
     * -mapWidth*(0.9765)   第一站
     * -mapWidth*(0.05)     第四站
     * (0.9765-0.05)/3 = 0.309 == 四站間距
     *  ***/

    // document.getElementById("agv1").style.transform = "translate(" + (-mapWidth*(0.9765))+"px, "+stationHeight+"px) rotate(90deg)";
    document.getElementById("agv1").style.transform = "translate(" + (-mapWidth*(0.05+place*0.309))+"px, "+stationHeight+"px) rotate(90deg)";
}