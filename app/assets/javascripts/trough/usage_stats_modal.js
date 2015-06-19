var UsageStatsModal = (function () {
  "use strict";

  $(document).ready(function(){
    $('[data-document-usage-stats]').on('click', function (event) {
      event.preventDefault();
      var openingLink = $(event.target);
      var url = openingLink.data('modal-url');
      $.get(url, function(data){
        $('#usageStats .modal-body').html(data);
      });
      $('#usageStats').modal("show");
    });

  });
})();
