$(function() {
    if (!($('.tournaments.new').length > 0 || $('.tournaments.create').length > 0)) {
        return;
    }

    let today = new Date();
    let mindate = new Date();
    if (today.getDay() == 6) { // Saturday
        mindate.setDate(today.getDate() + 2);
    } else if (today.getDay() == 0) { // Sunday
        mindate.setDate(today.getDate() + 1);
    }
    $('.datepicker').pickadate({
        min: mindate,
        disable: [2, 3, 4, 5, 6]
    });
    $('.timepicker').pickatime();
});
