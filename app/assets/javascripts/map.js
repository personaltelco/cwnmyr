/* global Gmaps */

function displayMap (data) {
  var handler = Gmaps.build('Google')

  function displayPosition (position) {
    var marker = handler.addMarker({
      lat: position.coords.latitude,
      lng: position.coords.longitude,
      picture: {
        url: window.location.protocol + '//' + window.location.host + '/assets/position_small.png',
        width: 32,
        height: 32
      },
      infowindow: 'You Are Here'
    })
    if ($('#map').data('center')) {
      handler.map.centerOn(marker)
    }
  }

  handler.buildMap({provider: {zoom: 17}, internal: {id: 'map'}}, function () {
    var markers = handler.addMarkers(data)
    handler.bounds.extendWith(markers)
    if (markers.length > 1) {
      handler.fitMapToBounds()
    } else {
      handler.map.centerOn(markers[0])
    }

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(displayPosition)
    }
  })
}

function handleError (error) {
  console.log(error.responseText)
}

$(document).ready(function () {
  var mapDiv = $('#map')
  if (!mapDiv.length) {
    return
  }

  var node = mapDiv.data('node')
  var zone = mapDiv.data('zone')
  var path = null
  if (node) {
    path = '/nodes/' + node + '/markers'
  } else if (zone) {
    path = '/zones/' + zone + '/markers'
  } else {
    path = '/markers'
  }

  $.ajax({
    url: path,
    dataType: 'json'
  }).done(displayMap).fail(handleError)
})
