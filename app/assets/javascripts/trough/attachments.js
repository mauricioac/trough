var attachments = (function () {   

  $(document).on("upload:start", "form#new_document", function(event) {
    var $progress = $('.progress', event.currentTarget);
    var $progressBar = $('.progress-bar', $progress);
    $progressBar.css("width", '0%');
  });

  $(document).on("upload:progress", "form#new_document", function(event) {
    var detail = event.originalEvent.detail;
    var percentage = Math.round( (detail.loaded / detail.total) * 100); 	
    $('.progress-bar', event.currentTarget).css('width', percentage+'%');
  });

  $(document).on("upload:complete", "form#new_document", function(event) {
    $form = $(event.currentTarget);
    $('#document_submit_action', $form).removeAttr('disabled');
  });
  
  // Rails_ujs fires this event and submits the form normally if a remote form has a file chosen.
  // This is because by default rails cant upload files via ajax, in our case the file is uploaded directly to S3
  // and so this is'nt an issue.
  $(document).on('ajax:aborted:file', 'form', function(){
   var form = $(this);
   
   // Manually trigger the rails ajax form submit
   $.rails.handleRemote(form);
   return false;
 });

})();