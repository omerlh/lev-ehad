allocationModule.service('VolunteersSvc', ['$http', function($http) {

    return {
        getAvailableForDate: function(date) {
            return $http.get("/allocation/available_volunteers/?date=" + date.toDateString());
        },

        deallocatedVolunteer: function(volunteer, date) {
          return $http.post("/allocation/dealloc_volunteer?volunteer_id=" + volunteer.id + "&date=" + date.toDateString());  
        },

        allocatedVolunteer: function(allocation_request, volunteer, date) {
          return $http.post("/allocation/allocate_volunteer?allocation_request_id=" + allocation_request.allocation_request_id + "&volunteer_id=" + volunteer.id + "&date=" + date.toDateString());   
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