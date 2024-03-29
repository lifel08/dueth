'use strict';

var CalendarList = [];


function CalendarInfo() {
    this.id = null;
    this.name = null;
    this.checked = true;
    this.color = null;
    this.bgColor = null;
    this.borderColor = null;
    this.dragBgColor = null;
}

function addCalendar(calendar) {
    CalendarList.push(calendar);
}

function findCalendar(id) {
    var found;

    CalendarList.forEach(function (calendar) {
        if (calendar.id === id) {
            found = calendar;
        }
    });

    return found || CalendarList[0];
}



function hexToRGBA(hex) {
    var radix = 16;
    var r = parseInt(hex.slice(1, 3), radix),
        g = parseInt(hex.slice(3, 5), radix),
        b = parseInt(hex.slice(5, 7), radix),
        a = parseInt(hex.slice(7, 9), radix) / 255 || 1;
    var rgba = 'rgba(' + r + ', ' + g + ', ' + b + ', ' + a + ')';

    return rgba;
}

(function () {
    var calendar;
    var id = 0;

    calendar = new CalendarInfo();
    id += 1;
    calendar.id = String(id);
    // calendar.name = 'Pending';
    calendar.color = '#624AC0';
    calendar.bgColor = '#F0EFF6';
    calendar.dragBgColor = '#F0EFF6';
    calendar.borderColor = '#F0EFF6';
    addCalendar(calendar);

    // calendar = new CalendarInfo();
    // id += 1;
    // calendar.id = String(id);
    // calendar.name = 'Events';
    // calendar.color = '#FF8C1A';
    // calendar.bgColor = '#FDF8F3';
    // calendar.dragBgColor = '#FDF8F3';
    // calendar.borderColor = '#FDF8F3';
    // addCalendar(calendar);
    //
    // calendar = new CalendarInfo();
    // id += 1;
    // calendar.id = String(id);
    // calendar.name = 'Offer';
    // calendar.color = '#578E1C';
    // calendar.bgColor = '#EEF8F0';
    // calendar.dragBgColor = '#EEF8F0';
    // calendar.borderColor = '#EEF8F0';
    // addCalendar(calendar);
})();


