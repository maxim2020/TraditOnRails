var live_rate1, live_rate2, live_rate3

$(document).ready(function(){
  
        drawSmoothie()

        //socket
        var socket = io.connect('http://localhost:3001');
        socket.on('updateRate', function (data) {
          live_rate1 = data.data[0].rate
          live_rate2 = data.data[1].rate
          live_rate3 = data.data[2].rate
          
          $('#rateLabel').text(JSON.stringify(data.data))
          $('#currencylive1').text(data.data[0].name + ": " + live_rate1)
          $('#currencylive2').text(data.data[1].name + ": " + live_rate2)
          $('#currencylive3').text(data.data[2].name + ": " + live_rate3)
          
        });
        
        $('#currencylive1').css('color', 'rgb(103, 227, 0)').css( 'font-weight', 'bold')
        $('#currencylive2').css('color', 'rgb(255, 203, 0)').css( 'font-weight', 'bold')
        $('#currencylive3').css('color', 'rgb(255, 122, 0)').css( 'font-weight', 'bold')
        
})

      function drawSmoothie(){
          var smoothie = new SmoothieChart({
          grid: { strokeStyle:'rgb(30, 114, 140)', 
              fillStyle:'rgb(43, 166, 203)',
                  lineWidth: 2, 
                  millisPerLine: 1000, 
                  verticalSections: 4, 
                   },
          labels: { fillStyle:'rgb(30, 114, 140)' }
        });
       
        smoothie.streamTo(document.getElementById('testcanvas'), 1000 /*delay*/); 
      
          // Data
        var line1 = new TimeSeries();
        var line2 = new TimeSeries();
        var line3 = new TimeSeries();
        
        // Add rates value to each line, every seconds
        setInterval(function() {
          line1.append(new Date().getTime(), live_rate1);
          line2.append(new Date().getTime(), live_rate2);
          line3.append(new Date().getTime(), live_rate3);
        }, 1000);
        
         // Add to SmoothieChart
        smoothie.addTimeSeries(line1,
        { strokeStyle:'rgb(103, 227, 0)',  lineWidth:3 });
        smoothie.addTimeSeries(line2,
         { strokeStyle:'rgb(255, 203, 0)',  lineWidth:3 });
        smoothie.addTimeSeries(line3,
        { strokeStyle:'rgb(255, 122, 0)',  lineWidth:3 });
      }
      
    