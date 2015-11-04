var DocumentReplaceModal = (function () {
  "use strict";

  function show(document_id) {
    $.get('/documents/replace_modal', {id: document_id}, function(data) {
      $('#documentReplace .modal-content').html(data);
    });

    $('#documentReplace').modal("show");
  }

  function hide() {
    $('#documentReplace').modal("hide");
  }

  function showContentTypeWarning() {
    $('<div/>', {
      class: "alert alert-info",
      role: "alert",
      text: "Ooops, you may only replace this document with another of the same type."
    }).prependTo("form#replace_document");
  }

  return {
    show: show,
    hide: hide,
    showContentTypeWarning: showContentTypeWarning
  };

})();
