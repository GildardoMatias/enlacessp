<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <h1 id="myText"></h1>
    <script type="text/javascript" src="https://siegeest.app/API/Centinela/uploads/myJSONFile.json">
setInterval(function() {
            var d = JSON.parse(data);

            //fetch('http://localhost/API/server.php', {
            /*fetch('https://siegeest.app/API/Centinela/uploads/myJSONFile.json', {
                    method: 'get',
                    // may be some code of fetching comes here
                }).then(function(response) {
                    if (response.status >= 200 && response.status < 300) {
                        d = response[0];
                        return response.text()
                    }
                    throw new Error(response.statusText)
                })
                .then(function(response) {
                    console.log(response);
                })*/
            document.getElementById("myText").innerHTML = d;
            //alert("Hello");
        }, 1000);</script>
    <script>
        
    </script>
</body>

</html>