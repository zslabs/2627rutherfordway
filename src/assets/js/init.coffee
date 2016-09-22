(($) ->
  "use strict"

  ## Set multiple attributes for element
  setAttributes = (el, attrs) ->
    Array::slice.call(attrs).forEach (attr) ->
      el.setAttribute attr.name, attr.value unless attr.name is "data-bt-icon"
      return
    return

  Array::forEach.call document.querySelectorAll("[data-bt-icon]"), (element, index) ->
    svg = document.createElementNS 'http://www.w3.org/2000/svg', 'svg'
    setAttributes svg, element.attributes

    use = document.createElementNS('http://www.w3.org/2000/svg', 'use')
    use.setAttributeNS(
      'http://www.w3.org/1999/xlink',
      'xlink:href',
      window.svgSpritePath + '#' + element.getAttribute "data-bt-icon"
    )

    svg.appendChild use
    element.parentNode.replaceChild svg, element
    return

  # Placeholder
  $('[placeholder]').placeholder()

  # Photo Gallery
  $('.js-gallery').slick
    slidesToShow: 1
    slidesToScroll: 1
    arrows: true
    fade: true
    lazyLoad: 'ondemand'
    asNavFor: '.js-gallery__nav'

  $('.js-gallery__nav').slick
    mobileFirst: true
    arrows: false
    slidesToShow: 3
    slidesToScroll: 1
    lazyLoad: 'ondemand'
    asNavFor: '.js-gallery'
    dots: false
    draggable: false
    centerMode: true
    focusOnSelect: true
    responsive: [
      {
        breakpoint: 768
        settings:
          slidesToShow: 4
      }
      {
        breakpoint: 960
        settings:
          slidesToShow: 5
      }
    ]

  # Map
  # https://snazzymaps.com/style/42/apple-maps-esque

  init = ->
    # Basic options for a simple Google Map
    # For more options see: https://developers.google.com/maps/documentation/javascript/reference#MapOptions
    mapOptions =
      scrollwheel: false
      zoom: 14
      center: new (google.maps.LatLng)(listingConfig.coordinates.lattitude, listingConfig.coordinates.longitude)
      styles: [
        {
          'featureType': 'landscape.man_made'
          'elementType': 'geometry'
          'stylers': [ { 'color': '#f7f1df' } ]
        }
        {
          'featureType': 'landscape.natural'
          'elementType': 'geometry'
          'stylers': [ { 'color': '#d0e3b4' } ]
        }
        {
          'featureType': 'landscape.natural.terrain'
          'elementType': 'geometry'
          'stylers': [ { 'visibility': 'off' } ]
        }
        {
          'featureType': 'poi'
          'elementType': 'labels'
          'stylers': [ { 'visibility': 'off' } ]
        }
        {
          'featureType': 'poi.business'
          'elementType': 'all'
          'stylers': [ { 'visibility': 'off' } ]
        }
        {
          'featureType': 'poi.medical'
          'elementType': 'geometry'
          'stylers': [ { 'color': '#fbd3da' } ]
        }
        {
          'featureType': 'poi.park'
          'elementType': 'geometry'
          'stylers': [ { 'color': '#bde6ab' } ]
        }
        {
          'featureType': 'road'
          'elementType': 'geometry.stroke'
          'stylers': [ { 'visibility': 'off' } ]
        }
        {
          'featureType': 'road'
          'elementType': 'labels'
          'stylers': [ { 'visibility': 'off' } ]
        }
        {
          'featureType': 'road.highway'
          'elementType': 'geometry.fill'
          'stylers': [ { 'color': '#ffe15f' } ]
        }
        {
          'featureType': 'road.highway'
          'elementType': 'geometry.stroke'
          'stylers': [ { 'color': '#efd151' } ]
        }
        {
          'featureType': 'road.arterial'
          'elementType': 'geometry.fill'
          'stylers': [ { 'color': '#ffffff' } ]
        }
        {
          'featureType': 'road.local'
          'elementType': 'geometry.fill'
          'stylers': [ { 'color': 'black' } ]
        }
        {
          'featureType': 'transit.station.airport'
          'elementType': 'geometry.fill'
          'stylers': [ { 'color': '#cfb2db' } ]
        }
        {
          'featureType': 'water'
          'elementType': 'geometry'
          'stylers': [ { 'color': '#a2daf2' } ]
        }
      ]
    # Get the HTML DOM element that will contain your map
    # We are using a section with id="map" seen below in the <body>
    mapElement = document.getElementById('map')
    # Create the Google Map using our element and options defined above
    map = new (google.maps.Map)(mapElement, mapOptions)
    # Let's also add a marker while we're at it
    marker = new (google.maps.Marker)(
      position: new (google.maps.LatLng)(listingConfig.coordinates.lattitude, listingConfig.coordinates.longitude)
      map: map
      title: 'Snazzy!')
    return

  google.maps.event.addDomListener window, 'load', init

  # Recalculate UIkit sticky component placeholder on resize
  # Doing it here until > 2.17.0 is released
  reCheckSticky = ->
    $.each $('.uk-sticky-placeholder'), (index, val) ->
      $instance = $(val)
      $instance.css 'height', $instance.children().outerHeight()
      return
    return
  $(window).on 'resize', UIkit.Utils.debounce(reCheckSticky, 200)

  return
) jQuery
