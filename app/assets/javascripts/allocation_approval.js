//= require allocations/module
//= require allocations/volunteerSvc
//= require toastr

allocationModule.controller('MainCtrl', ['$scope', 'VolunteersSvc', function($scope, volunteersSvc) {

    $scope.currentDate = new Date(Date.now());

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
        }
    };

    var isListeningToDateChanged = false;
    

    $scope.$watch('selectedHaml', function() {
        fetchVolunteers();

        if(!isListeningToDateChanged) {
            isListeningToDateChanged = true;
            $scope.$on('date_changed', function(eventArgs, newDate) {
                $scope.currentDate = newDate;
                fetchVolunteers();
                $scope.$apply();
            });
        }
    });






    function fetchVolunteers() {
        $scope.volunteers = [];
        
        if($scope.selectedHaml === undefined) {
            $scope.selectedHaml = _.first($scope.hamals);
        }

        volunteersSvc.getAllocatedForDate($scope.currentDate, $scope.selectedHaml.id).then(function(vols) {
            $scope.volunteers = vols.data;

            if(vols.data.length == 0) {
                toastr.info('לא נמצאו תוצאות');
            }

            $scope.volunteer = _.first($scope.volunteers);
        });
    }



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

    

    function removeVolunteer(volunteer) {
        var idx = $scope.volunteers.indexOf(volunteer);
        $scope.volunteers.splice(idx, 1);
        $scope.volunteer = _.first($scope.volunteers);
    }

    $scope.denyVolunteer = function(volunteer) {
        var reason = prompt("Reason?"); 
        volunteersSvc.denyVolunteer(volunteer.id, $scope.selectedHaml.id, $scope.currentDate, reason)
                 .then(function() {
                        toastr.error('המתנדב נדחה');
                        removeVolunteer(volunteer);

                 });
    };

	$scope.approveVolunteer = function(volunteer) {
        volunteersSvc.approveVolunteer(volunteer.id, $scope.selectedHaml.id, $scope.currentDate)
                 .then(function() {
                        toastr.error('המתנד נדחה');
                        removeVolunteer(volunteer);

                 });
    };    
}]);














