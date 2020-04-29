document.addEventListener('turbolinks:load', () => {
  $('input.custom-file-input').change((event) => {
    const filenames = Array.from(event.target.files)
      .map(file => file.name)
      .join(',') || 'Choose file';

    $(event.target).siblings('label').text(filenames);
  });
});
