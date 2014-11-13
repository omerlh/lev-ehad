allocationModule.controller('MainCtrl', ['$scope', 'VolunteersSvc', 'HamalsSvc', function($scope, volunteersSvc, hamalSvc) {

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
            $scope.volunteer = formatVolunteer($scope.volunteers[0]);
        });
    }

    function fetch() {
        fetchVolunteers();
        fetchHamals();    
    }

    fetch();

    



    function formatVolunteer(volunteer) {
        return _.pick(volunteer, _.keys($scope.volunteerFieldMapping))
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
        $scope.volunteer = formatVolunteer(volunteer);
    };

    window.onbeforeunload = function(e) {
        $.ajax({url: "../volunteer_availability/freeVolunteers", type: "GET"});
        return "Woopy";
    }
}]);
