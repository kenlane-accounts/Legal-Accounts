class SearchCaseModal
  init: (e)->
    modal = $('#search_case_modal')

    $('#search_case_term').on 'railsAutocomplete.select', (event, data)->
      case_id = data.item.id
      if case_id
        window.location.href = "/cases/#{case_id}"

  setNextBalance: (value) ->
    $('#next_balance').val value
this.Accounts.search_case_modal = new SearchCaseModal()