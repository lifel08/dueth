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
import { initFlatpickr } from "../plugins/flatpickr";
import { SLIDEPAGE } from '../plugins/slidepage';
import { initSlidePage } from '../components/slide';
import "../components/popup";

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';


document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
 initFlatpickr();
 initSlidePage();
 
 $('#collapseExample').on('cocoon:after-insert', function(e, added_task) {
       initFlatpickr();
 })

$('#navbarToggleExternalContent').on('hide.bs.collapse', function () {
    $('nav.navbar').addClass('navbar-light').removeClass('navbar-dark').removeClass('bg-dark')
    $('.navbar-toggler').removeClass('bg-dark').addClass('bg-white')
})

$('#navbarToggleExternalContent').on('show.bs.collapse', function () {
    $('nav.navbar').removeClass('navbar-light').addClass('navbar-dark').addClass('bg-dark')
    $('.navbar-toggler').addClass('bg-dark').removeClass('bg-white')
})
});


require("@nathanvda/cocoon")

// Disponibility popup
$(window).load(function () {
    $(".trigger_popup_fricc").click(function(){
       $('.hover_bkgr_fricc').show();
    });
    $('.hover_bkgr_fricc').click(function(){
        $('.hover_bkgr_fricc').hide();
    });
    $('.popupCloseButton').click(function(){
        $('.hover_bkgr_fricc').hide();
    });
});
