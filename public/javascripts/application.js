Event.observe(window, 'load', function() {
  if (shortening_url = $("shortening_url")) {
    shortening_url.focus();
  }
  
  addShorteningClickListener();
  // addCopyButton();
});

function addShorteningClickListener() {
  if (shortening_url = $("shortening_text")) {
    Element.observe('shortening_text', 'click', function() {this.activate()});
  }
}

function addCopyButton() {
  var so = new SWFObject("/flash/copy_to_clipboard.swf", "copyit", "100%", "100%", "6.0.65", "transparent");
  so.addParam("wmode", "transparent");
  so.addParam("flashVars", "copy_text=" + $('shortening_text').value + "&callback=copy_done()");
  so.write("copy_button");
  $('copy_button').clonePosition($('real_copy'));
  $('copy_button').style.left = $('real_copy').getBoundingClientRect().left + "px";
  $('copy_button').style.width = $('real_copy').getWidth() + "px";
  $('copy_button').style.height = $('real_copy').getHeight() + "px";
}

function addCopyButtonMaybe() {
  if ($('real_copy') && $('stats') && $('stats').visible()) {
    addCopyButton();
  } else {
    setTimeout(addCopyButtonMaybe, 200);
  }
}

function copy_done() {
  $('real_copy').value = "Copied";
}