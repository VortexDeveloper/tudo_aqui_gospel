jQuery ->
  cities = $('#personal_profile_city_id').html()
  $('#personal_profile_state_id').change ->
    state = $('#personal_profile_state_id :selected').text()
    state = state.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cities).filter("optgroup[label='#{state}']").html()
    if options
      $('#personal_profile_city_id').html(options)
      $('#personal_profile_city_id').removeAttr('disabled', 'disabled')
    else
      $('#personal_profile_city_id').attr('disabled', 'disabled')
