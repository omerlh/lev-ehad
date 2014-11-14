allocationModule.controller('MainCtrl', ['$scope', 'VolunteersSvc', 'HamalsSvc', function($scope, volunteersSvc, hamalSvc) {

    $scope.currentDate = new Date(Date.now());
    $('#current_day').val($scope.currentDate.toDateString());

    $scope.pikadayObject = {
        field: document.getElementById('current_day'),
        isRTL: true,
        i18n: {
            previousMonth : 'החודש הוקדם',
            nextMonth     : 'החודש הבא',
            weekdays: ["ראשון", "שני", "שלישי", "רביעי", "חמישי", "שישי", "שבת", "ראשון"],
            weekdaysShort: ["א", "ב", "ג", "ד", "ה", "ו", "ש", "א"],
            months: ["ינואר", "פברואר", "מרץ", "אפריל", "מאי", "יוני", "יולי", "אוגוסט", "ספטמבר", "אוקטובר", "נובמבר", "דצמבר"],
        },
        onSelect: function(selectedDate) {
            $scope.currentDate = selectedDate;
            fetchVolunteers();

            $("#current_day").val(selectedDate.toDateString());
        }
    };

    $scope.$on('date_changed', function(eventArgs, newDate) {
        $scope.currentDate = newDate;
        fetch();
        $scope.$apply();
    });



    function fetchHamals() {
        hamalSvc.getStatusForDate($scope.currentDate).then(function(response) {
            $scope.hamal_statuses = response.data;
        });
    }

    function fetchVolunteers() {
        $scope.volunteers = [];
        volunteersSvc.getAvailableForDate($scope.currentDate).then(function(vols) {
            $scope.volunteers = vols.data;

            if(vols.data.length == 0) {
                toastr.info('לא נמצאו תוצאות');
            }

            $scope.volunteer = _.first($scope.volunteers);
        });
    }

    function fetch() {
        fetchVolunteers();
        fetchHamals();    
    }

    fetch();


    $scope.volunteerFieldMapping = {
        "address": 'כתובת',
        "first_name": 'שם פרטי',
        "last_name": 'שם משפחה',
        "gender": 'מין',
        "identification_number": 'תעודת זהות',
        "has_char": 'בעל רכב',
        "qualifications": 'הכשרות',
        "remarks": 'הערות',
        "age": 'גיל',
        "phone_number": 'מספר טלפון',
        "email": "כתובת דואר אלקטרוני"
    };

    $scope.onVolunteerClicked = function(volunteer) {
        $scope.volunteer = volunteer;
    };

    $scope.deallocatedVolunteer = function(volunteer) {
        volunteersSvc.deallocatedVolunteer(volunteer, $scope.currentDate).then(function() {
            removeVolunteer(volunteer);

            toastr.error('הקצאת מתנדב נמחקה');
        });
    };


    function removeVolunteer(volunteer) {
        var idx = $scope.volunteers.indexOf(volunteer);
        $scope.volunteers.splice(idx, 1);
        $scope.volunteer = _.first($scope.volunteers);
    }

    $scope.allocateVolunteer = function(allocation_request, volunteer) {
        volunteersSvc.allocatedVolunteer(allocation_request, volunteer, $scope.currentDate).then(function() {
            removeVolunteer(volunteer);
        
            toastr.info('המתנדב שובץ בהצלחה');

            fetchHamals();
        });
    }

    window.onbeforeunload = function() {
        $.ajax({url: "/volunteer_availability/freeVolunteers", type: "GET"});
    };
}]);
