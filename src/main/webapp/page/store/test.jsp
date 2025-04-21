<%-- 
    Document   : test
    Created on : 2025年4月21日, 下午3:57:25
    Author     : Wai Lim Fung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Geocode API Test</title>
</head>
<body>
  <h1>Geocode API Test</h1>
  <p>Coordinates for "Statue of Liberty NY US":</p>
  <div id="result">Loading...</div>

  <script>
    async function getLatLon() {
      const url = `https://geocode.maps.co/search?q=Statue+of+Liberty+NY+US&api_key=67d5b4de82adb390148517pahdfb5bd`;

      try {
        const response = await fetch(url);
        const data = await response.json();

        if (data && data.length > 0) {
          const lat = data[0].lat;
          const lon = data[0].lon;
          return [lat, lon];
        } else {
          return null;
        }
      } catch (error) {
        console.error("Error fetching data:", error);
        return null;
      }
    }

    // Call the function and display the result
    getLatLon().then(coords => {
      const resultDiv = document.getElementById('result');
      if (coords) {
        resultDiv.textContent = `Latitude: ${coords[0]}, Longitude: ${coords[1]}`;
      } else {
        resultDiv.textContent = 'No coordinates found or an error occurred.';
      }
    });
  </script>
</body>
</html>

