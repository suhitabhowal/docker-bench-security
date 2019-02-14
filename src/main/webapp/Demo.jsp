<html>
<head>
<style>ul{
    padding-inline-start: 30px;}
</style>
</head>
<script src = "json2.js"></script>

<script>

    //Example data, Object 
        var nestedTable_old = [{
	"Project": "DevSecOps",
        "Team Members": "<ul><li>Mohnish</li><li>Raghav</li><li>Mohan</li><li>Suhita</li><li>Harinath</li><li>Sunil</li><li>Satadal</li></ul>",
        "Tools/Technologies": {
            tableId: "tblIdNested1",
            tableClassName: "clsNested",
            linkText: "Download",
            data: [{
                
		SCM: "GIT",
		"Pre Code Scan": "Not Available : Possible vulnerabilities in application",
		CI: "Jenkins",
                Build: "Maven",
                "Security Scan":"Not Secured : Possible vulnerabilities in application",
		"Image Scan":"Not Secured : Possible vulnerabilities in docker image",
                "Deployment Platform":"Kubernetes"
            }]
        }
    }];

    
    //Example data, Array
    var stringArray = ["New York", "Berlin", "Paris", "Marrakech", "Moscow"];
    
    //Example data, nested Object. This data will create nested table also.
    var nestedTable_new = [{
	"Project": "DevSecOps",
        "Team Members": "<ul><li>Mohnish</li><li>Raghav</li><li>Mohan</li><li>Suhita</li><li>Harinath</li><li>Sunil</li><li>Satadal</li></ul>",
        "Tools/Technologies": {
            tableId: "tblIdNested1",
            tableClassName: "clsNested",
            linkText: "Download",
            data: [{
                
		SCM: "GIT",
		"Pre Code Scan": "GIT Secrets",
		CI: "Jenkins",
                Build: "Maven",
                "Security Scan":"OWASP",
		"Image Scan":"Docker Bench",
                "Deployment Platform":"Kubernetes"
            }]
        }
    }];

var jsonHtmlTable = ConvertJsonToTable(nestedTable_new , 'jsonTable', null, 'Download');

document.write("<center>");
document.write (jsonHtmlTable );
document.write("</center>");
document.getElementById("tbl").style.borderCollapse = "collapse";





</script>

</html>
