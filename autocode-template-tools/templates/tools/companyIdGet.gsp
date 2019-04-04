<%

 data.hits.hits.each{
     item ->
     def dto = item['_source']
      if(dto==null){
          dto = item['fields']
      }
     println dto.originalCompanyId.get(0);
 }

%>