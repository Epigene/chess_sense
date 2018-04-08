//= require jquery3
//= require jquery_ujs
//= require_tree .

$(document).ready(function () {
  $('.board').fenview({ fen: $('.board').attr("data") });
});
