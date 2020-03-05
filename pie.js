<script src="https://cdn.bootcss.com/echarts/4.6.0/echarts.min.js"></script>

<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<span id="main" style="width: 320px;height:320px;"></span>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));
    // 指定图表的配置项和数据
    var option = {
            title : {
                text: '各金融资产比重',
                subtext: '纯属虚构',
                x:'center'
            },
            tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            series : [
                {
                    name: '金融资产',
                    type: 'pie',
                    radius : '55%',
                    center: ['50%', '60%'],
                    data: [
                        {value:335, name:'债券'},
                        {value:310, name:'基金'},
                        {value:234, name:'现金及等价物'},
                        {value:135, name:'金融衍生品'},
                        {value:1548, name:'股票'}
                    ],
                    itemStyle: {
                        emphasis: {
                             shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>
