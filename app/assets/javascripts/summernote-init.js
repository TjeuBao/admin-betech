$(document).on('ready turbolinks:load', function() {
  $('[data-provider="summernote"]').each(function() {
    $(this).summernote({
      toolbar: [
        ['style', ['bold', 'italic', 'underline', 'clear']],
        ['font', ['strikethrough', 'superscript', 'subscript']],
        ['fontsize', ['fontsize']],
        ['color', ['color']],
        ['para', ['ul', 'ol', 'paragraph', 'style']],
        ['table', ['table']],
        ['insert', ['link', 'picture', 'video', 'hr']],
        ['view', ['codeview']]
      ],
      imageTitle: {
        specificAltField: true,
      },
      popover: {
        image: [
            ['image', ['resizeFull', 'resizeHalf', 'resizeQuarter', 'resizeNone']],
            ['float', ['floatLeft', 'floatRight', 'floatNone']],
            ['custom', ['imageTitle']],
            ['remove', ['removeMedia']]
        ],
        link: [
          ['link', ['linkDialogShow', 'unlink']]
        ],
        table: [
          ['add', ['addRowDown', 'addRowUp', 'addColLeft', 'addColRight']],
          ['delete', ['deleteRow', 'deleteCol', 'deleteTable']]
        ],
        air: [
          ['color', ['color']],
          ['font', ['bold', 'underline', 'clear']],
          ['para', ['ul', 'paragraph']],
          ['table', ['table']],
          ['insert', ['link', 'picture']]
        ]
      },
    });

    $('.note-editor.note-frame.card').find('.dropdown-toggle[data-toggle="dropdown"]').each(function() {
      $(this).on('click', () => {
        let $dropdownMenu = $(this).siblings('.dropdown-menu')

        if ($dropdownMenu.attr('class').includes('show')) {
          $dropdownMenu.removeClass('show')
        } else {
          $dropdownMenu.addClass('show')
        }
      })
    })
  })
});
