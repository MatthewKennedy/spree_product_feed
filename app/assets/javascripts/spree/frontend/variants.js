var queryString = window.location.search;
var urlParams = new URLSearchParams(queryString);
var option = urlParams.get('option')

if (urlParams.has('option')) {
var container = document.querySelector("ul#product-variants");
var matches = container.querySelectorAll("input#variant_option_value_id_" + option);
matches[0].checked = true
}
