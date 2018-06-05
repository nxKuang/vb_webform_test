<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-1.12.0.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/drilldown.js"></script>
    <!--[if lt IE 9]>
<script src="https://code.highcharts.com/modules/oldie.js"></script>
<![endif]-->
    <script>
        $(document).ready(function () {
            Highcharts.setOptions({
                lang: {
                    drillUpText: ' < Back to previous'
                }
            })

            ajaxGetData();

            $("#testClick1").on("click", function () {
                ajaxGetData()
            });
        });

        function ajaxGetData() {

            $.ajax({
                type: "POST",
                url: "default.aspx/getHighChartMain",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ pcCode: "" }),
                dataType: "json",
                success: function (response) {
                    var result = JSON.parse(response.d);

                    drawChart(result);
                }
            })
        }

        function drawChart(data) {
            $('#container').highcharts({
                chart: {
                    events: {
                        drilldown: function (e) {
                            if (!e.seriesOptions) {
                                var chart = this,
                                    drilldowns = {
                                        'S1': {
                                            name: 'inflow',
                                            type: 'column',
                                            color: '#3150b4'
                                        },
                                        'S2': {
                                            name: 'outflow',
                                            type: 'column',
                                            color: '#50B432'
                                        },
                                        'S3': {
                                            name: 'NNM',
                                            type: 'spline',
                                            color: '#000000'
                                        }

                                    }
                                chart.showLoading('Loading data ...');
                                setTimeout(function () {
                                    $.ajax({
                                        type: "POST",
                                        url: "default.aspx/getHighChartDrilldown",
                                        contentType: "application/json; charset=utf-8",
                                        data: JSON.stringify({ varDrillDown: e.point.name }),
                                        dataType: "json",
                                        success: function (response) {
                                            //console.log("ajax call success ");
                                            //var data = {
                                            //        S1: [['D1', 2], ['D2', 3], ['D3', 3]],
                                            //        S2: [['D1', 8], ['D2', 7], ['D3', 3]],
                                            //        S3: [['D1', 6], ['D2', 4], ['D3', 3]]
                                            //}  
                                            //console.log(data);   
                                            var result = JSON.parse(response.d);
                                            //console.log(result);
                                            for (x in drilldowns) {
                                                drilldowns[x]['data'] = result[x];
                                                chart.addSingleSeriesAsDrilldown(e.point, drilldowns[x]);
                                            }
                                            chart.hideLoading();
                                            chart.applyDrilldown();

                                        },
                                        failure: function (response) {
                                            console.log("ajax call failure: " + response);
                                        }
                                    });
                                }, 5000);
                            }
                        }
                    }
                },
                title: {
                    text: 'Async drilldown'
                },
                xAxis: {
                    type: 'category'
                },
                legend: {
                    enabled: false
                },
                plotOptions: {
                    column: { stacking: 'normal' },
                    series: {
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            style: { textShadow: false, fontSize: '1vw' }
                        }
                    }
                },
                series: [{
                    name: 'outflow',
                    type: 'column',
                    color: '#3150b4',
                    data: data.S1
                }, {
                    name: 'inflow',
                    type: 'column',
                    color: '#50B432',
                    data: data.S2
                }
                    , {
                    name: 'NNM',
                    type: 'spline',
                    color: '#000000',
                    data: data.S3
                }],
                drilldown: {
                    series: []
                }

            });


        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="testClick1">Click to refresh data</div>
        <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
        <div id="testClick2">test 2</div>
    </form>
</body>
</html>
