$(document).ready(function() {

    $('#alert-box').hide()
    $('#alert-box-alert').hide()

    //update the quantity and the currency_to dropdown list
    $('#currency_from_select').change(function() {

        $("#quantity_select > option:gt(0)").remove();
        $("#currency_to_select > option:gt(0)").remove();

        var selected_currency = $('#currency_from_select option:selected').text();

        $.ajax({
            url : '/trade.json',
            success : function(data) {
                updateSelect(data, selected_currency)
            }
        })
    })
    //Update the trade partial view
    $('#tradeBtn').click(function() {

        var selected_currencyF = $('#currency_from_select option:selected').text();
        var selected_currencyT = $('#currency_to_select option:selected').text();
        var selected_amount = $('#quantity_select option:selected').text();

        if (selected_currencyF == "-- currency --" || selected_currencyT == "-- currency --" || selected_amount == "-- quantity --") {
            $('#alert-box-alert').show()
        } else {
            $.ajax({
                type : "POST",
                url : '/trade',
                data : {"currencyF": selected_currencyF, "currencyT": selected_currencyT,"quantity": selected_amount},
                success : function(data) {
                    $('#tradeDiv').html(data);
                    $('#alert-box').show()
                    updateMyWallet()
                }
            })
        }

    })
})

function updateSelect(local_data, selected_currency) {
    local_data.forEach(function(currency) {
        if (currency.name === selected_currency) {
            //generate "option" tag
            for (var i = 1; i < (currency.number + 1); i++) {
                $('#quantity_select').append($('<option></option>').val(i).html(i))
            }
        } else {
            $('#currency_to_select').append($('<option></option>').val(currency.name).html(currency.name))
        }
    })
}

function updateMyWallet(){
    $.ajax({
            url : '/trade.json',
            success : function(data) {
                data.forEach(function(currency){
                    labelName = currency.name + "label"
                    $("#" + labelName).text(currency.name + ": " + currency.number)
                })
            }
        })
}

