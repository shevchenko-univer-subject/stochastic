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
  const ctx =  $("#chartSpace").find('canvas');

  new Chart(ctx, {
    type: 'bar',
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
      legend: {
        display: false,
      },
      scales: {
        yAxes: [{
          display: true,
          ticks: {
            beginAtZero: true,
            steps: 10,
            stepValue: 5,
            max: 1
          }
        }]
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
        window.fetch(result.link).then(response => response.blob())
        .then(blob => {
            var url = window.URL.createObjectURL(blob);
            var a = document.createElement('a');
            a.href = url;
            a.download = result.name;
            document.body.appendChild(a);
            a.click();    
            a.remove();
        });
      }
    });
  });
};

function buildQuality(quality) {
  var response = ''

  if( quality == true ){ response = 'okey'; } 
  else { response = 'bad'; }

  return response;
}

function renderInfo(data) {
  $("#infoExMean").text(data.expect_mean);
  $("#infoAcMean").text(data.actual_mean);
  $("#infoVariance").text(data.variance);
  $("#infoMistake").text(data.mistake);
  $("#infoDelta").text(data.delta);
  $("#infoBorder").text(data.border);
  $("#infoQuality").text(buildQuality(data.quality));
  $("#infoPdfS").text(data.pdf.success);
  $("#infoPdfF").text(data.pdf.failure);

  $("#distInfo").removeAttr('hidden');
}

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
        renderInfo(result.meta);
        renderChart(result.chart);
      }
    });
  });
};


$(document).ready(function() {
  ajaxCalc();
});