(function (window, Calendar) {

    var cal, resizeThrottled;
    var useCreationPopup = true;
    var useDetailPopup = true;
    var datePicker, selectedCalendar;

    cal = new Calendar('#calendar', {
        defaultView: 'month',
        useCreationPopup: useCreationPopup,
        useDetailPopup: useDetailPopup,
        calendars: CalendarList,
        template: {
            milestone: function (model) {
                return '<span class="calendar-font-icon ic-milestone-b"></span> <span style="background-color: ' + model.bgColor + '">' + model.title + '</span>';
            },
            allday: function (schedule) {
                return getTimeTemplate(schedule, true);
            },
            time: function (schedule) {
                return getTimeTemplate(schedule, false);
            }

        }
    });
    //hide buttons function.
    // <% if current_user.id != @instrument_availabilities&.last&.instrument&.user_id %>
    if (currentUser != comparedUser) {
        document.getElementById("calendar").addEventListener("click", hideButtons);

        function hideButtons() {
            var buttons = document.getElementsByClassName("tui-full-calendar-section-button")[0];
            if (buttons) {
                buttons.style.display = "none";
            }
        }
    }
        // <% end %>
    // event handlers
    cal.on({
        'clickMore': function (e) {
            console.log('clickMore', e);
        },
        'clickSchedule': function (e) {
            addRow(e);
            console.log('clickShedule',e)
        }
        ,
        'clickDayname': function (date) {
            console.log('clickDayname', date);
        },
        'beforeCreateSchedule': function (e) {

            // $("#create").fadeIn();
            saveNewSchedule(e);
            window.location.reload()
        },
        'beforeUpdateSchedule': function (e) {

            var schedule = e.schedule;
            var changes = e.changes;

            console.log('beforeUpdateSchedule', e);

            cal.updateSchedule(schedule.id, schedule.calendarId, changes);
            refreshScheduleVisibility();
        }
        ,
        'beforeDeleteSchedule': function (e) {

            console.log('beforeDeleteSchedule', e);
            cal.deleteSchedule(e.schedule.id, e.schedule.calendarId);

            const request = (uri + instrument_id + '/availabilities/' + e.schedule.id)

            fetch(request, {

                // Adding method type
                method: "DELETE",

                // Adding body or contents to send
                body: JSON.stringify({
                    availability_id: e.schedule.id,
                }),

                // Adding headers to the request
                headers: {
                    "Content-type": "application/json; charset=UTF-8"
                }
            })

                // Converting to JSON
                .then((response) => {
                    console.log('Do something here', response)
                })
        },
        'afterRenderSchedule': function (e) {
            var schedule = e.schedule;
            // window.location.reload()
        },
        'clickTimezonesCollapseBtn': function (timezonesCollapsed) {
            console.log('timezonesCollapsed', timezonesCollapsed);

            if (timezonesCollapsed) {
                cal.setTheme({
                    'week.daygridLeft.width': '77px',
                    'week.timegridLeft.width': '77px'
                });
            } else {
                cal.setTheme({
                    'week.daygridLeft.width': '60px',
                    'week.timegridLeft.width': '60px'
                });
            }

            return true;
        }
    });

    function addRow(e) {

        console.log("Row function called",e);
        window.data = e ;
        if (e.schedule.state == 'available') {
            const div1 = document.createElement('div');
            div1.className = 'btn btn-btn-dark';
            div1.innerHTML = '<input type="button" value="Booked" id="btn-booked" onclick="setBooking(data)" >';
            document.getElementsByClassName('tui-full-calendar-section-detail')[0].appendChild(div1);
        }
        // let events;
        // events= []
        //
        // events.push( <%=  @instrument_availabilities.where(status: 'pending').ids  %> )

        if (events.length > 0 && events[0].includes(parseInt(e.schedule.id))) {
            const div2 = document.createElement('div');
            div2.className = 'btn btn-btn-dark';
            div2.innerHTML = '<input type="button" value="Cancel" id="btn-cancel" onclick="cancelBooking(data)" />';
            document.getElementsByClassName('tui-full-calendar-section-detail')[0].appendChild(div2);
        }


    }

    function getTimeTemplate(schedule, isAllDay) {
        console.log('hit gettime temp');
        var html = [];
        var start = moment(schedule.start.toUTCString());
        if (!isAllDay) {
            html.push('<strong>' + start.format('HH:mm') + '</strong> ');
        }
        if (schedule.isPrivate) {
            html.push('<span class="calendar-font-icon ic-lock-b"></span>');
            html.push(' Private');
        } else {
            if (schedule.isReadOnly) {
                html.push('<span class="calendar-font-icon ic-readonly-b"></span>');
            } else if (schedule.recurrenceRule) {
                html.push('<span class="calendar-font-icon ic-repeat-b"></span>');
            } else if (schedule.attendees.length) {
                html.push('<span class="calendar-font-icon ic-user-b"></span>');
            } else if (schedule.location) {
                html.push('<span class="calendar-font-icon ic-location-b"></span>');
            }
            html.push(' ' + schedule.title);
        }

        return html.join('');
    }


    function onClickNavi(e) {
        var action = getDataAction(e.target);

        switch (action) {
            case 'move-prev':
                cal.prev();
                break;
            case 'move-next':
                cal.next();
                break;
            case 'move-today':
                cal.today();
                break;
            default:
                return;
        }

        setRenderRangeText();
        setSchedules();
    }

    function onNewSchedule() {
        var title = $('#new-schedule-title').val();
        var location = $('#new-schedule-location').val();
        var isAllDay = document.getElementById('new-schedule-allday').checked;
        var start = datePicker.getStartDate();
        var end = datePicker.getEndDate();
        var calendar = selectedCalendar ? selectedCalendar : CalendarList[0];

        if (!title) {
            return;
        }

        console.log('calendar.id ', calendar.id)
        cal.createSchedules([{
            id: '1',
            calendarId: calendar.id,
            title: title,
            isAllDay: isAllDay,
            start: start,
            end: end,
            category: isAllDay ? 'allday' : 'time',
            dueDateClass: '',
            color: calendar.color,
            bgColor: calendar.bgColor,
            dragBgColor: calendar.bgColor,
            borderColor: calendar.borderColor,
            raw: {
                location: location
            },
            state: 'Busy'
        }]);

        $('#modal-new-schedule').modal('hide');
    }

    function onChangeNewScheduleCalendar(e) {
        var target = $(e.target).closest('a[role="menuitem"]')[0];
        var calendarId = getDataAction(target);
        changeNewScheduleCalendar(calendarId);
    }

    function changeNewScheduleCalendar(calendarId) {
        var calendarNameElement = document.getElementById('calendarName');
        var calendar = findCalendar(calendarId);
        var html = [];

        html.push('<span class="calendar-bar" style="background-color: ' + calendar.bgColor + '; border-color:' + calendar.borderColor + ';"></span>');
        html.push('<span class="calendar-name">' + calendar.name + '</span>');

        calendarNameElement.innerHTML = html.join('');

        selectedCalendar = calendar;
    }

    function createNewSchedule(event) {
        var start = event.start ? new Date(event.start.getTime()) : new Date();
        var end = event.end ? new Date(event.end.getTime()) : moment().add(1, 'hours').toDate();

        if (useCreationPopup) {
            cal.openCreationPopup({
                start: start,
                end: end
            });
        }

    }

    function saveNewSchedule(scheduleData) {
        // location.reload()
        console.log('scheduleData ', scheduleData)
        var calendar = scheduleData.calendarId || findCalendar(scheduleData.calendarId);
        var schedule = {
            id: '1',
            title: scheduleData.title,
            // isAllDay: scheduleData.isAllDay,
            start: scheduleData.start,
            end: scheduleData.end,
            category: 'time',
            // category: scheduleData.isAllDay ? 'allday' : 'time',
            // dueDateClass: '',
            color: calendar.color,
            bgColor: calendar.bgColor,
            dragBgColor: calendar.bgColor,
            borderColor: calendar.borderColor,
            location: scheduleData.location,
        };
        if (calendar) {
            schedule.calendarId = calendar.id;
            schedule.color = calendar.color;
            schedule.bgColor = calendar.bgColor;
            schedule.borderColor = calendar.borderColor;
        }
        cal.createSchedules([schedule]);
        const request = (uri + instrument_id + '/availabilities')
        fetch(request, {

            // Adding method type
            method: "POST",

            // Adding body or contents to send
            body: JSON.stringify({
                // user_id: <%= current_user.id  %>,
                user_id: currentUser,
            instrument_id: instrument_id,
            start_date: scheduleData.start._date.toString(),
            end_date: scheduleData.end._date.toString()
    }),

        // Adding headers to the request
        headers: {
            "Content-type": "application/json; charset=UTF-8"
        },
    })

        // Converting to JSON
    .then((response) => {
            console.log('I am called', response)
        })

        refreshScheduleVisibility();
    }


    function refreshScheduleVisibility() {
        let calendarElements = Array.prototype.slice.call(document.querySelectorAll('#calendarList input'));

        CalendarList.forEach(function (calendar) {
            cal.toggleSchedules(calendar.id, !calendar.checked, false);
        });

        cal.render(true);

        calendarElements.forEach(function (input) {
            var span = input.nextElementSibling;
            span.style.backgroundColor = input.checked ? span.style.borderColor : 'transparent';
        });
    }


    function setRenderRangeText() {

        var renderRange = document.getElementById('renderRange');
        var options = cal.getOptions();
        var viewName = cal.getViewName();
        var html = [];
        if (viewName === 'day') {
            html.push(moment(cal.getDate().getTime()).format('MMM YYYY DD'));
        } else if (viewName === 'month' &&
            (!options.month.visibleWeeksCount || options.month.visibleWeeksCount > 4)) {
            html.push(moment(cal.getDate().getTime()).format('MMM YYYY'));
        } else {
            html.push(moment(cal.getDateRangeStart().getTime()).format('MMM YYYY DD'));
            html.push(' ~ ');
            html.push(moment(cal.getDateRangeEnd().getTime()).format(' MMM DD'));
        }
        // renderRange.innerHTML = html.join('');
    }

    function setSchedules() {
        cal.clear();
        var schedules = [];

        for (let i = 0; i < eventsData.length; i++) {
            schedules.push({
                id: eventsData[i].id,
                start: eventsData[i].start,
                end: eventsData[i].end,
                title: eventsData[i].title,
                isAllDay: false,
                goingDuration: 30,
                comingDuration: 30,
                color: '#090808',
                isVisible: true,
                state: eventsData[i].status,
                bgColor: '#e8cb96',
                dragBgColor: '#69BB2D',
                borderColor: '#69BB2D',
                calendarId: '1',
                category: 'allday',
                dueDateClass: '',
                customStyle: 'cursor: default;',
                isPending: false,
                isFocused: false,
                isReadOnly: false,
                isPrivate: false,
                location: '',
                attendees: '',
                recurrenceRule: '',


            })
            // text += cars[i] + "<br>";
        }

        const numbers2 = schedules.map(myFunction);
        function myFunction(value, index, array) {
            if (value.state== 'booked')
            {value.bgColor ='#46a420' ;}
            if (value.state=='pending')
            {value.bgColor= '#ad6d25'}
            return value

        }
        cal.createSchedules(numbers2);
        refreshScheduleVisibility();
    }

    function setEventListener() {
        $('#menu-navi').on('click', onClickNavi);
        // $('.dropdown-menu a[role="menuitem"]').on('click', onClickMenu);
        // $('#lnb-calendars').on('change', onChangeCalendars);

        $('#btn-save-schedule').on('click', onNewSchedule);
        $('#btn-new-schedule').on('click', createNewSchedule);

        $('#dropdownMenu-calendars-list').on('click', onChangeNewScheduleCalendar);
        // $("#btn-booked").onclick('click',setBooking);
        window.addEventListener('resize', resizeThrottled);
    }

    function getDataAction(target) {
        return target.dataset ? target.dataset.action : target.getAttribute('data-action');
    }

    resizeThrottled = tui.util.throttle(function () {
        console.log("resize hit")
        cal.render();
    }, 50);

    window.cal = cal;

    setSchedules();
    // setEventListener();
})(window, Calendar);

// set calendars
(function () {

})();


