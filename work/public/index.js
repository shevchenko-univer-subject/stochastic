function buildChart(data) {
  const ctx =  $("#chartSpace").find('canvas')
    
  new Chart(ctx, {
    type: 'line',
    data: {
      labels: [1,2,3,4,5,6,7],
      datasets: [{
        backgroundColor: '#0d6efd',
        label: 'Distribution',
        data: data,
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });
}

function buildExportButton(){
  // $("#exportSpace").add
}

$(document).ready(function() {
  $("#calcDistribution").submit( function(e){
    e.preventDefault();

    $.ajax({
      type: 'get',
      url: '/process',
      success: function(result) {
        buildChart(result)
        buildExportButton()
      }
    });
  });
});