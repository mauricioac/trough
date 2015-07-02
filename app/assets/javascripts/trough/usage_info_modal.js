var DocumentInfoModal = (function () {
  "use strict";

  $(document).ready(function(){
    $('body').on('click', '[data-document-info-modal]', function (event) {
      event.preventDefault();
      var openingLink = $(event.currentTarget);
      show(openingLink.data('document-info-modal'));
    });
  });

  function show(slug) {
    $.get('/documents/' + slug + '/info', function(data) {
      var compiled = _.template(
        "<div class='row'>" +
          "<div class='col-md-5 col-md-offset-1'>" +
            "<label class='col-primary'>Filename</label>" +
            "<p><%= data.file_filename %></p>" +
          "</div>" +
          "<div class='col-md-5'>" +
            "<label class='col-primary'>Filesize</label>" +
            "<p><%= data.file_size %></p>" +
          "</div>" +
        "</div>" +
        "<div class='row'>" +
          "<div class='col-md-5 col-md-offset-1'>" +
            "<label class='col-primary'>Author</label>" +
            "<p><%= data.uploader %></p>" +
          "</div>" +
          "<div class='col-md-5'>" +
            "<label class='col-primary'>Uploaded</label>" +
            "<p><%= data.uploaded_on %></p>" +
          "</div>" +
        "</div>" +
        "<label class='control-label'>description</label>" +
        "<div class='document-description'> <%= data.description %> </div>" +
        "<table id='usage_link_list' class='cms-table'>" +
        "<thead>" +
          "<tr>" +
            "<th>Pages</th>" +
            "<th>Active</th>" +
            "<th>Download count</th>" +
          "</tr>" +
        "</thead>" +
        "<% _.each(data.document_usages, function(usage) {  %>" +
          "<tr>" +
          "<td><%= usage.content_package.name %></td>" +
          "<td><%= usage.active %></td>" +
          "<td><%= usage.download_count %></td>" +
          "</tr>" +
        "<% }); %>" +
        "</table>" +
        "<a class='btn btn-primary pull-left' href=\"/documents/<%= data.slug %>\" >Download</a>",
        {variable: 'data'});
      $('#usageLinks .modal-body').html(compiled(data));
    });

    $('#usageLinks').modal("show");
  }

  return {
    show: show
  };

})();
