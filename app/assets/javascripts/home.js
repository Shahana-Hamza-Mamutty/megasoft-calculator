$(document).ready(function() {
    var single_input_ops = ['sqrt','cbrt','!']
    var operator = ""
    var next_operator = ""
    var num1 = []
    var num2 = []
    var float_num1 = false
    var float_num2 = false
    var result = false

    executeOperation = function(e) { 
      url = '/megasoft/api/v1/calculator/calculate';
      $.ajax({
        type: 'POST',
        url: url,
        data: { input: (num1.join("")+','+num2.join("")), operation: operator  },
        beforeSend: function(xhr) {
          xhr.setRequestHeader("Authorization", "Token token=7381a978f7dd7f9a1117")
        },
        dataType: "json",
        success: function (data) {
          console.log(data.result)
          if (data.result == null){
            clearData()
            $('.screen').val('error')
          }
          else {
            num1 = [data.result]
            num2 = []
            operator = next_operator || ""
            float_num1 = false
            float_num2 = false
            result = true
            $('.screen').val(data.result)
          }
        },
        error: function(data) { 
          clearData()
          $('.screen').val('error')
        }
      });
    };

    clearData = function(){
      num1 = []
      num2 = []
      float_num1 = false
      float_num2 = false
      operator = ""
      next_operator = ""
      result = false
    }

    $("button").click(function () {
      val = $(this).data('val').toString();
      if ($(this).hasClass("num")) {
        if (operator.length === 0){
          if( (val != '.') || (val == '.' && (float_num1 == false)) ) {
            if(result == false){
              if (!(num1.length > 10)){
                num1.push(val)
                if (val == '.'){
                  float_num1 = true
                }
              }
            }
            else {
              clearData()
              num1.push(val)
            }
            
          }
        }
        else {
          if( (val != '.') || (val == '.' && (float_num2 == false)) ) {
            if (!(num2.length > 10)){
              num2.push(val)
              if (val == '.'){
                float_num2 = true
              }
            }
          }
        }
      }
      else if ($(this).hasClass("ops")) {
        if (val == '-' && num1.length == 0){
          num1.push(val)
        }
        else {
          if (single_input_ops.includes(val)){
            if(num1.length > 0 && !(num2.length > 0)){
              operator = val
              executeOperation()
            }
          }
          else if (num1.length > 0 && num2.length > 0){
            next_operator = val
            executeOperation()
          }
          else{
            operator = val
          }
        }
      }
      else if (val == "="){
        if(num1.length > 0 && num2.length > 0 && operator.length > 0){
          executeOperation()
          operator = ""
        }
      }
      else if (val == "clear"){

        if (operator.length > 0){
          if (num2.length > 0){
            num2.splice(-1,1)
            if(num2.length == 0){
              operator = ""
              num1= []
            }
          }else{
            operator = ""
            num1.splice(-1,1)
          }
        }
        else{
          if (num1.length > 0){
            num1.splice(-1,1)
          }
        }
      }
      else if(val == "allClear"){
        clearData()
      }        

    screen_val = (num2.length === 0) ? num1.join("") : num2.join("")
    $('.screen').val(screen_val)

  });

});