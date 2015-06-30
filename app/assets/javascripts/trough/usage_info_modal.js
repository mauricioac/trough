var DocumentInfoModal = (function () {
  "use strict";

  $(document).ready(function(){
    $('.cms-main').on('click', '[data-document-info-modal]', function (event) {
      event.preventDefault();
      var openingLink = $(event.currentTarget);
      $.get('/documents/' + openingLink.data('document-info-modal') + '/info', function(data){
        var compiled = _.template("\
          <h3>Description</h3>\
          <div class='document-description'> <%= data.description %> </div>\
          <table id='usage_link_list' class='cms-table'>\
          <thead>\
            <tr>\
              <th>Pages</th>\
              <th>Active</th>\
              <th>Download count</th>\
            </tr>\
          </thead>\
          <% _.each(data.document_usages, function(usage) {  %>\
            <tr>\
            <td><%= usage.content_package.name %></td>\
            <td><%= usage.active %></td>\
            <td><%= usage.download_count %></td>\
            </tr>\
          <% }); %>\
          </table>\
          <a class='btn btn-primary pull-left' href=\"/documents/<%= data.slug %>\" >Download</a>\
        ", {variable: 'data'});
        $('#usageLinks .modal-body').html(compiled(data));
      });
      $('#usageLinks').modal("show");
    });
  });
})();
