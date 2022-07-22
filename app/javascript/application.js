// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery
//= require jquery_ujs
//= require best_in_place
//= require best_in_place.jquery-ui
import "@hotwired/turbo-rails"
import "controllers"

$(document).ready(function() {
    /* Activating Best In Place */
    jQuery(".best_in_place").best_in_place();
});