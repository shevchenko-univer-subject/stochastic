function convertFormToJSON(form) {
  const array = $(form).serializeArray(); // Encodes the set of form elements as an array of names and values.
  const json = {};
  $.each(array, function () {
    json[this.name] = this.value || "";
  });
  return json;
}

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

function buildExportButton(dist_data){
  const exportButton = "<button method='get' action='export/create' data='"
                        + dist_data
                        + "' class='btn btn-lg btn-primary col-6'>Export</button>"

  $("#exportSpace").replaceWith(exportButton);
}

$(document).ready(function() {
  $("#calcDistribution").submit( function(e){
    e.preventDefault();

    var form = $(this);
    var method = form.attr('method');
    var action = form.attr('action');

    var json_data = convertFormToJSON(form);

    $.ajax({
      type: method,
      url: action,
      data: json_data,
      success: function(result) {
        buildExportButton(result);
        buildChart(result);
      }
    });
  });
});