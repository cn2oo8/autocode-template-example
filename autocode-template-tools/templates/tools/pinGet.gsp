<%

 data.hits.hits.each{
     item ->
     def dto = item._source
     println dto.bPin
 }

%>