var attachments = (function () {   

  $(document).on("upload:start", "form#new_document", function(event) {
    var $progress = $('.progress', event.currentTarget);
    var $progressBar = $('.progress-bar', $progress);
    $progressBar.css("width", '0%')
  });

  $(document).on("upload:progress", "form#new_document", function(event) {
    var detail = event.originalEvent.detail;
    var percentage = Math.round( (detail.loaded / detail.total) * 100); 	
    $('.progress-bar', event.currentTarget).css('width', percentage+'%');
  });

  $(document).on("upload:complete", "form#new_document", function() {
    
  });

})();