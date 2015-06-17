var RemoteModal = (function () {
  var openingLink, modal;

  $(document).ready(function(){
    $('.js-open-trough-modal').on('click', function (event) {

      if ($(".js-trough-modal").length === 0) {
        var modalHtml = "<div class='modal fade trough-modal js-trough-modal' id='trough-modal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'> \
          <div class='modal-dialog'> \
            <div class='modal-content'> \
            </div> \
          </div> \
        </div>";
        $('body').append(modalHtml);
      }
      openingLink = $(event.currentTarget);
      $('#trough-modal').modal('show');
    });

    $('body').on('show.bs.modal', '#trough-modal', function(event){
      modal = $(event.currentTarget);
      $.get('/documents/modal', function(data){
        $('.modal-content', modal).html(data);
        $( ".autocomplete-select", modal).combobox({
          select: function(event, ui) {
            documentSelected(ui.item.value);
          }
        });
      });

    });
  });

  function documentSelected(document_id) {
    openingLink.siblings('input').val(document_id);
    openingLink.hide();
    openingLink.siblings('.document-link').show();
    modal.modal("hide");
  }

  return {
    documentSelected: documentSelected
  };

})();
