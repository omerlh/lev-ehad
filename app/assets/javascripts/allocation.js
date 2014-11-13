//= require jquery
//= require pikaday
//= require angular
//= require libs/pikaday-angular
//= require libs/lodash

var allocationModule = angular.module('allocationModule', ['angularPikaday']);

allocationModule.service('VolunteersSvc', ['$http', function($http) {

    return {
        getAvailableForDate: function(date) {
            return $http.get("/allocation/available_volunteers/?date=" + date.toDateString());
        }

    }
}]);



allocationModule.controller('MainCtrl', ['$scope', 'VolunteersSvc', function($scope, volunteersSvc) {

    var $volunteersGrid = angular.element("#volunteersGrid");
    $volunteersGrid.css("width", $volunteersGrid.width() + "px");

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
        fetchVolunteers();
        $scope.$apply();
    });



    function fetchVolunteers() {
        $scope.volunteers = [];
        volunteersSvc.getAvailableForDate($scope.currentDate).then(function(vols) {
            $scope.volunteers = vols.data;
            $scope.volunteer = formatVolunteer($scope.volunteers[0]);
        });
    }


    fetchVolunteers();



    function formatVolunteer(volunteer) {
        return _.pick(volunteer, _.keys($scope.volunteerFieldMapping))
    }

    $scope.volunteerFieldMapping = {
        "address": 'כתובת',
        "first_name": 'שם פטרי',
        "last_name": 'שם משפחה',
        "gender": 'מין',
        "identification_number": 'תעודת זהות',
        "has_char": 'בעל רכב',
        "qualifications": 'הכשרות',
        "remarks": 'הערות',
        "age": 'גיל',
        "phone_number": 'מספר טלפון'
    };

    $scope.onVolunteerClicked = function(volunteer) {
        $scope.volunteer = formatVolunteer(volunteer);
    };
}]);



