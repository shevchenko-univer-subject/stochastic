function convertFormToJSON(form) {
  const array = $(form).serializeArray(); // Encodes the set of form elements as an array of names and values.
  const json = {};
  $.each(array, function () {
    json[this.name] = this.value || "";
  });
  return json;
};

function collectExportData(dom) {
  var x = $(dom).data('x');
  var y = $(dom).data('y');

  return {
    'x': x,
    'y': y
  };
}

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

function buildExportButton(data) {
  const domButton = 
    "<button "
    + "method='post' "
    + "action='/export/create' "
    + "id='generateExport' "
    + "class='btn btn-lg btn-primary col-6' "
    + "data-x='" + data.x + "' " 
    + "data-y='" + data.y + "' "
    + ">Export CSV</button>"
  return domButton;
};

function renderExportButton(data){
  const exportButton = buildExportButton(data);
  $("#exportSpace").replaceWith(exportButton);
  ajaxExport();
}


function ajaxExport(){
  $('#generateExport').click(function(e) {
    e.preventDefault();

    var attrs     = collectAttrsFrom(this);
    var json_data = collectExportData(this);
    
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
