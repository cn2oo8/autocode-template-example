<%
   data.hits.hits
   data.hits.hits.each{
      item ->
         def dto = item._source
         println dto.groupLeaderId+"\t"+dto.pin;
   }

%>
