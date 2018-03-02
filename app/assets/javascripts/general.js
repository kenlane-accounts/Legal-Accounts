function SetVat(VatSel,PDoVatBit){

    // Get the Line No. we are dealing with ......
    var dnum=GetLineID(VatSel.id);


    // Get the type we are dealing with ......
    var dtype=GetType(VatSel.id);

    // Variables for each of the elements we need to update ........
    var damount = document.getElementById("tranhead_tran"+dtype+"_attributes_"+dnum+"_tramount"); 

    var dnet = document.getElementById("tranhead_tran"+dtype+"_attributes_"+dnum+"_netamount");
    damount.value=Number(damount.value).toFixed(2);

    if (dtype=='opnoms'){
        var dvatsel = document.getElementById("tranhead_tran"+dtype+"_attributes_"+dnum+"_vat_id"); 
        var dvat = document.getElementById("tranhead_tran"+dtype+"_attributes_"+dnum+"_vatamount");
        dvat.value=Number(dvat.value).toFixed(2);
    
        // Do not do the VAT bit if we are coming from the VAT Amount -- Should be able to change this amount slightly ....
        if (PDoVatBit==true) {
            // Need to get the VAT % from the text of the selected VAT Rate
            var opt = dvatsel.options[dvatsel.selectedIndex].text;
            // This splits it into an array - we use element 1 ....
            var dperc = opt.split('-', 2);
            
            // Calculate the VAT ....
            var vatamt = (damount.value/100)*dperc[1];
    
            // Set the field with the VAT Value ....
            dvat.value=vatamt.toFixed(2);
        }
        // NET Value is always the amount less the vat amount -- => will always add together correctly then ....
        dnet.value = (damount.value-dvat.value).toFixed(2);
    } else {
        dnet.value = damount.value
    }
}

function SetNominalVat(VatSel, PDoVatBit){

    // Get the Line No. we are dealing with ......
    var dnum=GetLineID(VatSel.id);

//tranheads_nominal_trans_attributes_0_vatamount
    // Variables for each of the elements we need to update ........
    var damount = document.getElementById("tranheads_nominal_trans_attributes_"+dnum+"_tramount"); 

    var dnet = document.getElementById("tranheads_nominal_trans_attributes_"+dnum+"_netamount");
    
    damount.value=Number(damount.value).toFixed(2);
    
    var dvatsel = document.getElementById("tranheads_nominal_trans_attributes_"+dnum+"_vat_id"); 
    var dvat = document.getElementById("tranheads_nominal_trans_attributes_"+dnum+"_vatamount");
    
    dvat.value=Number(dvat.value).toFixed(2);

    // Do not do the VAT bit if we are coming from the VAT Amount -- Should be able to change this amount slightly ....
    if (PDoVatBit==true) {
        // Need to get the VAT % from the text of the selected VAT Rate
        var opt = dvatsel.options[dvatsel.selectedIndex].text;
        // This splits it into an array - we use element 1 ....
        var dperc = opt.split('-', 2);
        
        // Calculate the VAT ....
        var vatamt = (damount.value/100)*dperc[1];

        // Set the field with the VAT Value ....
        dvat.value=vatamt.toFixed(2);
    }
    // NET Value is always the amount less the vat amount -- => will always add together correctly then ....
    dnet.value = (damount.value-dvat.value).toFixed(2);
}

function GetLineID(attname){
    // Passed in the Id of 1 of the line items ....... We need to pull out the line no (23454578) associated E.G. : tranhead_trans_attributes_23454578_vat_id
    var numb = attname.match(/\d/g);
    numb = numb.join("");
    return numb;
}

function GetType(attname){
    // Passed in the Id of 1 of the line items ....... We need to pull out the type associated E.G. : tranhead_tranopnoms_attributes_XXXXX_vat_id
    if (attname.includes("opnom")) {
        return 'opnoms';
    }
    if (attname.includes("opsup")) {
        return 'opsups';
    }
    if (attname.includes("opdisp")) {
        return 'opdisps';
    }
}