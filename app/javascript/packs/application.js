// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import "jquery";
import {initFlatpickr} from "../plugins/flatpickr";
import {SLIDEPAGE} from '../plugins/slidepage';
import {initSlidePage} from '../components/slide';
import * as url from "url";

require("jquery")
require("@nathanvda/cocoon")

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';


$(document).on('turbolinks:load', function () {
    // Call your functions here, e.g:
    // initSelect2();
    initFlatpickr();
    initSlidePage();

    $('#collapseExample').on('cocoon:after-insert', function (e, added_task) {
        initFlatpickr();
    })

    $('.datepicker').flatpickr({
        minDate: new Date(),
        enableTime: true
    });

    $('.DOB-datepicker').flatpickr({
        enableTime: true
    });

    $('.flat_time_pick').flatpickr({
        enableTime: true,
        noCalendar: true,
        dateFormat: "H:i",
        // time_24hr: false
    });


    $('#navbarToggleExternalContent').on('hide.bs.collapse', function () {
        $('nav.navbar').addClass('navbar-light').removeClass('navbar-dark').removeClass('bg-dark')
        $('.navbar-toggler').removeClass('bg-dark').addClass('bg-white')
    })

    $('#navbarToggleExternalContent').on('show.bs.collapse', function () {
        $('nav.navbar').removeClass('navbar-light').addClass('navbar-dark').addClass('bg-dark')
        $('.navbar-toggler').addClass('bg-dark').removeClass('bg-white')
    })
// Disponibility popup

    $(".trigger_popup_fricc").click(function () {
        $('.hover_bkgr_fricc').show();
    });
    $('.hover_bkgr_fricc').click(function () {
        $('.hover_bkgr_fricc').hide();
    });
    $('.popupCloseButton').click(function () {
        $('.hover_bkgr_fricc').hide();
    });

    $(".customDataSelection").change(function () {
        var selectedValue = this.options[this.selectedIndex].value;
        console.log(selectedValue);
        $.ajax({
            type: "get",
            url: "#{<%= search_instruments_path %>}",
            data: {price: selectedValue}
        });
    });

    const wrapper = document.querySelector('.cards-wrapper');
    const dots = document.querySelectorAll('.dot');
    var activeDotNum = 0;
    dots.forEach(function (dot, idx) {
        dot.setAttribute('data-num', idx);
        dot.addEventListener('click', function (e) {
            var clickedDotNum = e.target.dataset.num;
            if (clickedDotNum == activeDotNum) {
                return;
            }
            else {
                var displayArea = wrapper.parentElement.clientWidth;
                var pixels = -displayArea * clickedDotNum
                wrapper.style.transform = 'translateX(' + pixels + 'px)';
                dots[activeDotNum].classList.remove('active');
                dots[clickedDotNum].classList.add('active');
                activeDotNum = clickedDotNum;
            }
        });
    });
    var previousScroll = 0;

    $(window).scroll(function () {
        var currentScroll = $(this).scrollTop();
        if (currentScroll > previousScroll) {
            $('.footer-main').css("bottom", 0);
        } else {
            $('.footer-main').css("bottom", -60);
        }
        previousScroll = currentScroll;
    });
    if ($('#map-show').length > 0) {

        var mapboxgl = require('mapbox-gl/dist/mapbox-gl.js');
        mapboxgl.accessToken = 'pk.eyJ1IjoibGlmZWwwOCIsImEiOiJja252cDQ1Mmkwb3h4Mm9vYWY3Z3YycDdoIn0.3Jn2hjSix6AUKv4zPqAUgw';
        var center = $('#center-id').val();
        center = center.split(' ');
        // console.log(center);
        var map = new mapboxgl.Map({
            container: 'map' && 'map-show',
            style: 'mapbox://styles/mapbox/streets-v11',
            center: center,
            zoom: 12
        });
        // create a HTML element for each feature
        var el = document.createElement('div');
        el.className = 'marker';

        map.on('load', function () {
            // create the popup
            var text = $('#title-id').val();
            var id = window.location.pathname.split("/")[2]
            var popup = new mapboxgl.Popup({offset: 45}).setHTML('<a href="http://' + window.location.host + "/instruments/" + id + '">' + text + '</a>'
            );
            var marker = new mapboxgl.Marker(el)
                .setPopup(popup)
                .setLngLat(center)
                .addTo(map);
        })
    }
});


