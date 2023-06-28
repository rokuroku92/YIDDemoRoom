<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>元創智動系統</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">-->
        <!--<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pure-min.css">-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/yid.css">
        <style>
            @media (min-width: 768px) {
              .bd-placeholder-img-lg {
                font-size: 3.5rem;
              }
            }
            body {
                min-height: 100vh;
                min-height: -webkit-fill-available;
            }

            html {
                height: -webkit-fill-available;
            }

            main {
                display: flex;
                flex-wrap: nowrap;
                min-height: 100vh;
                height: 100vh;
                height: -webkit-fill-available;
                max-height: 100vh;
                overflow-x: auto;
                overflow-y: auto;
            }
            .container {
                margin: 0px;
                margin-left: 5em;
                text-align: center;
                padding-top: 10px;
                max-width: 100%;
                justify-content: center;
            }
            .bi {
                vertical-align: -.125em;
                pointer-events: none;
                /*fill: #91BA55;*/
                fill: #ffffff;
            }
            .nav-flush .nav-link {
                border-radius: 0;
            }
            .nav-pills {
                --bs-nav-pills-link-active-bg: #FFB224;
            }
            .nav-link.active {
                /*background-image: url("${pageContext.request.contextPath}/image/sidebar_active.png");*/
            }
            .cover-fit{
                position: absolute;
                top: -5%;
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            .canvas-wrap svg{
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -170%);
                max-width: 90%;
                max-height: 90%;
            }
            .canvas-wrap p{
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                max-width: 50%;
                max-height: 50%;
                font-size: 1.2em;
            }
            .canvas-wrap label{
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, 50%);
                max-width: 50%;
                max-height: 50%;
                font-size: 0.7em;
            }
            .wifi{
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                max-width: 65%;
                max-height: 65%;
            }
            .statusBar{
                border-radius: 1.8rem!important;
                background-color: #1A1C1E;
                padding: 0.6em;
                margin-bottom: 0.6em;
                display:inline-flex;
                align-items: center;
            }
            .statusBarObj{
                margin-left: 0.4em;
                margin-right: 0.4em;
                border-radius: 1.8rem!important;
                background-color: #262626;
                height: 100%;
                display:inline-flex;
                align-items: center;
            }
            .agv{
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                max-width: 90%;
                max-height: 90%;
            }
            .statusBarObjCircle{
                margin-left: 0.6em;
                margin-right: 0.6em;
                border-radius: 50%!important;
                background-color: #2B2B2B;
                width: 3.6em;
                height: 3.6em;
                display: flex;
            }
            .agvWheelBK{
                background-color: #2B6BBF;
            }
            .agvWheel{
                transform: translate(42%, 42%);
                width: 55%;
                height: 55%;
                fill: #ffffff;
                /*fill: #5C5C5C;*/
            }
            .agvStopBK{
                background-color: #332424;
            }
            .agvStop{
                transform: translate(42%, 42%);
                width: 55%;
                height: 55%;
                fill: #D11815;
                /*fill: #5C5C5C;*/
            }
            .agvCollisionBK{
                background-color: #332424;
            }
            .agvCollision{
                width: 100%;
                height: 100%;
                fill: #D11815;
                /*fill: #5C5C5C;*/
            }
            .agvObstacleBK{
                /*background-color: #F0CE47;*/
                background-color: #473A06;
            }
            .agvObstacle{
                transform: translate(14%, 25%);
                width: 100%;
                height: 100%;
                fill: #E2B912;
                /*fill: #5C5C5C;*/
            }
            .circleDisable{
                fill: #5C5C5C;
            }
            
        </style>
