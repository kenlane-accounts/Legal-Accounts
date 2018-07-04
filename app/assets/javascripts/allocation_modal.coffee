class AllocationModal
  init: (e)->
    modal = $('#allocationModal')
    receipt_tran_id = $(e.relatedTarget).data('id')

    modal.load "/allocations/new.js?receipt_tran_id=#{receipt_tran_id}", ->
      $('.fill_allocation_amount').click ->
        button = $(this)
        input = button.closest('.input-group').find('input')
        invoice_to_alloc = $(this).data('toAlloc')
        receipt_to_alloc = $('#receipt_to_alloc').data('toAlloc')
        available = receipt_to_alloc - (current_alloc() - Number(input.val()))
        to_alloc = Math.min(invoice_to_alloc, available)
        input.val(to_alloc)

      $('#autoallocate').click ->
        $('.allocation_amount_input').val(null)
        $('.allocation_amount_input').each ->
          input = $(this)
          invoice_to_alloc = input.data('toAlloc')
          receipt_to_alloc = $('#receipt_to_alloc').data('toAlloc')
          available = receipt_to_alloc - (current_alloc() - Number(input.val()))
          to_alloc = Math.min(invoice_to_alloc, available)
          if to_alloc >= 0.01
            input.val(to_alloc)


current_alloc = ->
  sum = 0
  for el in $('.allocation_amount_input')
    sum += Number($(el).val())
  sum

this.Accounts.allocationModal = new AllocationModal()