function convertFormToJSON(form) {
  const array = $(form).serializeArray(); // Encodes the set of form elements as an array of names and values.
  const json = {};
  $.each(array, function () {
    json[this.name] = this.value || "";
  });
  return json;
};

function collectAttrsFrom(element){
  var form = $(element);
  var method = form.attr('method');
  var action = form.attr('action');
  return {
    'method': method,
    'action': action
  };
};

function renderChart(data) {
  const ctx =  $("#chartSpace").find('canvas')
    
  new Chart(ctx, {
    type: 'line',
    data: {
      labels: data.x,
      datasets: [{
        backgroundColor: '#0d6efd',
        label: 'Distribution',
        data: data.y,
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
};

function renderExportButton(data){
  $("#generateExport").removeAttr('hidden');
  ajaxExport(data);
}

function ajaxExport(data){
  $('#generateExport').click(function(e) {
    e.preventDefault();

    var attrs     = collectAttrsFrom(this);
    var json_data = data;
    
    $.ajax({
      type: attrs.method,
      url:  attrs.action,
      data: json_data,
      success: function(result) {
        window.open(result.link);
      }
    });
  });
};

function ajaxCalc(){
  $("#calcDistribution").submit( function(e){
    e.preventDefault();

    var attrs     = collectAttrsFrom(this)
    var json_data = convertFormToJSON(this);

    $.ajax({
      type: attrs.method,
      url:  attrs.action,
      data: json_data,
      success: function(result) {
        renderExportButton(result);
        renderChart(result);
      }
    });
  });
};


$(document).ready(function() {
  ajaxCalc();
});
