// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("packs/home")
require("packs/stripe")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
//= require jquery
//= require jquery_ujs
//= require social-share-button

require("trix")
require("@rails/actiontext")
import "@fortawesome/fontawesome-free/css/all.css";
import "../packs/trix-editor-overrides";

import "@fortawesome/fontawesome-free/js/all";


window.jQuery = $; 
window.$ = $;


$('a.share').click(function(e){
 e.preventDefault();
 var $link = $(this);
 var href = $link.attr('href');
 var network = $link.attr('data-network');
var networks = {
 facebook : { width : 600, height : 300 }
 };
var popup = function(network){
 var options = 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,';
 window.open(href, '', options+'height='+networks[network].height+',width='+networks[network].width);
 };
popup(network);
});