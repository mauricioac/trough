var documentHelpers = (function () {
  "use strict";

  function showDuplicateDocumentAlert(slug, callback, linkText, target) {
    var warning = $('<div/>', {
      class: "alert alert-info",
      role: "alert",
      text: "Ooops, this file has already been uploaded."
    }).append($("<a/>", {
      class: "duplicate-show",
      text: linkText || "Show",
      on: {
        "click": function() {
          callback(slug);
        }
      }
    }));

    if(target) {
      warning.prependTo(target);
    } else {
      warning.prependTo("form#new_document");
    }

  }

  return {
    showDuplicateDocumentAlert: showDuplicateDocumentAlert
  };

})();
