({
  init: function (global) {
    // HTML5 fix for older browsers
    'article aside footer header nav section time'.replace(/\w+/g, function (n) {
      global.document.createElement(n);
    });

    // start App when DOM ready
    $(function() {
      (new App()).start();
    });
  }
}).init(this);
