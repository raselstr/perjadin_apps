import json
from django import forms
from django.forms.widgets import Widget
from django.utils.html import format_html


class GeoMapLibreWidget(Widget):
    """
    Custom Django form widget for selecting geographic coordinates using MapLibre GL JS.
    
    Displays an interactive map with:
    - Marker placement by clicking on the map
    - Location search using Nominatim API (OpenStreetMap)
    - "Use Current Location" button for geolocation
    - "Clear Marker" button to reset coordinates
    - Auto-update of hidden latitude/longitude input fields
    
    Attributes:
        default_lat: Default latitude (Indonesia center)
        default_lng: Default longitude (Indonesia center)
        zoom_level: Default zoom level for the map
        search_countrycodes: Country codes to restrict search (default: 'id' for Indonesia)
    """
    
    template_name = 'widgets/maplibre_widget.html'
    default_lat = -2.5489
    default_lng = 118.0149
    zoom_level = 4
    search_countrycodes = 'id'
    
    class Media:
        css = {
            'all': (
                'https://cdn.jsdelivr.net/npm/maplibre-gl/dist/maplibre-gl.css',
            )
        }
        js = (
            'https://cdn.jsdelivr.net/npm/maplibre-gl/dist/maplibre-gl.js',
        )
    
    def __init__(self, attrs=None, default_lat=None, default_lng=None, zoom_level=None, search_countrycodes=None):
        super().__init__(attrs)
        self.default_lat = default_lat if default_lat is not None else self.default_lat
        self.default_lng = default_lng if default_lng is not None else self.default_lng
        self.zoom_level = zoom_level if zoom_level is not None else self.zoom_level
        self.search_countrycodes = search_countrycodes if search_countrycodes is not None else self.search_countrycodes
    
    def get_context(self, name, value, attrs):
        """
        Parse the stored value which should be a comma-separated 'lat,lng' string.
        """
        context = super().get_context(name, value, attrs)
        
        lat, lng = None, None
        if value:
            try:
                parts = str(value).split(',')
                if len(parts) == 2:
                    lat = float(parts[0].strip())
                    lng = float(parts[1].strip())
            except (ValueError, AttributeError):
                pass
        
        context['widget']['default_lat'] = self.default_lat
        context['widget']['default_lng'] = self.default_lng
        context['widget']['zoom_level'] = self.zoom_level
        context['widget']['marker_lat'] = lat
        context['widget']['marker_lng'] = lng
        context['widget']['search_countrycodes'] = self.search_countrycodes
        
        return context
    
    def render(self, name, value, attrs=None, renderer=None):
        """
        Render the widget with the map container and JavaScript.
        """
        context = self.get_context(name, value, attrs)
        widget = context['widget']
        
        final_attrs = self.build_attrs(attrs or {}, {'type': 'hidden', 'name': name})
        final_attrs_str = ' '.join(f'{k}="{v}"' for k, v in final_attrs.items())
        
        # Generate unique IDs for this widget instance
        widget_id = final_attrs.get('id', f'id_{name}')
        map_id = f'{widget_id}_map'
        search_input_id = f'{widget_id}_search'
        lat_input_id = f'{widget_id}_lat'
        lng_input_id = f'{widget_id}_lng'
        
        marker_lat = widget.get('marker_lat')
        marker_lng = widget.get('marker_lng')
        center_lat = marker_lat if marker_lat is not None else widget['default_lat']
        center_lng = marker_lng if marker_lng is not None else widget['default_lng']
        
        # Determine initial zoom - higher zoom if marker is set
        initial_zoom = 10 if marker_lat is not None else widget['zoom_level']
        
        html = format_html(
            """
            <div class="maplibre-widget-container">
                <style>
                    .maplibre-widget-container {{
                        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
                    }}
                    
                    #{map_id} {{
                        width: 100%;
                        height: 400px;
                        border: 1px solid #ddd;
                        border-radius: 4px;
                        margin-bottom: 10px;
                    }}
                    
                    .maplibre-widget-controls {{
                        margin-bottom: 10px;
                        display: flex;
                        flex-wrap: wrap;
                        gap: 10px;
                    }}
                    
                    .maplibre-search-box {{
                        flex: 1;
                        min-width: 200px;
                        display: flex;
                        gap: 5px;
                    }}
                    
                    .maplibre-search-box input {{
                        flex: 1;
                        padding: 8px 12px;
                        border: 1px solid #ddd;
                        border-radius: 4px;
                        font-size: 14px;
                    }}
                    
                    .maplibre-search-box input:focus {{
                        outline: none;
                        border-color: #80bdff;
                        box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
                    }}
                    
                    .maplibre-search-results {{
                        position: absolute;
                        background: white;
                        border: 1px solid #ddd;
                        border-radius: 4px;
                        max-height: 200px;
                        overflow-y: auto;
                        z-index: 1000;
                        width: 100%;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                        display: none;
                    }}
                    
                    .maplibre-search-results.active {{
                        display: block;
                    }}
                    
                    .search-result-item {{
                        padding: 10px 12px;
                        border-bottom: 1px solid #f0f0f0;
                        cursor: pointer;
                        font-size: 13px;
                    }}
                    
                    .search-result-item:hover {{
                        background-color: #f8f9fa;
                    }}
                    
                    .search-result-item:last-child {{
                        border-bottom: none;
                    }}
                    
                    .maplibre-buttons {{
                        display: flex;
                        flex-wrap: wrap;
                        gap: 5px;
                    }}
                    
                    .maplibre-btn {{
                        padding: 8px 16px;
                        border: 1px solid #ddd;
                        border-radius: 4px;
                        background-color: #fff;
                        color: #333;
                        cursor: pointer;
                        font-size: 14px;
                        transition: all 0.2s ease;
                    }}
                    
                    .maplibre-btn:hover {{
                        background-color: #f8f9fa;
                        border-color: #adb5bd;
                    }}
                    
                    .maplibre-btn:active {{
                        background-color: #e9ecef;
                    }}
                    
                    .maplibre-btn.primary {{
                        background-color: #007bff;
                        color: white;
                        border-color: #007bff;
                    }}
                    
                    .maplibre-btn.primary:hover {{
                        background-color: #0056b3;
                        border-color: #0056b3;
                    }}
                    
                    .maplibre-btn.danger {{
                        background-color: #dc3545;
                        color: white;
                        border-color: #dc3545;
                    }}
                    
                    .maplibre-btn.danger:hover {{
                        background-color: #c82333;
                        border-color: #c82333;
                    }}
                    
                    .maplibre-coordinates {{
                        margin-top: 10px;
                        padding: 10px;
                        background-color: #f8f9fa;
                        border-radius: 4px;
                        font-size: 13px;
                        font-family: 'Courier New', monospace;
                        display: none;
                    }}
                    
                    .maplibre-coordinates.active {{
                        display: block;
                    }}
                    
                    .maplibre-coordinates-label {{
                        font-weight: 600;
                        color: #495057;
                        margin-bottom: 5px;
                    }}
                    
                    .maplibre-coordinates-row {{
                        display: flex;
                        justify-content: space-between;
                        gap: 20px;
                    }}
                    
                    .maplibre-coordinates-item {{
                        flex: 1;
                    }}
                    
                    .maplibre-coordinates-item label {{
                        display: block;
                        font-size: 11px;
                        color: #6c757d;
                        font-weight: 500;
                        margin-bottom: 2px;
                    }}
                    
                    .maplibre-coordinates-item value {{
                        display: block;
                        font-size: 13px;
                        color: #212529;
                    }}
                    
                    .maplibre-search-box-wrapper {{
                        position: relative;
                        flex: 1;
                        min-width: 200px;
                    }}
                    
                    .maplibre-btn:disabled {{
                        opacity: 0.6;
                        cursor: not-allowed;
                    }}
                    
                    .maplibre-loading {{
                        display: none;
                        color: #6c757d;
                        font-size: 12px;
                        margin-left: 5px;
                    }}
                    
                    .maplibre-loading.active {{
                        display: inline;
                    }}
                </style>
                
                <div class="maplibre-widget-controls">
                    <div class="maplibre-search-box-wrapper">
                        <input 
                            type="text" 
                            id="{search_input_id}" 
                            class="maplibre-search-box-input"
                            placeholder="Search for a location..."
                            autocomplete="off"
                        />
                        <div id="{search_input_id}_results" class="maplibre-search-results"></div>
                    </div>
                    <div class="maplibre-buttons">
                        <button type="button" class="maplibre-btn primary" id="{widget_id}_locate_btn">
                            📍 Use Current Location
                        </button>
                        <button type="button" class="maplibre-btn danger" id="{widget_id}_clear_btn">
                            ✕ Clear Marker
                        </button>
                    </div>
                </div>
                
                <div id="{map_id}" class="maplibre-map"></div>
                
                <div class="maplibre-coordinates" id="{widget_id}_coords">
                    <div class="maplibre-coordinates-label">Selected Coordinates:</div>
                    <div class="maplibre-coordinates-row">
                        <div class="maplibre-coordinates-item">
                            <label>Latitude</label>
                            <value id="{lat_input_id}_display">-</value>
                        </div>
                        <div class="maplibre-coordinates-item">
                            <label>Longitude</label>
                            <value id="{lng_input_id}_display">-</value>
                        </div>
                    </div>
                </div>
                
                <input {attrs_str} value="{value}" />
                <input type="hidden" id="{lat_input_id}" />
                <input type="hidden" id="{lng_input_id}" />
            </div>
            
            <script>
            (function() {{
                'use strict';
                
                const mapContainer = document.getElementById('{map_id}');
                const searchInput = document.getElementById('{search_input_id}');
                const searchResults = document.getElementById('{search_input_id}_results');
                const locateBtn = document.getElementById('{widget_id}_locate_btn');
                const clearBtn = document.getElementById('{widget_id}_clear_btn');
                const mainInput = document.querySelector('input[name="{name}"]');
                const latDisplay = document.getElementById('{lat_input_id}_display');
                const lngDisplay = document.getElementById('{lng_input_id}_display');
                const coordsContainer = document.getElementById('{widget_id}_coords');
                const latInput = document.getElementById('{lat_input_id}');
                const lngInput = document.getElementById('{lng_input_id}');
                
                let map, marker;
                let markerLat = {marker_lat_json};
                let markerLng = {marker_lng_json};
                
                // Initialize map
                function initMap() {{
                    maplibregl.accessToken = '';
                    const centerLat = markerLat !== null ? markerLat : {center_lat};
                    const centerLng = markerLng !== null ? markerLng : {center_lng};
                    const zoom = markerLat !== null ? 10 : {initial_zoom};
                    
                    map = new maplibregl.Map({{
                        container: '{map_id}',
                        style: 'https://demotiles.maplibre.org/style.json',
                        center: [centerLng, centerLat],
                        zoom: zoom
                    }});
                    
                    map.on('click', function(e) {{
                        const lat = e.lngLat.lat;
                        const lng = e.lngLat.lng;
                        placeMarker(lat, lng);
                    }});
                    
                    // Load existing marker if available
                    if (markerLat !== null && markerLng !== null) {{
                        placeMarker(markerLat, markerLng);
                    }}
                    
                    map.addControl(new maplibregl.NavigationControl());
                }
                
                // Place or update marker
                function placeMarker(lat, lng) {{
                    markerLat = lat;
                    markerLng = lng;
                    
                    if (marker) {{
                        marker.remove();
                    }}
                    
                    const el = document.createElement('div');
                    el.className = 'maplibre-marker';
                    el.style.cssText = `
                        width: 40px;
                        height: 40px;
                        background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%23ff0000"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/></svg>') center/contain no-repeat;
                        cursor: pointer;
                    `;
                    
                    marker = new maplibregl.Marker({{element: el}})
                        .setLngLat([lng, lat])
                        .addTo(map);
                    
                    // Pan to marker
                    map.flyTo({{
                        center: [lng, lat],
                        zoom: 10,
                        duration: 1000
                    }});
                    
                    updateMainInput(lat, lng);
                    updateCoordinateDisplay(lat, lng);
                }}
                
                // Update main hidden input with lat,lng
                function updateMainInput(lat, lng) {{
                    const value = lat.toFixed(6) + ',' + lng.toFixed(6);
                    mainInput.value = value;
                    latInput.value = lat.toFixed(6);
                    lngInput.value = lng.toFixed(6);
                    
                    // Trigger change event for form validation
                    const event = new Event('change', {{ bubbles: true }});
                    mainInput.dispatchEvent(event);
                }}
                
                // Update coordinate display
                function updateCoordinateDisplay(lat, lng) {{
                    latDisplay.textContent = lat.toFixed(6);
                    lngDisplay.textContent = lng.toFixed(6);
                    coordsContainer.classList.add('active');
                }}
                
                // Search for location using Nominatim
                function searchLocation(query) {{
                    if (!query.trim()) {{
                        searchResults.innerHTML = '';
                        searchResults.classList.remove('active');
                        return;
                    }}
                    
                    const params = new URLSearchParams({{
                        q: query,
                        format: 'json',
                        countrycodes: '{search_countrycodes}',
                        limit: 10
                    }});
                    
                    fetch('https://nominatim.openstreetmap.org/search?' + params)
                        .then(response => response.json())
                        .then(data => {{
                            searchResults.innerHTML = '';
                            
                            if (data.length === 0) {{
                                searchResults.innerHTML = '<div class="search-result-item">No results found</div>';
                                searchResults.classList.add('active');
                                return;
                            }}
                            
                            data.forEach(result => {{
                                const item = document.createElement('div');
                                item.className = 'search-result-item';
                                item.textContent = result.display_name;
                                item.onclick = function() {{
                                    const lat = parseFloat(result.lat);
                                    const lng = parseFloat(result.lon);
                                    placeMarker(lat, lng);
                                    searchInput.value = '';
                                    searchResults.innerHTML = '';
                                    searchResults.classList.remove('active');
                                }};
                                searchResults.appendChild(item);
                            }});
                            
                            searchResults.classList.add('active');
                        }})
                        .catch(error => {{
                            console.error('Search error:', error);
                            searchResults.innerHTML = '<div class="search-result-item">Error searching locations</div>';
                            searchResults.classList.add('active');
                        }});
                }}
                
                // Event listeners
                searchInput.addEventListener('input', function(e) {{
                    const query = e.target.value;
                    if (query.length > 2) {{
                        searchLocation(query);
                    }} else {{
                        searchResults.innerHTML = '';
                        searchResults.classList.remove('active');
                    }}
                }});
                
                locateBtn.addEventListener('click', function(e) {{
                    e.preventDefault();
                    if (navigator.geolocation) {{
                        locateBtn.disabled = true;
                        navigator.geolocation.getCurrentPosition(
                            function(position) {{
                                const lat = position.coords.latitude;
                                const lng = position.coords.longitude;
                                placeMarker(lat, lng);
                                locateBtn.disabled = false;
                            }},
                            function(error) {{
                                console.error('Geolocation error:', error);
                                alert('Unable to access your location. Please check browser permissions.');
                                locateBtn.disabled = false;
                            }}
                        );
                    }} else {{
                        alert('Geolocation is not supported by your browser');
                    }}
                }});
                
                clearBtn.addEventListener('click', function(e) {{
                    e.preventDefault();
                    markerLat = null;
                    markerLng = null;
                    
                    if (marker) {{
                        marker.remove();
                        marker = null;
                    }}
                    
                    mainInput.value = '';
                    latInput.value = '';
                    lngInput.value = '';
                    latDisplay.textContent = '-';
                    lngDisplay.textContent = '-';
                    coordsContainer.classList.remove('active');
                    
                    // Trigger change event
                    const event = new Event('change', {{ bubbles: true }});
                    mainInput.dispatchEvent(event);
                    
                    // Pan back to default center
                    map.flyTo({{
                        center: [{center_lng}, {center_lat}],
                        zoom: {initial_zoom},
                        duration: 1000
                    }});
                }});
                
                // Close search results when clicking outside
                document.addEventListener('click', function(e) {{
                    if (!e.target.closest('.maplibre-search-box-wrapper')) {{
                        searchResults.classList.remove('active');
                    }}
                }});
                
                // Initialize map when document is ready
                if (document.readyState === 'loading') {{
                    document.addEventListener('DOMContentLoaded', initMap);
                }} else {{
                    initMap();
                }}
            }})();
            </script>
            """,
            map_id=map_id,
            search_input_id=search_input_id,
            widget_id=widget_id,
            lat_input_id=lat_input_id,
            lng_input_id=lng_input_id,
            name=name,
            value=value or '',
            attrs_str=final_attrs_str,
            marker_lat_json='null' if marker_lat is None else marker_lat,
            marker_lng_json='null' if marker_lng is None else marker_lng,
            center_lat=center_lat,
            center_lng=center_lng,
            initial_zoom=initial_zoom,
            search_countrycodes=self.search_countrycodes
        )
        
        return html
