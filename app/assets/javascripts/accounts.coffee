this.Accounts ?= {}

$ ->
  $('.modal').on 'show.bs.modal', (e) ->
    modal_controller = Accounts[this.id]
    if modal_controller != undefined
      modal_controller.init(e)
