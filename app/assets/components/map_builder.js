/* global google */

function MapBuilder () {
  this.gBounds = null
  this.gInfoWindow = null
  this.gMap = null
  this.mapDiv = null
  this.statusCtrl = null
}

MapBuilder.prototype.initMap = function () {
  this.mapDiv = document.getElementById('map')
  if (!this.mapDiv) {
    return false
  }

  let request = new XMLHttpRequest()
  let me = this
  request.onreadystatechange = function () {
    if (request.readyState === XMLHttpRequest.DONE) {
      if (request.status === 200) {
        me.handleResponse(JSON.parse(request.responseText))
      } else {
        me.handleError(request)
      }
    }
  }
  request.open('GET', this.mapDiv.dataset.markers, true)
  request.send()
}

MapBuilder.prototype.handleError = function (error) {
  console.log(error.responseText)
}

MapBuilder.prototype.handleResponse = function (data) {
  this.gBounds = new google.maps.LatLngBounds()
  this.gInfoWindow = new google.maps.InfoWindow()
  this.gMap = new google.maps.Map(this.mapDiv, {
    maxZoom: 18,
    minZoom: 11,
    zoom: 17
  })

  this.statusCtrl = document.createElement('div')
  this.statusCtrl.style.background = '#fff'
  this.statusCtrl.style.border = '1px solid #000'
  this.statusCtrl.style.padding = '2px'

  let me = this
  let showBtn = document.createElement('input')
  showBtn.setAttribute('type', 'button')
  showBtn.setAttribute('value', 'show all')
  showBtn.onclick = function () {
    let boxes = me.statusCtrl.querySelectorAll('input[type="checkbox"]')
    for (let box of boxes) {
      if (!box.checked) {
        box.checked = true
        box.onchange()
      }
    }
  }

  let hideBtn = document.createElement('input')
  hideBtn.setAttribute('type', 'button')
  hideBtn.setAttribute('value', 'hide all')
  hideBtn.onclick = function () {
    let boxes = me.statusCtrl.querySelectorAll('input[type="checkbox"]')
    for (let box of boxes) {
      if (box.checked) {
        box.checked = false
        box.onchange()
      }
    }
  }

  this.statusCtrl.append(showBtn)
  this.statusCtrl.append(hideBtn)
  this.statusCtrl.append(document.createElement('br'))

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(this.handlePosition)
  }

  if (data.node) {
    this.renderNode(data.node)
  } else if (data.statuses) {
    for (let status of data.statuses) {
      this.renderStatus(status)
    }
    this.gMap.controls[google.maps.ControlPosition.TOP_RIGHT].push(
      this.statusCtrl)
  } else if (data.zone && data.zone.statuses) {
    for (let status of data.zone.statuses) {
      this.renderStatus(status)
    }
    this.gMap.controls[google.maps.ControlPosition.TOP_RIGHT].push(
      this.statusCtrl)
  }

  this.gMap.fitBounds(this.gBounds)
  this.gMap.panToBounds(this.gBounds)
}

MapBuilder.prototype.handlePosition = function (position) {
  let me = this
  let marker = new google.maps.Marker({
    icon: require('images/position_small.png'),
    map: this.gMap,
    position: new google.maps.LatLng(
      position.coords.latitude, position.coords.longitude),
    title: 'Current Location'
  })
  marker.addListener('click', function () {
    me.gInfoWindow.setContent('You Are Here')
    me.gInfoWindow.open(me.gMap, marker)
  })
  if (this.mapDiv.dataset.center) {
    this.gMap.setCenter(marker.position)
  }
}

MapBuilder.prototype.renderStatus = function (status) {
  let me = this

  let statusBox = document.createElement('input')
  statusBox.setAttribute('type', 'checkbox')
  let layer = new google.maps.MVCObject()
  statusBox.onchange = function () {
    layer.set('map', this.checked ? me.gMap : null)
  }
  statusBox.checked = status.default_display
  statusBox.onchange()

  let statusDiv = document.createElement('div')
  statusDiv.append(statusBox)
  statusDiv.append(' ')
  statusDiv.append(status.name)

  this.statusCtrl.append(statusDiv)

  for (let node of status.nodes) {
    let marker = this.renderNode(node)
    if (marker) {
      marker.bindTo('map', layer, 'map')
    }
  }
}

MapBuilder.prototype.renderNode = function (node) {
  if (!node.lat || !node.lng) {
    return false
  }

  let me = this
  let marker = new google.maps.Marker({
    map: this.gMap,
    position: new google.maps.LatLng(node.lat, node.lng),
    title: node.name
  })
  marker.addListener('click', function () {
    me.gInfoWindow.setContent(node.infowindow)
    me.gInfoWindow.open(me.gMap, marker)
  })
  this.gBounds.extend(marker.position)

  return marker
}

module.exports = MapBuilder