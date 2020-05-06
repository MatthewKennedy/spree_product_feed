var queryString = window.location.search;
var urlParams = new URLSearchParams(queryString);

var container = document.querySelector("ul#product-variants");
var matches = container.querySelectorAll("input.product-variants-variant-values-radio");

const
  keys = urlParams.keys(),
  values = urlParams.values(),
  entries = urlParams.entries();

  for (const value of values) {
    // console.log(value);
    checkRequestedParams(matches, value);
  }

  function checkRequestedParams(mathers, option) {
    for (var i = 0; i < matches.length; i++) {
      if (matches[i].dataset.presentation.toLowerCase() == option.toLowerCase()) {
          matches[i].checked = true
      }
    }
  }
