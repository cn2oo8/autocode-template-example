<%

 data.hits.hits.each{
     item ->
     def dto = item._source
     print dto.deliveryRegList.get(0).deliveryId+",";
 }

%>