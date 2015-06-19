var UsageLinksModal = (function () {
  "use strict";

  $(document).ready(function(){
    $('[data-document-usage-links]').on('click', function (event) {
      event.preventDefault();
      var openingLink = $(event.target);
      var url = openingLink.data('modal-url');
      $.get(url, function(data){
        $('#usageLinks .modal-body').html(data);
      });
      $('#usageLinks').modal("show");
    });

  });
})();
