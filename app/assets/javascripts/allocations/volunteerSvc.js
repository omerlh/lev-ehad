allocationModule.service('VolunteersSvc', ['$http', function($http) {

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
}]);