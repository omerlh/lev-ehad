statisticsModule.controller('MainCtrl', ['$scope', 'StatisticsService', function($scope, statisticsService) {




    $scope.chartConfig = {
        options: {
            chart: {
                type: 'line',
                inverted: false
            }
        },
        title:{
            text: "כמות מתנדבים ששובצו"
        },
        legend: {
            enabled: false
        },
        xAxis: {
            dateTimeLabelFormats: {
                month: '%e. %b'
            },
            type: 'datetime',
            title: {
                text: "Date"
            }
        },
        series: [

        ],

        loading: false
    }

    $scope.calculate_volunteers = function(startDay, endDay) {
        var res = statisticsService.getSumOfVolunteers(startDay,endDay).then(function(response) {
            //$scope.chartConfig.series.push(response.data);
            var data = []
            for (var prop in response.data)
            {
                data.push([new Date(prop), response.data[prop]]);
            }
            $scope.chartConfig.series.push({data: data, pointInterval: 24 * 3600 * 1000, pointStart: Date.UTC(2014,0,1)});
        });
    }

    $scope.hamals = {
        "key1": "val1",
        "key2": "val2"
    }

    $scope.selectedHamal = "key1";
}]);
