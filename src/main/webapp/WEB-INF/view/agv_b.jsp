<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>元創智動系統</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pure-min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/yid.css">
        <style>
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
        </style>
        <script src="https://code.jquery.com/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4"></script>
        <script>
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
    </script>
    </head>
    <!--<body background="${pageContext.request.contextPath}/image/bgimg.jpg" style="padding: 20px;line-height: 10px;">-->
    <body style="padding: 0px;line-height: 10px; background-color: #000000;color: white;">
        <img src="${pageContext.request.contextPath}/image/2023AGVS_UI_1280_800_top.png" alt="image error" style="max-width:100%;">
        <br>
        <span id="agv_car_1"></span>
        <span id="agv_car_2"><img src="${pageContext.request.contextPath}/image/icon_mp.png" width="50"
                                                               style="position: absolute;left: 900px;top: 90px;z-index: 10" /></span>
        <span id="agv_car_3"><img src="${pageContext.request.contextPath}/image/icon_mp.png" width="50"
                                                               style="position: absolute;left: 1011px;top: 90px;z-index: 10" /></span>
        <div class="container" style=" max-width: 1280px;padding: 60px;padding-top: 0px;">
            <div class="row" style="padding: 5px; padding-top: 10px">
                <div class="col card" style="background-color: #2E3327;">
                    <img src="${pageContext.request.contextPath}/image/map.png" class="img-fluid" alt="image error">
                </div>
            </div>
            <div class="row" style="padding: 5px;">
                <div class="col card" style="height: 7em;background-color: #2E3327;text-align: center;">
                    <fieldset>
                        <legend style=" padding: 5px;font-size: 18px;">
                            <img src="${pageContext.request.contextPath}/image/icon_1.png" alt="image error">
                            佇列任務
                        </legend>
                    </fieldset>
                </div>    
            </div>
            <div class="row">
                <div class="col" style=" text-align: center;font-size: 10px;padding: 5px;">
                    <div class="row" style="padding-bottom: 0px;">
                        <div class="col">
                            <div class="card" style="height: 20.8em;background-color: #2E3327;">
                                <fieldset>
                                    <legend style=" padding: 5px;font-size: 18px;">
                                        <img src="${pageContext.request.contextPath}/image/icon_5.png" alt="image error">
                                        AGV 狀態
                                    </legend>
                                    <p>工作狀態：<input type="text" id="status" readonly style="text-align: center;background-color: #454D3A;color: white;"/></p>
                                    <p>目前任務：<input type="text" id="task" readonly style="text-align: center;background-color: #454D3A;color: white;"/></p>
                                    <p>即時位置：<input type="text" id="place" readonly style="text-align: center;background-color: #454D3A;color: white;"/></p>
                                    <p>目前電壓：<input type="text" id="battery" readonly style="text-align: center;background-color: #454D3A;color: white;"/></p>
                                </fieldset>
                            </div>    
                        </div>
                    </div>
                    <div class="row" style="padding-bottom: 0px;">
                        <div class="col">
                            <div class="card" style="background-color: #2E3327;">
                                <fieldset>
                                    <legend style=" padding: 5px;font-size: 18px;">
                                        <img src="${pageContext.request.contextPath}/image/icon_3.png" alt="image error">
                                        效益分析
                                        <a href="${pageContext.request.contextPath}/mvc/agv/analysis">
                                            <img style="float: right;" src="${pageContext.request.contextPath}/image/chart.png" title="統計圖表" border="0" width="40">
                                        </a>
                                    </legend>
                                    <div class="row">
                                        <div class="col CC">
                                            <p>&nbsp;&nbsp;&nbsp;累計任務數</p>
                                            <div class="ChartContainer task_sum">
                                                <canvas class="Chart" id="task_sum1"></canvas>
                                            </div>
                                        </div>
                                        <div class="col CC">
                                            <p>&nbsp;&nbsp;&nbsp;稼動率</p>
                                            <div class="ChartContainer rate">
                                                <canvas class="Chart" id="rate1"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col" style=" text-align: center;font-size: 10px;padding: 5px;">
                    <div class="row" style="padding-bottom: 0px;">
                        <div class="col">
                            <div class="card" style="height: 20.8em;background-color: #2E3327;">
                                <fieldset>
                                    <legend style=" padding: 5px;font-size: 18px;">
                                        <img src="${pageContext.request.contextPath}/image/icon_5.png" alt="image error">
                                        AGV 狀態
                                    </legend>
                                    <p>工作狀態：<input type="text" id="status" readonly style="text-align: center;background-color: #454D3A;color: white;"/></p>
                                    <p>目前任務：<input type="text" id="task" readonly style="text-align: center;background-color: #454D3A;color: white;"/></p>
                                    <p>即時位置：<input type="text" id="place" readonly style="text-align: center;background-color: #454D3A;color: white;"/></p>
                                    <p>目前電壓：<input type="text" id="battery" readonly style="text-align: center;background-color: #454D3A;color: white;"/></p>
                                </fieldset>
                            </div>    
                        </div>
                    </div>
                    <div class="row" style="padding-bottom: 0px;">
                        <div class="col">
                            <div class="card" style="background-color: #2E3327;">
                                <fieldset>
                                    <legend style=" padding: 5px;font-size: 18px;">
                                        <img src="${pageContext.request.contextPath}/image/icon_3.png" alt="image error">
                                        效益分析
                                        <a href="${pageContext.request.contextPath}/mvc/agv/analysis">
                                            <img style="float: right;" src="${pageContext.request.contextPath}/image/chart.png" title="統計圖表" border="0" width="40">
                                        </a>
                                    </legend>
                                    <div class="row">
                                        <div class="col CC">
                                            <p>&nbsp;&nbsp;&nbsp;累計任務數</p>
                                            <div class="ChartContainer task_sum">
                                                <canvas class="Chart" id="task_sum2"></canvas>
                                            </div>
                                        </div>
                                        <div class="col CC">
                                            <p>&nbsp;&nbsp;&nbsp;稼動率</p>
                                            <div class="ChartContainer rate">
                                                <canvas class="Chart" id="rate2"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col" style=" text-align: center;font-size: 10px;padding: 5px;">
                    <div class="row" style="padding-bottom: 0px;">
                        <div class="col">
                            <div class="card" style="height: 20.8em;background-color: #2E3327;">
                                <fieldset>
                                    <legend style=" padding: 5px;font-size: 18px;">
                                        <img src="${pageContext.request.contextPath}/image/icon_5.png" alt="image error">
                                        AGV 狀態
                                    </legend>
                                    <p>工作狀態：<input type="text" id="status" readonly style="text-align: center;background-color: #454D3A;color: white;"/></p>
                                    <p>目前任務：<input type="text" id="task" readonly style="text-align: center;background-color: #454D3A;color: white;"/></p>
                                    <p>即時位置：<input type="text" id="place" readonly style="text-align: center;background-color: #454D3A;color: white;"/></p>
                                    <p>目前電壓：<input type="text" id="battery" readonly style="text-align: center;background-color: #454D3A;color: white;"/></p>
                                </fieldset>
                            </div>    
                        </div>
                    </div>
                    <div class="row" style="padding-bottom: 0px;">
                        <div class="col">
                            <div class="card" style="background-color: #2E3327;">
                                <fieldset>
                                    <legend style=" padding: 5px;font-size: 18px;">
                                        <img src="${pageContext.request.contextPath}/image/icon_3.png" alt="image error">
                                        效益分析
                                        <a href="${pageContext.request.contextPath}/mvc/agv/analysis">
                                            <img style="float: right;" src="${pageContext.request.contextPath}/image/chart.png" title="統計圖表" border="0" width="40">
                                        </a>
                                    </legend>
                                    <div class="row">
                                        <div class="col CC">
                                            <p>&nbsp;&nbsp;&nbsp;累計任務數</p>
                                            <div class="ChartContainer task_sum">
                                                <canvas class="Chart" id="task_sum3"></canvas>
                                            </div>
                                        </div>
                                        <div class="col CC">
                                            <p>&nbsp;&nbsp;&nbsp;稼動率</p>
                                            <div class="ChartContainer rate">
                                                <canvas class="Chart" id="rate3"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                        </div>
                    </div>
                </div>
            </div>                            
        </div>    
        <footer style="text-align: center">
            元創智動股份有限公司版權所有  TEL:02-26087894 Email:sales@yid.com.tw
        </footer>
        
    </body>
</html>