<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>元創智動系統 | 分析頁面</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/yid.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/yiddemoroomanalysis.css">
        
        <style>
            @font-face{
                font-family: NewFont;
                src: url("${pageContext.request.contextPath}/css/US101.TTF");
                font-weight: bold;
            }
            @media print {
                .container-fluid{
                    display: none;
                }
                .printt{
                    display: flow;
                }
            }
        </style>
        <script src="https://code.jquery.com/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.3.0"></script>
        <script src="https://bootstrap5.hexschool.com/docs/5.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
        <script>
            var contextPath = '${pageContext.request.contextPath}';
        </script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/yiddemoroomanalysis.js"></script>
    </head>
    <body>
        <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
            <symbol id="bootstrap" viewBox="0 0 118 94">
            <title>Bootstrap</title>
            <path fill-rule="evenodd" clip-rule="evenodd" d="M24.509 0c-6.733 0-11.715 5.893-11.492 12.284.214 6.14-.064 14.092-2.066 20.577C8.943 39.365 5.547 43.485 0 44.014v5.972c5.547.529 8.943 4.649 10.951 11.153 2.002 6.485 2.28 14.437 2.066 20.577C12.794 88.106 17.776 94 24.51 94H93.5c6.733 0 11.714-5.893 11.491-12.284-.214-6.14.064-14.092 2.066-20.577 2.009-6.504 5.396-10.624 10.943-11.153v-5.972c-5.547-.529-8.934-4.649-10.943-11.153-2.002-6.484-2.28-14.437-2.066-20.577C105.214 5.894 100.233 0 93.5 0H24.508zM80 57.863C80 66.663 73.436 72 62.543 72H44a2 2 0 01-2-2V24a2 2 0 012-2h18.437c9.083 0 15.044 4.92 15.044 12.474 0 5.302-4.01 10.049-9.119 10.88v.277C75.317 46.394 80 51.21 80 57.863zM60.521 28.34H49.948v14.934h8.905c6.884 0 10.68-2.772 10.68-7.727 0-4.643-3.264-7.207-9.012-7.207zM49.948 49.2v16.458H60.91c7.167 0 10.964-2.876 10.964-8.281 0-5.406-3.903-8.178-11.425-8.178H49.948z"></path>
            </symbol>
            <symbol id="yid" viewBox="0 0 16 16">
                <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13a.5.5 0 0 1 0 1 .5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1 0-1 .5.5 0 0 1 0-1 .5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm6-5a5 5 0 0 0-3.479 8.592c.263.254.514.564.676.941L5.83 12h4.342l.632-1.467c.162-.377.413-.687.676-.941A5 5 0 0 0 8 1z"/>
            </symbol>
            <symbol id="home" viewBox="0 0 16 16">
            <path d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z"/>
            </symbol>
            <symbol id="send" viewBox="0 0 16 16">
                <path d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576 6.636 10.07Zm6.787-8.201L1.591 6.602l4.339 2.76 7.494-7.493Z"/>
            </symbol>
            <symbol id="analysis" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M0 0h1v15h15v1H0V0Zm14.817 3.113a.5.5 0 0 1 .07.704l-4.5 5.5a.5.5 0 0 1-.74.037L7.06 6.767l-3.656 5.027a.5.5 0 0 1-.808-.588l4-5.5a.5.5 0 0 1 .758-.06l2.609 2.61 4.15-5.073a.5.5 0 0 1 .704-.07Z"/>
            </symbol>
            <symbol id="list" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M5 11.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zm-3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm0 4a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm0 4a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
            </symbol>
            <symbol id="setting" viewBox="0 0 16 16">
                <path d="M8 4.754a3.246 3.246 0 1 0 0 6.492 3.246 3.246 0 0 0 0-6.492zM5.754 8a2.246 2.246 0 1 1 4.492 0 2.246 2.246 0 0 1-4.492 0z"/>
                <path d="M9.796 1.343c-.527-1.79-3.065-1.79-3.592 0l-.094.319a.873.873 0 0 1-1.255.52l-.292-.16c-1.64-.892-3.433.902-2.54 2.541l.159.292a.873.873 0 0 1-.52 1.255l-.319.094c-1.79.527-1.79 3.065 0 3.592l.319.094a.873.873 0 0 1 .52 1.255l-.16.292c-.892 1.64.901 3.434 2.541 2.54l.292-.159a.873.873 0 0 1 1.255.52l.094.319c.527 1.79 3.065 1.79 3.592 0l.094-.319a.873.873 0 0 1 1.255-.52l.292.16c1.64.893 3.434-.902 2.54-2.541l-.159-.292a.873.873 0 0 1 .52-1.255l.319-.094c1.79-.527 1.79-3.065 0-3.592l-.319-.094a.873.873 0 0 1-.52-1.255l.16-.292c.893-1.64-.902-3.433-2.541-2.54l-.292.159a.873.873 0 0 1-1.255-.52l-.094-.319zm-2.633.283c.246-.835 1.428-.835 1.674 0l.094.319a1.873 1.873 0 0 0 2.693 1.115l.291-.16c.764-.415 1.6.42 1.184 1.185l-.159.292a1.873 1.873 0 0 0 1.116 2.692l.318.094c.835.246.835 1.428 0 1.674l-.319.094a1.873 1.873 0 0 0-1.115 2.693l.16.291c.415.764-.42 1.6-1.185 1.184l-.291-.159a1.873 1.873 0 0 0-2.693 1.116l-.094.318c-.246.835-1.428.835-1.674 0l-.094-.319a1.873 1.873 0 0 0-2.692-1.115l-.292.16c-.764.415-1.6-.42-1.184-1.185l.159-.291A1.873 1.873 0 0 0 1.945 8.93l-.319-.094c-.835-.246-.835-1.428 0-1.674l.319-.094A1.873 1.873 0 0 0 3.06 4.377l-.16-.292c-.415-.764.42-1.6 1.185-1.184l.292.159a1.873 1.873 0 0 0 2.692-1.115l.094-.319z"/>
            </symbol>
        </svg>
        <main>
            <div class="d-flex flex-column flex-shrink-0" style="width: 5em;min-height: 100%;position: fixed;">
                <a href="https://www.yid.com.tw/" class="d-block p-3 link-dark text-center">
                    <svg class="bi" width="32" height="32"><use xlink:href="#yid"/></svg>
                    <span class="visually-hidden">Icon-only</span>
                </a>
                <ul class="nav nav-pills nav-flush flex-column mb-auto text-center">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/mvc/agv/" class="nav-link py-3">
                            <svg class="bi" width="24" height="24" role="img"><use xlink:href="#home"/></svg>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/mvc/agv/send" class="nav-link py-3">
                            <svg class="bi" width="24" height="24" role="img"><use xlink:href="#send"/></svg>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/mvc/agv/analysis" class="nav-link py-3 active">
                            <svg class="bi" width="24" height="24" role="img"><use xlink:href="#analysis"/></svg>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/mvc/agv/history" class="nav-link py-3">
                            <svg class="bi" width="24" height="24" role="img"><use xlink:href="#list"/></svg>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="nav-link py-3">
                            <svg class="bi" width="24" height="24" role="img"><use xlink:href="#setting"/></svg>
                        </a>
                    </li>
                </ul>
            </div>
            
            <div class="container">
                <div class="row">
                    <div class="col Title">
                        <label class="title page">Analysis</label>
                    </div>
                </div>
                <div class="row">
                    <div class="col" style="text-align: left;">
                        <div id="agvOption" class="btn-group" role="group" aria-label="Basic radio toggle button group">
                            
                        </div>
                        &nbsp;
                        <div class="btn-group" role="group" aria-label="Basic example">
                            <button type="button" class="btn btn-outline-primary" onclick="reSet('recently')">最近兩週</button>
                            <div class="btn-group" role="group">
                                <button id="btnGroupDrop1" type="button" class="btn btn-outline-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                    月
                                </button>
                                <ul id="yearsandmonths" class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                </ul>
                            </div>
                        </div>
                        &nbsp;
                        <!-- Button trigger modal -->
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">列印表單</button>
                        <button type="button" class="btn btn-primary" onclick="myexcel()">匯出成Excel</button>
                        <!-- Modal -->
                        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">確認列印表單</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div id="printt">
                                            <img src="${pageContext.request.contextPath}/image/logo.png" alt="image error" border="0" id="logog">
                                            <h1 id="printOutAGV">AGV#1</h1>
                                            <table id="va" class="table">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">日期</th>
                                                        <th scope="col">任務數</th>
                                                        <th scope="col">稼動率</th>
                                                        <th scope="col">工作時數</th>
                                                        <th scope="col">開機時數</th>
                                                        <th>
                                                            <input type="checkbox" id="checkAll" checked/>
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody id="pt">
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <div>
                                            <input type="checkbox" id="cancelweekend">
                                            <label for="cancelweekend">
                                                取消選取六日
                                            </label>
                                        </div>
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">關閉</button>
                                        <button type="button" class="btn btn-primary" onclick="printOut()">列印</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" style=" justify-content: center;padding-top: 1.5em;">
                    <div class="col-11" style="background-color: #3E3A39;border-radius: 0.6rem!important;">
                        <div id="legend-container"></div>
                        <canvas class="my-4 w-100" id="myChart" width="900" height="380"></canvas>
                    </div>
                </div>
                <hr size="4px" align="center" width="100%" color="white">
                <div class="row" style="justify-content: center;">
                    <div id="summ" class="col-11" style="background-color: #3E3A39;border-radius: 0.6rem!important;">
                        <table class="table table-borderless" style=" align-items: center;text-align: center;color: #9E9E9E;">
                            <thead>
                                <tr>
                                    <th>總任務數量</th>
                                    <th>平均任務數</th>
                                    <th>總開機時數</th>
                                    <th>總工作時數</th>
                                    <th>平均工作時數</th>
                                    <th>平均稼動率</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr style=" font-size: 1.5em">
                                    <td><p><input class="parse" type="text" id="task_sum" readonly/></p></td>
                                    <td><p><input class="parse" type="text" id="task" readonly/></p></td>
                                    <td><p><input class="parse" type="text" id="open_sum" readonly/></p></td>
                                    <td><p><input class="parse" type="text" id="work_sum" readonly/></p></td>
                                    <td><p><input class="parse" type="text" id="work" readonly/></p></td>
                                    <td><p><input class="parse" type="text" id="rate" readonly/></p></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <footer>
                    元創智動股份有限公司版權所有  TEL:02-26087894 Email:sales@yid.com.tw
                </footer>
            </div>
        </main>
    </body>
</html>
