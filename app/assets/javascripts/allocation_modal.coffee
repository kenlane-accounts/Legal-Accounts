class AllocationModal
  init: (e)->
    modal = $('#allocationModal')
    receipt_tran_id = $(e.relatedTarget).data('id')

    modal.load "/allocations/new.js?receipt_tran_id=#{receipt_tran_id}"


this.Accounts.allocationModal = new AllocationModal()