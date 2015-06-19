var UsageLinksModal = (function () {
  "use strict";

  $(document).ready(function(){
    $( "#document-search #term").each(function(){
      var input = $(this);
      var url = $(this).data("source");
      input.autocomplete({
        source: url,
        minLength: 2,
        select: function( event, ui ) {
          $(this).parents("form").submit();
        }
      });
    });
  });
})();
