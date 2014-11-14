/*allocationModule.service('VolunteersSvc', ['$http', function($http) {

    return {
        getAvailableForDate: function(date) {
            return $http.get("/allocation/available_volunteers/?date=" + date.toDateString());
        }

    }
}]);

allocationModule.service('HamalsSvc', ['$http', function($http) {

    return {
        getStatusForDate: function(date) {
            return $http.get("/allocation/hamals_status/?date=" + date.toDateString());
        }

    }
}]);*/

statisticsModule.service('StatisticsService', ['$http', function($http) {

    return {
        getSumOfVolunteers: function(start_day, end_day) {
            return $http.get("/statistics/sum_volunteers/?start_day=" + start_day.toDateString() + "&end_day=" + end_day.toDateString());
        }

    }
}]);