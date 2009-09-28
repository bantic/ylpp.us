Event.observe(window, 'load', function() {
  if (shortening_url = $("shortening_url")) {
    shortening_url.focus();
  }
  
  if (shortening_url = $("shortening_text")) {
    Element.observe('shortening_text', 'click', function() {this.activate()});
  }
});