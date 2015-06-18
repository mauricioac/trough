var RemoteModal = (function () {
  "use strict";
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
            var item = JSON.parse(ui.item.value);
            documentSelected(item.id, item.url, item.name);
          }
        });
      });

    });

    $('.js-trough-remove').on('click', function (event) {
      removeDocument($(event.currentTarget).parents('.document.input').find('input'));
    });
  });

  function removeDocument(input) {
    input.val('');
    $('.js-trough-document-editor').hide();
    $('.js-trough-document-chooser').show();
  }

  function documentSelected(document_id, document_url, document_name) {
    var document_input = openingLink.parents('.document.input');
    document_input.find('input').val(document_id);
    document_input.find('.js-trough-document-editor').show();
    document_input.find('.js-trough-document-chooser').hide();
    document_input.find('.js-trough-document-link').attr('href', document_url);
    document_input.find('.js-trough-document-name').html(document_name);

    modal.modal("hide");
  }

  return {
    documentSelected: documentSelected
  };

})();
