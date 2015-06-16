var RemoteModal = (function () {
  var openingLink, modal;

  $(document).ready(function(){
    $('.js-trough-modal').on('show.bs.modal', function (event) {
      openingLink = $(event.relatedTarget);
      modal = $(event.currentTarget);
      $.get('/documents/modal', function(data){
        $('.modal-content', event.currentTarget).html(data);
        $( ".autocomplete-select", event.currentTarget).combobox({
          select: function(event, ui) {
            documentSelected(ui.item.value);
          }
        });
      });
    })
  });

  documentSelected = function(document_id) {
    openingLink.siblings('input').val(document_id);
    modal.modal("hide");
  };

})();