<!--        <style>
            ::-webkit-scrollbar{
                display:none;
            }
        </style>
        <style>
            .ChartContainer {
                position: relative;
                width: 100%;
                height: 5em;
                overflow: hidden;
            }
            .CC{
                font-size: 16px;
            }
            .Chart {
                position: absolute;
                transform: rotate(270deg);
            }
            .task_sum{
                float: left;
            }
            .rate{
                float: right;
            }
        </style>-->
        <script src="https://code.jquery.com/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.3.0"></script>
        <!--<script src="https://unpkg.com/chart.js-plugin-labels-dv/dist/chartjs-plugin-labels.min.js"></script>-->
        <!--<script src="https://cdn.jsdelivr.net/gh/emn178/chartjs-plugin-labels/src/chartjs-plugin-labels.js"></script>-->
        <script src="https://bootstrap5.hexschool.com/docs/5.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
        <!--<script src="https://bootstrap5.hexschool.com/docs/5.1/examples/sidebars/sidebars.js"></script>-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" crossorigin="anonymous"></script>
        <!--<script>
            var xhr = new XMLHttpRequest();
            var baseUrl = '${pageContext.request.contextPath}/mvc';
            const station_list = ["PCB測試", "PCB外線", "PCB外AOI", "PCB網印", "CNC二廠", "FQC", "BGA整面C", "棕化", "內層線路", "Suep", "FVI", "PCB噴塗", "BGA整面A", "CNC一廠", "Routing"];

            window.onload = function(){
                getData();
                getData1();
                setInterval(getData, 1000);
                setInterval(getData1, 10000);
            };

            function getData() {
                xhr.open('GET', baseUrl + "/agv/json", true);
                xhr.send();
                xhr.onload = function(){
                    if(xhr.status == 200){
                        var data = JSON.parse(this.responseText);
                        console.log(data);
                        update(data);
                    }
                };
            }
            function getData1(){
                xhr.open('GET', baseUrl + "/api/analysis/mode?value=all", true);
                xhr.send();
                xhr.onload = function(){
                    if(xhr.status == 200){
                        var data = JSON.parse(this.responseText);
                        console.log(data);
                        countRate(data);
                    }
                };
            }

            function removeTaskById(id) {
                var check = confirm('是否要刪除任務：' + id + ' ?');

                if(!check) return;

                xhr.open('GET', baseUrl + "/agv/remove/task/" + id, true);
                xhr.send();
                xhr.onload = function(){
                    if(xhr.status == 200){
                        var data = this.responseText;
                        console.log(data);
                        if(data == 'ok') {
                            getData();
                        }
                    }
                };
            }

            function update(data){  // 更新資料
                // 工作狀態
                switch (data.status) {
                    case 0:
                      document.getElementById("status").value = "未連線";
                      break;
                    case 1:
                      document.getElementById("status").value = "待命中";
                      break;
                    case 2:
                      document.getElementById("status").value = "任務執行中";
                      break;
                    default:
                      console.log(`內容錯誤: ${data.status}.`);
                }
                document.getElementById("task").value = data.task;  // 目前任務
                document.getElementById("place").value = data.place.id;  // 目前位置
                document.getElementById("battery").value = data.battery+"%";  // 目前電壓
                // 放車子
                document.getElementById("agv_car_1").innerHTML = '<img src=\"${pageContext.request.contextPath}/image/icon_mp.png\" width=\"50\" ' +
                                                               'style=\"position: absolute;left: ' + data.place.coordinate[0] + 'px;top: ' + data.place.coordinate[1] + 'px;z-index: 10\" />';
//                document.getElementById("agv_car_2").innerHTML = '<img src=\"${pageContext.request.contextPath}/image/icon_mp.png\" width=\"50\" ' +
//                                                               'style=\"position: absolute;left: 1113 px;top: ' + data.place.coordinate[1] + 'px;z-index: 10\" />';
//                document.getElementById("agv_car_3").innerHTML = '<img src=\"${pageContext.request.contextPath}/image/icon_mp.png\" width=\"50\" ' +
//                                                               'style=\"position: absolute;left: 923 px;top: ' + data.place.coordinate[1] + 'px;z-index: 10\" />';
                /*
                // 清除佇列任務
                document.getElementById('task_body').innerHTML = '';
                // 加入佇列任務
                var tbody_html = "";
                console.log(data.tasks.length);
                for(let i=0;i<data.tasks.length;i++){
                    let n = String("task"+(i));
                    tbody_html += "<tr class=\"task\" id=\""+n+"\"></tr>";
                    console.log(n);
                }
                document.getElementById("task_body").innerHTML = tbody_html;
                for(let i=0;i<data.tasks.length;i++){
                    let n = String("task"+(i));
                    document.getElementById(n).innerHTML = "<td>"+data.tasks[i].start_station+"</td><td>"+
                            data.tasks[i].notice_station+"</td><td>"+data.tasks[i].end_station+"</td>"+
                            "<button type=\"button\" class=\"btn btnt\" onclick=\"removeTaskById("+data.tasks[i].id+")\">"+
                            "<svg xmlns=\"${pageContext.request.contextPath}/image/trash.svg\" width=\"16\" height=\"16\" fill=\"currentColor\" class=\"bi bi-trash\" viewBox=\"0 0 16 16\">"+
                            "<path d=\"M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z\"/>"+
                            "<path fill-rule=\"evenodd\" d=\"M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z\"/>"+
                            "</svg></button>";  // evenodd
                    document.getElementById(String(data.tasks[i].end_station)+"b").innerHTML = station_list[data.tasks[i].notice_station-1];
//                    console.log(data.tasks[i].notice_station);
                }
                // 更改站點按鈕顏色
                for(let i=1;i<4;i++){
                    for(let j=1;j<6;j++){
                        let n = "s" + String(i)+String(j);
                        let m = String(i)+"-"+String(j);
                        switch (data.station[n]) {
                            case 0:
                              document.getElementById(m).className = "st btn btn-success disabled";
                              break;
                            case 1:
                              document.getElementById(m).className = "st btn btn-danger disabled";
                              break;
                            case 2:
                              document.getElementById(m).className = "st btn btn-primary";
                              break;
                            case 3:
                              document.getElementById(m).className = "st btn btn-warning disabled";
                              break;
                            default:
                              console.log(`內容錯誤: ${data.station[n]}.`);
                        }
                    }
                }
                */

            }

            function setfromStationNo(no) {
                if(no<1020){
                    document.getElementById('ststation').value = 1001;
                }else if(no>1020&&no<1030){
                    document.getElementById('ststation').value = 1007;
                }else{
                    document.getElementById('ststation').value = 1010;
                }
//                document.getElementById('ststation').value = no;
                var noText  = '';
                for(let i=1;i<4;i++){
                    for(let j=1;j<6;j++){
                        let n = 1000+i*10+j;
                        if(no == n) noText = String(i+"-"+j);
                    }
                }
                document.getElementById('ststationText').value = noText;
            }

            function setServiceNo(no) {
                if(no<1520){
                    document.getElementById('noticestation').value = 1501;
                }else if(no>1520&&no<1530){
                    document.getElementById('noticestation').value = 1507;
                }else{
                    document.getElementById('noticestation').value = 1010;
                }
//                document.getElementById('noticestation').value = no;
                var noText  = '';
                switch(no) {
                    case 1511:
                        noText = 'PCB測試';
                        break;
                    case 1512:
                        noText = 'PCB外線';
                        break;
                    case 1513:
                        noText = 'PCB外AOI';
                        break;
                    case 1514:
                        noText = 'PCB網印';
                        break;
                    case 1515:
                        noText = 'CNC二廠';
                        break;
                    case 1521:
                        noText = 'FQC';
                        break;
                    case 1522:
                        noText = 'BGA整面C';
                        break;
                    case 1523:
                        noText = '棕化';
                        break;
                    case 1524:
                        noText = '內層線路';
                        break;
                    case 1525:
                        noText = 'Suep';
                        break;
                    case 1531:
                        noText = 'FVI';
                        break;
                    case 1532:
                        noText = 'PCB噴塗';
                        break;
                    case 1533:
                        noText = 'BGA整面A';
                        break;
                    case 1534:
                        noText = 'CNC一廠';
                        break;
                    case 1535:
                        noText = 'Routing';
                        break;
                }
                document.getElementById('noticestationText').value = noText;
            }
            // 紀錄確認列與發送
            function subm(){
            //                alert("http://192.168.1.246:20100/task0=1&1&"+ststation+"&"+noticestation+"&"+ststation);
                alert("開始站: " + document.getElementById('ststation').value +", 通知站: "+ document.getElementById('noticestation').value);
//                window.open("http://192.168.1.143:20100/task0=1&7&"+document.getElementById('ststation').value+"&"+document.getElementById('noticestation').value);
                xhr.open('GET', "http://192.168.1.143:20100/task0=1&7&"+document.getElementById('ststation').value+"&"+document.getElementById('noticestation').value, true);
                xhr.send();
                xhr.onload = function(){
                    if(xhr.status == 200){
                        console.log("kgkkmgtkkttt");// 沒進入!
                        var data = this.responseText;
                        alert(data);
                    }
                };
            };
            // 清除按鈕
            function cn(){
                document.getElementById("ststation").value = "";
                document.getElementById("ststationText").value = "";
                document.getElementById("noticestation").value = "";
                document.getElementById("noticestationText").value = "";
            }
            function countRate(data) {
                var task_sum = 0;
                var work_sum = 0;
                var open_sum = 0;
                var x=0;
                for(let i=0 ; i < data.length ; i++) {
                    task_sum += data[i].task;
                    work_sum += data[i].workingHours;
                    open_sum += data[i].openHours;
                    if(data[i].task>0)x++;
                }
                //document.getElementById("rate").value = String((work_sum/open_sum)*100).substring(0,2)+"%";
                //document.getElementById("task_sum").value = task_sum;
            }
                       
        </script>
        <script>
            // 任務數、稼動率區塊                                                                            
            var target_tasks = 30; // 目標任務數
            
            document.addEventListener('DOMContentLoaded', function() {
              var task_sum1 = document.getElementById('task_sum1').getContext('2d');
              var rate1 = document.getElementById('rate1').getContext('2d');
              var task_sum2 = document.getElementById('task_sum2').getContext('2d');
              var rate2 = document.getElementById('rate2').getContext('2d');
              var task_sum3 = document.getElementById('task_sum3').getContext('2d');
              var rate3 = document.getElementById('rate3').getContext('2d');
              
              var data_task_sum1 = {
                datasets: [{
                  data: [30, 70],
                  backgroundColor: ['#7e55ba', '#91ba55']
                }]
              };
              var data_rate1 = {
                datasets: [{
                  data: [70, 30],
                  backgroundColor: ['#7e55ba', '#91ba55']
                }]
              };
              var data_task_sum2 = {
                datasets: [{
                  data: [30, 70],
                  backgroundColor: ['#7e55ba', '#91ba55']
                }]
              };
              var data_rate2 = {
                datasets: [{
                  data: [70, 30],
                  backgroundColor: ['#7e55ba', '#91ba55']
                }]
              };
              var data_task_sum3 = {
                datasets: [{
                  data: [30, 70],
                  backgroundColor: ['#7e55ba', '#91ba55']
                }]
              };
              var data_rate3 = {
                datasets: [{
                  data: [70, 30],
                  backgroundColor: ['#7e55ba', '#91ba55']
                }]
              };
              
              var options = {
                cutoutPercentage: 50,
                circumference: Math.PI,
                rotation: -Math.PI / 2
              };
              
              new Chart(task_sum1, {
                type: 'pie',
                data: data_task_sum1,
                options: options
              });
              new Chart(rate1, {
                type: 'pie',
                data: data_rate1,
                options: options
              });
              new Chart(task_sum2, {
                type: 'pie',
                data: data_task_sum2,
                options: options
              });
              new Chart(rate2, {
                type: 'pie',
                data: data_rate2,
                options: options
              });
              new Chart(task_sum3, {
                type: 'pie',
                data: data_task_sum3,
                options: options
              });
              new Chart(rate3, {
                type: 'pie',
                data: data_rate3,
                options: options
              });
              
            });
    </script>-->
        <script>
            var xhr = new XMLHttpRequest();
            var baseUrl = '${pageContext.request.contextPath}/mvc';
            window.onload = function(){
                getStatusData();  //  取得狀態資料
                setInterval(getStatusData, 100);  //  每秒更新
                
                var agvBattery1 = document.getElementById('AGV_battery_1').getContext('2d');
                var agvBattery2 = document.getElementById('AGV_battery_2').getContext('2d');
                var agvBattery1Chart = new Chart(agvBattery1, {
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
                        cutout: "90%",
                        responsive: true,
                        radius: "90%",
                        animation: {
                            animateRotate: true
                        }
                    }
                });
                agvBattery1Chart.customIndex = 0;  //  建立agvBattery1Chart實例索引值
                var agvBattery2Chart = new Chart(agvBattery2, {
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
                        cutout: "90%",
                        responsive: true,
                        radius: "90%",
                        animation: {
                            animateRotate: true
                        }
                    }
                });
                agvBattery2Chart.customIndex = 1;  //  建立agvBattery2Chart實例索引值
                
            };
            function getStatusData() {
                xhr.open('GET', baseUrl + "/agv/json", true);
                xhr.send();
                xhr.onload = function(){
                    if(xhr.status == 200){
                        var dataStatus = JSON.parse(this.responseText);
//                        console.log(dataStatus);
                        update(dataStatus);
                    }
                };
            }
            
            function update(dataStatus){  // 更新資料
                document.getElementById("battery1").innerHTML = dataStatus.battery+"%";  // 目前電壓
                document.getElementById("battery2").innerHTML = "100%";
                var updateBattery = [dataStatus.battery, 100-dataStatus.battery];
//                console.log("data_battery.datasets[0].data: "+data_battery.datasets[0].data);
                var agvBattery1Chart = Chart.instances[0];
                agvBattery1Chart.data.datasets[0].data = updateBattery;
                agvBattery1Chart.update();
                let agvSignal1 = document.querySelector("#agvSignal1");
                dataStatus.signal < 1 ? agvSignal1.setAttribute("xlink:href", "#wifi-unconnect") : 
                        dataStatus.signal > 80 ? agvSignal1.setAttribute("xlink:href", "#wifi-3") :
                        dataStatus.signal > 50 ? agvSignal1.setAttribute("xlink:href", "#wifi-2") :
                        agvSignal1.setAttribute("xlink:href", "#wifi-1");
            }
        </script>
    </head>
    <body style="padding: 0px;background-color: #000000;color: white;">
        <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
        <symbol id="bootstrap" viewBox="0 0 118 94">
          <title>Bootstrap</title>
          <path fill-rule="evenodd" clip-rule="evenodd" d="M24.509 0c-6.733 0-11.715 5.893-11.492 12.284.214 6.14-.064 14.092-2.066 20.577C8.943 39.365 5.547 43.485 0 44.014v5.972c5.547.529 8.943 4.649 10.951 11.153 2.002 6.485 2.28 14.437 2.066 20.577C12.794 88.106 17.776 94 24.51 94H93.5c6.733 0 11.714-5.893 11.491-12.284-.214-6.14.064-14.092 2.066-20.577 2.009-6.504 5.396-10.624 10.943-11.153v-5.972c-5.547-.529-8.934-4.649-10.943-11.153-2.002-6.484-2.28-14.437-2.066-20.577C105.214 5.894 100.233 0 93.5 0H24.508zM80 57.863C80 66.663 73.436 72 62.543 72H44a2 2 0 01-2-2V24a2 2 0 012-2h18.437c9.083 0 15.044 4.92 15.044 12.474 0 5.302-4.01 10.049-9.119 10.88v.277C75.317 46.394 80 51.21 80 57.863zM60.521 28.34H49.948v14.934h8.905c6.884 0 10.68-2.772 10.68-7.727 0-4.643-3.264-7.207-9.012-7.207zM49.948 49.2v16.458H60.91c7.167 0 10.964-2.876 10.964-8.281 0-5.406-3.903-8.178-11.425-8.178H49.948z"></path>
        </symbol>
        <symbol id="home" viewBox="0 0 16 16">
          <path d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z"/>
        </symbol>
        <symbol id="speedometer2" viewBox="0 0 16 16">
          <path d="M8 4a.5.5 0 0 1 .5.5V6a.5.5 0 0 1-1 0V4.5A.5.5 0 0 1 8 4zM3.732 5.732a.5.5 0 0 1 .707 0l.915.914a.5.5 0 1 1-.708.708l-.914-.915a.5.5 0 0 1 0-.707zM2 10a.5.5 0 0 1 .5-.5h1.586a.5.5 0 0 1 0 1H2.5A.5.5 0 0 1 2 10zm9.5 0a.5.5 0 0 1 .5-.5h1.5a.5.5 0 0 1 0 1H12a.5.5 0 0 1-.5-.5zm.754-4.246a.389.389 0 0 0-.527-.02L7.547 9.31a.91.91 0 1 0 1.302 1.258l3.434-4.297a.389.389 0 0 0-.029-.518z"/>
          <path fill-rule="evenodd" d="M0 10a8 8 0 1 1 15.547 2.661c-.442 1.253-1.845 1.602-2.932 1.25C11.309 13.488 9.475 13 8 13c-1.474 0-3.31.488-4.615.911-1.087.352-2.49.003-2.932-1.25A7.988 7.988 0 0 1 0 10zm8-7a7 7 0 0 0-6.603 9.329c.203.575.923.876 1.68.63C4.397 12.533 6.358 12 8 12s3.604.532 4.923.96c.757.245 1.477-.056 1.68-.631A7 7 0 0 0 8 3z"/>
        </symbol>
        <symbol id="table" viewBox="0 0 16 16">
          <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm15 2h-4v3h4V4zm0 4h-4v3h4V8zm0 4h-4v3h3a1 1 0 0 0 1-1v-2zm-5 3v-3H6v3h4zm-5 0v-3H1v2a1 1 0 0 0 1 1h3zm-4-4h4V8H1v3zm0-4h4V4H1v3zm5-3v3h4V4H6zm4 4H6v3h4V8z"/>
        </symbol>
        <symbol id="people-circle" viewBox="0 0 16 16">
          <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
          <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
        </symbol>
        <symbol id="grid" viewBox="0 0 16 16">
          <path d="M1 2.5A1.5 1.5 0 0 1 2.5 1h3A1.5 1.5 0 0 1 7 2.5v3A1.5 1.5 0 0 1 5.5 7h-3A1.5 1.5 0 0 1 1 5.5v-3zM2.5 2a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 1h3A1.5 1.5 0 0 1 15 2.5v3A1.5 1.5 0 0 1 13.5 7h-3A1.5 1.5 0 0 1 9 5.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zM1 10.5A1.5 1.5 0 0 1 2.5 9h3A1.5 1.5 0 0 1 7 10.5v3A1.5 1.5 0 0 1 5.5 15h-3A1.5 1.5 0 0 1 1 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 9h3a1.5 1.5 0 0 1 1.5 1.5v3a1.5 1.5 0 0 1-1.5 1.5h-3A1.5 1.5 0 0 1 9 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3z"/>
        </symbol>
        <symbol id="circle" viewBox="0 0 16 16">
            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
        </symbol>
        <symbol id="wifi-unconnect" viewBox="0 0 16 16">
          <path d="M10.706 3.294A12.545 12.545 0 0 0 8 3C5.259 3 2.723 3.882.663 5.379a.485.485 0 0 0-.048.736.518.518 0 0 0 .668.05A11.448 11.448 0 0 1 8 4c.63 0 1.249.05 1.852.148l.854-.854zM8 6c-1.905 0-3.68.56-5.166 1.526a.48.48 0 0 0-.063.745.525.525 0 0 0 .652.065 8.448 8.448 0 0 1 3.51-1.27L8 6zm2.596 1.404.785-.785c.63.24 1.227.545 1.785.907a.482.482 0 0 1 .063.745.525.525 0 0 1-.652.065 8.462 8.462 0 0 0-1.98-.932zM8 10l.933-.933a6.455 6.455 0 0 1 2.013.637c.285.145.326.524.1.75l-.015.015a.532.532 0 0 1-.611.09A5.478 5.478 0 0 0 8 10zm4.905-4.905.747-.747c.59.3 1.153.645 1.685 1.03a.485.485 0 0 1 .047.737.518.518 0 0 1-.668.05 11.493 11.493 0 0 0-1.811-1.07zM9.02 11.78c.238.14.236.464.04.66l-.707.706a.5.5 0 0 1-.707 0l-.707-.707c-.195-.195-.197-.518.04-.66A1.99 1.99 0 0 1 8 11.5c.374 0 .723.102 1.021.28zm4.355-9.905a.53.53 0 0 1 .75.75l-10.75 10.75a.53.53 0 0 1-.75-.75l10.75-10.75z"/>
        </symbol>
        <symbol id="wifi-1" viewBox="0 0 16 16">
            <path d="M11.046 10.454c.226-.226.185-.605-.1-.75A6.473 6.473 0 0 0 8 9c-1.06 0-2.062.254-2.946.704-.285.145-.326.524-.1.75l.015.015c.16.16.407.19.611.09A5.478 5.478 0 0 1 8 10c.868 0 1.69.201 2.42.56.203.1.45.07.611-.091l.015-.015zM9.06 12.44c.196-.196.198-.52-.04-.66A1.99 1.99 0 0 0 8 11.5a1.99 1.99 0 0 0-1.02.28c-.238.14-.236.464-.04.66l.706.706a.5.5 0 0 0 .707 0l.708-.707z"/>
        </symbol>
        <symbol id="wifi-2" viewBox="0 0 16 16">
            <path d="M13.229 8.271c.216-.216.194-.578-.063-.745A9.456 9.456 0 0 0 8 6c-1.905 0-3.68.56-5.166 1.526a.48.48 0 0 0-.063.745.525.525 0 0 0 .652.065A8.46 8.46 0 0 1 8 7a8.46 8.46 0 0 1 4.577 1.336c.205.132.48.108.652-.065zm-2.183 2.183c.226-.226.185-.605-.1-.75A6.473 6.473 0 0 0 8 9c-1.06 0-2.062.254-2.946.704-.285.145-.326.524-.1.75l.015.015c.16.16.408.19.611.09A5.478 5.478 0 0 1 8 10c.868 0 1.69.201 2.42.56.203.1.45.07.611-.091l.015-.015zM9.06 12.44c.196-.196.198-.52-.04-.66A1.99 1.99 0 0 0 8 11.5a1.99 1.99 0 0 0-1.02.28c-.238.14-.236.464-.04.66l.706.706a.5.5 0 0 0 .708 0l.707-.707z"/>
        </symbol>
        <symbol id="wifi-3" viewBox="0 0 16 16">
            <path d="M15.384 6.115a.485.485 0 0 0-.047-.736A12.444 12.444 0 0 0 8 3C5.259 3 2.723 3.882.663 5.379a.485.485 0 0 0-.048.736.518.518 0 0 0 .668.05A11.448 11.448 0 0 1 8 4c2.507 0 4.827.802 6.716 2.164.205.148.49.13.668-.049z"/>
            <path d="M13.229 8.271a.482.482 0 0 0-.063-.745A9.455 9.455 0 0 0 8 6c-1.905 0-3.68.56-5.166 1.526a.48.48 0 0 0-.063.745.525.525 0 0 0 .652.065A8.46 8.46 0 0 1 8 7a8.46 8.46 0 0 1 4.576 1.336c.206.132.48.108.653-.065zm-2.183 2.183c.226-.226.185-.605-.1-.75A6.473 6.473 0 0 0 8 9c-1.06 0-2.062.254-2.946.704-.285.145-.326.524-.1.75l.015.015c.16.16.407.19.611.09A5.478 5.478 0 0 1 8 10c.868 0 1.69.201 2.42.56.203.1.45.07.61-.091l.016-.015zM9.06 12.44c.196-.196.198-.52-.04-.66A1.99 1.99 0 0 0 8 11.5a1.99 1.99 0 0 0-1.02.28c-.238.14-.236.464-.04.66l.706.706a.5.5 0 0 0 .707 0l.707-.707z"/>
        </symbol>
        <symbol id="stop" viewBox="0 0 16 16">
            <path d="M3.16 10.08c-.931 0-1.447-.493-1.494-1.132h.653c.065.346.396.583.891.583.524 0 .83-.246.83-.62 0-.303-.203-.467-.637-.572l-.656-.164c-.61-.147-.978-.51-.978-1.078 0-.706.597-1.184 1.444-1.184.853 0 1.386.475 1.436 1.087h-.645c-.064-.32-.352-.542-.797-.542-.472 0-.77.246-.77.6 0 .261.196.437.553.522l.654.161c.673.164 1.06.487 1.06 1.11 0 .736-.574 1.228-1.544 1.228Zm3.427-3.51V10h-.665V6.57H4.753V6h3.006v.568H6.587Z"/>
            <path fill-rule="evenodd" d="M11.045 7.73v.544c0 1.131-.636 1.805-1.661 1.805-1.026 0-1.664-.674-1.664-1.805V7.73c0-1.136.638-1.807 1.664-1.807 1.025 0 1.66.674 1.66 1.807Zm-.674.547v-.553c0-.827-.422-1.234-.987-1.234-.572 0-.99.407-.99 1.234v.553c0 .83.418 1.237.99 1.237.565 0 .987-.408.987-1.237Zm1.15-2.276h1.535c.82 0 1.316.55 1.316 1.292 0 .747-.501 1.289-1.321 1.289h-.865V10h-.665V6.001Zm1.436 2.036c.463 0 .735-.272.735-.744s-.272-.741-.735-.741h-.774v1.485h.774Z"/>
            <path fill-rule="evenodd" d="M4.893 0a.5.5 0 0 0-.353.146L.146 4.54A.5.5 0 0 0 0 4.893v6.214a.5.5 0 0 0 .146.353l4.394 4.394a.5.5 0 0 0 .353.146h6.214a.5.5 0 0 0 .353-.146l4.394-4.394a.5.5 0 0 0 .146-.353V4.893a.5.5 0 0 0-.146-.353L11.46.146A.5.5 0 0 0 11.107 0H4.893ZM1 5.1 5.1 1h5.8L15 5.1v5.8L10.9 15H5.1L1 10.9V5.1Z"/>
        </symbol>
        <symbol id="collision" viewBox="0 0 48 48">
            <path d="m16.84 22.58-.5 1.87a3.89 3.89 0 0 0-.1 1.4L14.82 27a.37.37 0 0 1-.6-.36l.63-3.1a.37.37 0 0 0-.33-.44l-3.15-.3a.37.37 0 0 1-.17-.67l2.64-1.76a.37.37 0 0 0 .08-.54l-2-2.44a.37.37 0 0 1 .36-.59l3.1.62a.37.37 0 0 0 .44-.32l.3-3.16a.37.37 0 0 1 .67-.16l1.76 2.63a.37.37 0 0 0 .54.08l2.44-2a.37.37 0 0 1 .59.36l-.45 2.27-.33.38L20 19.25l-.43.58a3.91 3.91 0 0 0-2.73 2.75Zm20 5.36-.5 1.88a2.62 2.62 0 0 1-.68 1.18 2.48 2.48 0 0 1-.36.28l-.56 2.12a1.42 1.42 0 0 1-.23.46 1.29 1.29 0 0 1-1.36.45L31.9 34a1.31 1.31 0 0 1-.9-1.6l.34-1.25-10-2.68-.34 1.25a1.3 1.3 0 0 1-1.59.91l-1.25-.33a1.29 1.29 0 0 1-.95-1.07 1.31 1.31 0 0 1 0-.52l.57-2.11a2.26 2.26 0 0 1-.17-.43 2.48 2.48 0 0 1 0-1.38l.5-1.88a2.6 2.6 0 0 1 1.5-1.71 2.76 2.76 0 0 1 .75-.19l.73-1 1.3-1.74a3.8 3.8 0 0 1 .46-.52 4.34 4.34 0 0 1 1.06-.75 4.72 4.72 0 0 1 .61-.27 4.81 4.81 0 0 1 1.3-.24 4.51 4.51 0 0 1 1.36.15l5 1.34a4.51 4.51 0 0 1 1.25.54 4.46 4.46 0 0 1 1.4 1.4 4.56 4.56 0 0 1 .68 1.9l.22 2.18.15 1.21a2.65 2.65 0 0 1 .92 1.22 2.55 2.55 0 0 1 .07 1.55Zm-15.45-4.82a1.29 1.29 0 1 0-.67 2.5c.75.2 1.85.63 2.05-.12a2.5 2.5 0 0 0-1.38-2.38Zm11.77 1.14-.26-2.15a1.85 1.85 0 0 0-.15-.57 2 2 0 0 0-1.27-1.08l-5-1.33a1.92 1.92 0 0 0-2.06.71l-1.3 1.74 7 1.87Zm.75 2.22a2.5 2.5 0 0 0-2.38 1.37c-.2.74 1 .92 1.71 1.12a1.29 1.29 0 1 0 .67-2.49Z"/>
        </symbol>
        <symbol id="obstacle" viewBox="0 0 1024 1024">
            <g>
                <path d="m271.04,327.6l-81.199,-12.879c-18.48,-2.8008 -35.281,9.5195 -38.078,27.441c-2.8008,18.48 9.5195,35.281 28,38.078l96.32,15.121c1.6797,0 3.3594,0.55859 5.0391,0.55859c7.8398,0 15.68,-2.8008 21.84,-7.8398l26.32,-22.398l-33.602,-59.359l-24.6401,21.27721z"/>
                <path d="m407.12,308l73.922,-64.961l20.719,29.68c2.2383,3.3594 5.6016,6.7188 9.5195,8.3984l60.48,32.48c3.9219,2.2383 8.9609,3.3594 13.441,3.3594c10.641,0 20.719,-6.1602 25.199,-16.238c6.1602,-13.441 -0.55859,-29.68 -14,-36.961l-53.199,-28.559l-62.164,-88.48c-7.8398,-10.641 -20.16,-17.359 -33.602,-17.922c-13.441,0 -26.32,5.6016 -34.16,16.238c-19.602,25.199 -40.32,49.84 -61.602,73.359l-28.559,31.359c-9.5195,10.641 -11.199,26.32 -4.4805,39.199l53.762,93.527l-20.719,90.16c-3.9219,17.359 5.0391,35.84 21.84,41.441c3.3594,1.1211 6.7188,1.6797 10.078,1.6797c15.121,0 29.121,-10.641 32.48,-25.762l24.078,-104.72c1.6797,-8.3984 0.55859,-16.801 -3.3594,-24.078l-29.6736,-53.1995z"/>
                <path d="m501.2,446.88l-35.281,0c-9.5195,0 -17.359,7.8398 -17.359,17.359l0,35.281c0,9.5195 7.8398,17.359 17.359,17.359l35.281,0c9.5195,0 17.359,-7.8398 17.359,-17.359l0,-35.281c0,-9.5195 -7.8398,-17.359 -17.359,-17.359z"/>
                <path d="m616,123.2c0,32.477 -26.324,58.801 -58.801,58.801c-32.473,0 -58.801,-26.324 -58.801,-58.801c0,-32.473 26.328,-58.801 58.801,-58.801c32.477,0 58.801,26.328 58.801,58.801"/>
                <path d="m273.84,245.28c3.9219,-6.7188 4.4805,-15.121 0.55859,-22.398l-74.477,-136.08c-3.9219,-7.2812 -11.199,-11.762 -19.602,-11.762c-8.3984,0 -15.68,4.4805 -19.602,11.762l-73.918,136.64c-3.9219,7.2812 -3.3594,15.121 0.55859,22.398c3.9219,6.7188 11.199,11.199 19.602,11.199l147.84,0c7.8398,-0.55859 15.121,-4.4805 19.039,-11.758l0.00082,-0.001zm-103.6,-112.56c2.8008,-2.8008 6.1602,-4.4805 10.078,-4.4805c7.2812,0 13.441,6.1602 13.441,13.441l0,1.6797l-5.6016,45.359c-2.2383,-0.55859 -5.0391,-1.1211 -7.8398,-1.1211c-2.8008,0 -5.0391,0.55859 -7.8398,1.1211l-5.6016,-45.359c-0.55469,-3.918 0.56641,-7.8398 3.3633,-10.641l0.0005,0.0008zm10.082,95.203c-7.2812,0 -13.441,-6.1602 -13.441,-14c0,-7.2812 6.1602,-14 13.441,-14c7.8398,0 14,6.1602 14,14s-6.1602,14 -14,14z"/>
                <path d="m304.64,70.559c43.68,12.32 69.441,42 70,43.121c2.8008,3.3594 6.7188,5.0391 10.641,5.0391c3.3594,0 6.1602,-1.1211 8.9609,-3.3594c6.1602,-5.0391 6.7188,-13.441 1.6797,-19.602c-1.1211,-1.6797 -30.801,-36.961 -84,-52.078c-7.2812,-2.2383 -15.121,2.2383 -17.359,9.5195c-1.6836,7.8398 2.7969,15.121 10.078,17.359l-0.0006,0.0008z"/>
                <path d="m290.08,120.96c31.922,14 50.398,35.84 50.961,36.398c2.8008,3.3594 6.7188,5.0391 10.641,5.0391c3.3594,0 6.1602,-1.1211 8.9609,-3.3594c6.1602,-5.0391 6.7188,-13.441 1.6797,-19.602c-1.1211,-1.1211 -22.398,-26.879 -61.039,-43.68c-7.2812,-2.8008 -15.121,0 -18.48,7.2812c-2.8008,6.7227 0.55859,14.562 7.2773,17.922l-0.0009,0.0011z"/>
                <path d="m518,353.36c-7.2812,-2.8008 -15.121,0.55859 -17.922,7.2812l-13.438,31.359c-2.8008,7.2812 0.55859,15.121 7.2812,17.922c1.6797,0.55859 3.3594,1.1211 5.6016,1.1211c5.6016,0 10.641,-3.3594 12.879,-8.3984l12.879,-30.801c2.7969,-7.2852 -0.5625,-15.125 -7.2812,-18.484l0.0004,0.0001z"/>
                <path d="m595.28,441.84l-30.801,12.879c-7.2812,2.8008 -10.641,11.199 -7.2812,17.922c2.2383,5.6016 7.2812,8.3984 12.879,8.3984c1.6797,0 3.3594,-0.55859 5.0391,-1.1211l30.801,-12.879c7.2812,-2.8008 10.641,-11.199 7.2812,-17.922c-2.2383,-6.7188 -10.641,-10.078 -17.918,-7.2773l-0.0001,0z"/>
                <path d="m575.12,392c-5.6016,-5.6016 -14,-5.6016 -19.602,0l-23.52,23.52c-5.6016,5.6016 -5.6016,14 0,19.602c2.8008,2.8008 6.1602,3.9219 10.078,3.9219c3.3594,0 7.2812,-1.1211 10.078,-3.9219l23.52,-23.52c5.043,-5.6016 5.043,-14 -0.55469,-19.602l0.00069,0z"/>
            </g>
        </symbol>
        
        <symbol  id="wheel" viewBox="0 0 512 512">
            <g transform="translate(1 1)">
                <g>
                    <g>
                        <path d="M255-1C114.2-1-1,114.2-1,255s115.2,256,256,256s256-115.2,256-256S395.8-1,255-1z M255,493.933
                                c-131.413,0-238.933-107.52-238.933-238.933S123.587,16.067,255,16.067S493.933,123.587,493.933,255S386.413,493.933,255,493.933
                                z"/>
                        <path d="M255,280.6c-18.773,0-34.133,15.36-34.133,34.133c0,18.773,15.36,34.133,34.133,34.133
                                c18.773,0,34.133-15.36,34.133-34.133C289.133,295.96,273.773,280.6,255,280.6z M255,331.8c-9.387,0-17.067-7.68-17.067-17.067
                                s7.68-17.067,17.067-17.067s17.067,7.68,17.067,17.067S264.387,331.8,255,331.8z"/>
                        <path d="M314.733,220.867c-18.773,0-34.133,15.36-34.133,34.133c0,18.773,15.36,34.133,34.133,34.133
                                c18.773,0,34.133-15.36,34.133-34.133C348.867,236.227,333.507,220.867,314.733,220.867z M314.733,272.067
                                c-9.387,0-17.067-7.68-17.067-17.067s7.68-17.067,17.067-17.067S331.8,245.613,331.8,255S324.12,272.067,314.733,272.067z"/>
                        <path d="M255,229.4c18.773,0,34.133-15.36,34.133-34.133c0-18.773-15.36-34.133-34.133-34.133
                                c-18.773,0-34.133,15.36-34.133,34.133C220.867,214.04,236.227,229.4,255,229.4z M255,178.2c9.387,0,17.067,7.68,17.067,17.067
                                s-7.68,17.067-17.067,17.067s-17.067-7.68-17.067-17.067S245.613,178.2,255,178.2z"/>
                        <path d="M195.267,220.867c-18.773,0-34.133,15.36-34.133,34.133c0,18.773,15.36,34.133,34.133,34.133
                                c18.773,0,34.133-15.36,34.133-34.133C229.4,236.227,214.04,220.867,195.267,220.867z M195.267,272.067
                                c-9.387,0-17.067-7.68-17.067-17.067s7.68-17.067,17.067-17.067s17.067,7.68,17.067,17.067S204.653,272.067,195.267,272.067z"/>
                        <path d="M445.289,330.502C454.643,307.109,459.8,281.628,459.8,255c0-55.118-22.076-105.323-57.812-142.235
                                c-0.427-1.015-1.067-1.977-1.922-2.831c-0.855-0.855-1.816-1.495-2.831-1.922c-18.358-17.773-40.003-32.164-63.909-42.141
                                c-0.22-0.111-0.443-0.218-0.673-0.31c-0.7-0.42-1.424-0.69-2.152-0.849C307.109,55.357,281.628,50.2,255,50.2
                                c-55.118,0-105.323,22.076-142.235,57.812c-1.015,0.427-1.977,1.067-2.831,1.922s-1.495,1.816-1.922,2.831
                                c-17.773,18.358-32.164,40.003-42.141,63.909c-0.111,0.22-0.218,0.443-0.31,0.673c-0.42,0.7-0.69,1.424-0.849,2.152
                                C55.357,202.891,50.2,228.372,50.2,255c0,55.118,22.076,105.323,57.812,142.235c0.427,1.015,1.067,1.977,1.922,2.831
                                c0.93,0.93,1.865,1.597,2.932,2.02c18.336,17.728,39.946,32.083,63.808,42.043c0.22,0.111,0.443,0.218,0.673,0.31
                                c0.49,0.49,1.261,0.695,1.991,0.783C202.774,454.618,228.31,459.8,255,459.8c27.589,0,53.944-5.541,78.023-15.545
                                c0.371-0.089,0.724-0.222,1.023-0.42c23.681-9.991,45.122-24.323,63.326-41.98c0.967-0.423,1.919-1.013,2.694-1.788
                                c0.855-0.855,1.495-1.816,1.922-2.831c17.496-18.072,31.724-39.325,41.682-62.789c0.34-0.534,0.604-1.13,0.77-1.792
                                C444.86,331.953,445.13,331.229,445.289,330.502z M393.423,381.476l-42.091-42.091c7.467-8.522,13.818-18.045,18.829-28.349
                                l55.187,22.607C417.174,351.213,406.364,367.331,393.423,381.476z M335.288,424.577l-23.172-54.952
                                c9.889-4.925,19.047-11.088,27.269-18.293l42.091,42.091C367.774,405.96,352.22,416.499,335.288,424.577z M128.524,393.423
                                l42.091-42.091c8.522,7.467,18.045,13.818,28.349,18.829l-22.607,55.187C158.787,417.174,142.669,406.364,128.524,393.423z
                                 M85.423,335.288l54.952-23.172c4.925,9.889,11.088,19.047,18.293,27.269l-42.091,42.091
                                C104.04,367.774,93.501,352.22,85.423,335.288z M67.47,263.533h59.818c0.754,11.513,3.017,22.605,6.602,33.078l-55.018,23.2
                                C72.316,302.13,68.362,283.214,67.47,263.533z M78.257,191.893l55.251,22.633c-3.364,10.138-5.493,20.844-6.219,31.94H67.47
                                C68.334,227.417,72.071,209.085,78.257,191.893z M116.577,128.523l42.091,42.091c-7.467,8.522-13.818,18.045-18.829,28.349
                                l-55.187-22.607C92.826,158.787,103.636,142.668,116.577,128.523z M174.712,85.423l23.172,54.952
                                c-9.889,4.925-19.047,11.088-27.269,18.293l-42.091-42.091C142.226,104.04,157.78,93.501,174.712,85.423z M381.477,116.577
                                l-42.091,42.091c-8.522-7.467-18.045-13.818-28.349-18.829l22.607-55.187C351.213,92.826,367.331,103.636,381.477,116.577z
                                 M424.577,174.712l-54.952,23.172c-4.925-9.889-11.088-19.047-18.293-27.269l42.091-42.091
                                C405.96,142.226,416.499,157.78,424.577,174.712z M442.53,246.467h-59.818c-0.754-11.513-3.017-22.605-6.602-33.078l55.018-23.2
                                C437.685,207.87,441.638,226.786,442.53,246.467z M298.597,357.09c-0.313,0.088-0.624,0.188-0.93,0.31
                                c-0.329,0.131-0.637,0.289-0.935,0.46c-12.873,5.204-26.955,8.074-41.732,8.074c-45.947,0-85.208-27.681-102.09-67.336
                                c-0.088-0.313-0.188-0.625-0.31-0.931c-0.132-0.329-0.29-0.637-0.46-0.935c-5.204-12.872-8.074-26.955-8.074-41.732
                                c0-45.604,27.271-84.618,66.452-101.704c0.491-0.118,1.068-0.323,1.814-0.695c0.329-0.132,0.637-0.29,0.935-0.46
                                c12.872-5.204,26.955-8.074,41.732-8.074c45.947,0,85.209,27.681,102.09,67.336c0.088,0.313,0.188,0.624,0.31,0.93
                                c0.18,0.721,0.48,1.361,0.864,1.929c4.952,12.601,7.669,26.341,7.669,40.737C365.933,300.947,338.252,340.209,298.597,357.09z
                                 M295.474,133.508c-10.138-3.364-20.844-5.493-31.94-6.219V67.47c19.05,0.863,37.382,4.601,54.573,10.786L295.474,133.508z
                                 M246.467,127.288c-11.513,0.754-22.605,3.017-33.078,6.602l-23.2-55.018c17.682-6.557,36.598-10.51,56.279-11.402V127.288z
                                 M214.526,376.492c10.138,3.364,20.844,5.493,31.94,6.219v59.818c-19.05-0.863-37.382-4.601-54.573-10.786L214.526,376.492z
                                 M263.533,382.712c11.513-0.754,22.605-3.017,33.078-6.602l23.2,55.018c-17.682,6.557-36.598,10.51-56.279,11.402V382.712z
                                 M376.492,295.474c3.364-10.138,5.493-20.844,6.219-31.94h59.818c-0.863,19.05-4.601,37.382-10.786,54.573L376.492,295.474z"/>
                    </g>
                </g>
            </g>
        </symbol>
        
      </svg>
      <main>
        <div class="d-flex flex-column flex-shrink-0 bg-dark" style="width: 5em;min-height: 100%;position: fixed;">
          <a href="/" class="d-block p-3 link-dark text-center" title="Icon-only" data-bs-toggle="tooltip" data-bs-placement="right">
            <svg class="bi" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
            <span class="visually-hidden">Icon-only</span>
          </a>
          <ul class="nav nav-pills nav-flush flex-column mb-auto text-center">
            <li class="nav-item">
              <a href="#" class="nav-link active py-3" aria-current="page" title="Home" data-bs-toggle="tooltip" data-bs-placement="right">
                <svg class="bi" width="24" height="24" role="img" aria-label="Home"><use xlink:href="#home"/></svg>
              </a>
            </li>
            <li>
              <a href="#" class="nav-link py-3" title="Dashboard" data-bs-toggle="tooltip" data-bs-placement="right">
                <svg class="bi" width="24" height="24" role="img" aria-label="Dashboard"><use xlink:href="#speedometer2"/></svg>
              </a>
            </li>
            <li>
              <a href="#" class="nav-link py-3" title="Orders" data-bs-toggle="tooltip" data-bs-placement="right">
                <svg class="bi" width="24" height="24" role="img" aria-label="Orders"><use xlink:href="#table"/></svg>
              </a>
            </li>
            <li>
              <a href="#" class="nav-link py-3" title="Products" data-bs-toggle="tooltip" data-bs-placement="right">
                <svg class="bi" width="24" height="24" role="img" aria-label="Products"><use xlink:href="#grid"/></svg>
              </a>
            </li>
            <li>
              <a href="#" class="nav-link py-3" title="Customers" data-bs-toggle="tooltip" data-bs-placement="right">
                <svg class="bi" width="24" height="24" role="img" aria-label="Customers"><use xlink:href="#people-circle"/></svg>
              </a>
            </li>
          </ul>
          
        </div>
      
        <div class="container">
            <div class="row">
                <div class="col" style="padding: 1em;padding-bottom: 0.5em;">
                    <img src="${pageContext.request.contextPath}/image/map3.png" class="img-fluid" alt="image error" style="border: 1px white solid;border-radius: 1.8rem!important;">
                </div>
            </div>
            <div class="row" style="height: 8em;padding: 0.5em;padding-left: 1em;padding-right: 1em;">
                <div class="col statusBar">
                    <div class="ratio ratio-1x1 statusBarObj" style="width: 6em;">
                        <img class="agv" src="${pageContext.request.contextPath}/image/agv_250.png" alt="image error">
                    </div>
                    <div class="ratio ratio-1x1 statusBarObj" style="width: 6em;">
                        <div class="canvas-wrap">
                            <canvas class="cover-fit" id="AGV_battery_1"></canvas>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightning-charge" viewBox="0 0 16 16">
                                <path d="M11.251.068a.5.5 0 0 1 .227.58L9.677 6.5H13a.5.5 0 0 1 .364.843l-8 8.5a.5.5 0 0 1-.842-.49L6.323 9.5H3a.5.5 0 0 1-.364-.843l8-8.5a.5.5 0 0 1 .615-.09zM4.157 8.5H7a.5.5 0 0 1 .478.647L6.11 13.59l5.732-6.09H9a.5.5 0 0 1-.478-.647L9.89 2.41 4.157 8.5z"/>
                            </svg>
                            <p id="battery1"></p>
                            <label>Battery</label>
                        </div>
                    </div>
                    <div class="ratio ratio-1x1 statusBarObj" style="width: 6em;">
                        <svg class="bi bi-wifi-off wifi" width="16" height="16" viewBox="0 0 16 16"><use id="agvSignal1" xlink:href="#wifi-unconnect"/></svg>
                    </div>
                    <div class="statusBarObj" style="width: 28.803em;">
                        <div class="statusBarObjCircle agvWheelBK">
                            <svg class="bi agvWheel" width="16" height="16" viewBox="0 0 16 16"><use id="agvWheel1" xlink:href="#wheel">
                                <animateTransform attributeName="transform" attributeType="XML"
                                    type="rotate" from="0 8 8" to="360 8 8" dur="3s"
                                    repeatCount="indefinite" /></use></svg>
                        </div>
                        <div class="statusBarObjCircle agvStopBK">
                            <svg class="bi bi-sign-stop agvStop" width="16" height="16" viewBox="0 0 16 16"><use id="agvStop1" xlink:href="#stop"/></svg>
                        </div>
                        <div class="statusBarObjCircle agvCollisionBK">
                            <svg class="bi agvCollision" width="16" height="16" viewBox="0 0 16 16"><use id="agvCollision1" xlink:href="#collision"/></svg>
                        </div>
                        <div class="statusBarObjCircle agvObstacleBK">
                            <svg class="bi agvObstacle" width="16" height="16" viewBox="0 0 16 16"><use id="agvObstacle1" xlink:href="#obstacle"/></svg>
                        </div>
                        <div class="statusBarObjCircle"></div>
                        <div class="statusBarObjCircle"></div>
                    </div>
                </div>
                <div class="col statusBar">
                    <div class="ratio ratio-1x1 statusBarObj" style="width: 6em;">
                        <img class="agv" src="${pageContext.request.contextPath}/image/agv_250.png" alt="image error">
                    </div>
                    <div class="ratio ratio-1x1 statusBarObj" style="width: 6em;">
                        <div class="canvas-wrap">
                            <canvas class="cover-fit" id="AGV_battery_2"></canvas>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightning-charge" viewBox="0 0 16 16">
                                <path d="M11.251.068a.5.5 0 0 1 .227.58L9.677 6.5H13a.5.5 0 0 1 .364.843l-8 8.5a.5.5 0 0 1-.842-.49L6.323 9.5H3a.5.5 0 0 1-.364-.843l8-8.5a.5.5 0 0 1 .615-.09zM4.157 8.5H7a.5.5 0 0 1 .478.647L6.11 13.59l5.732-6.09H9a.5.5 0 0 1-.478-.647L9.89 2.41 4.157 8.5z"/>
                            </svg>
                            <p id="battery2"></p>
                            <label>Battery</label>
                        </div>
                    </div>
                    <div class="ratio ratio-1x1 statusBarObj" style="width: 6em;">
                        <svg class="bi bi-wifi-off wifi" width="16" height="16" viewBox="0 0 16 16"><use id="agvSignal1" xlink:href="#wifi-unconnect"/></svg>
                    </div>
                    <div class="statusBarObj" style="width: 28.803em;">
                        <div class="statusBarObjCircle">
                            <svg class="bi agvWheel circleDisable" width="16" height="16" viewBox="0 0 16 16"><use id="agvWheel1" xlink:href="#wheel">
                                </use></svg>
                        </div>
                        <div class="statusBarObjCircle">
                            <svg class="bi bi-sign-stop agvStop circleDisable" width="16" height="16" viewBox="0 0 16 16"><use id="agvStop1" xlink:href="#stop"/></svg>
                        </div>
                        <div class="statusBarObjCircle">
                            <svg class="bi agvCollision circleDisable" width="16" height="16" viewBox="0 0 16 16"><use id="agvCollision1" xlink:href="#collision"/></svg>
                        </div>
                        <div class="statusBarObjCircle">
                            <svg class="bi agvObstacle circleDisable" width="16" height="16" viewBox="0 0 16 16"><use id="agvObstacle1" xlink:href="#obstacle"/></svg>
                        </div>
                        <div class="statusBarObjCircle"></div>
                        <div class="statusBarObjCircle"></div>
                    </div>
                </div>
            </div>
        </div>
      </main>
    </body>
</html>
