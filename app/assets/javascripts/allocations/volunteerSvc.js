allocationModule.service('VolunteersSvc', ['$http', function($http) {

    return {
        getAvailableForDate: function(date) {
            return $http.get("/allocation/available_volunteers/?date=" + date.toDateString());
        },

        deallocatedVolunteer: function(volunteer, date) {
          return $http.post("/allocation/dealloc_volunteer?volunteer_id=" + volunteer.id + "&date=" + date.toDateString());  
        },

        allocatedVolunteer: function(allocation_request, volunteer, date) {
          return $http.post("/allocation/allocate_volunteer?allocation_request_id=" + allocation_request.allocation_request_id + "&hamal_id=" + allocation_request.hamal_id + "&volunteer_id=" + volunteer.id + "&date=" + date.toDateString());   
        },

        getAllocatedForDate: function(date, hamal_id) {
            return $http.get("/allocation_approval/available_volunteers?date=" + date.toDateString() + "&hamal_id=" + hamal_id);
        },

        denyVolunteer: function(volunteer_id, hamal_id, date, reason) {
              return $http.post("/allocation_approval/deny_volunteer?volunteer_id=" + volunteer_id + "&reason=" + reason + "&date=" + date.toDateString() + "&hamal_id=" + hamal_id);  
        },

        approveVolunteer: function(volunteer_id, hamal_id, date) {
          return $http.post("/allocation_approval/approve_volunteer?volunteer_id=" + volunteer_id + "&date=" + date.toDateString() + "&hamal_id=" + hamal_id);  
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