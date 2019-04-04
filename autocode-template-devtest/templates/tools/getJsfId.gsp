<%

  def jsfIds = []

 data.content.data.data.each{
     item ->
     jsfIds.add(item.interfaceId)
     println item.interfaceId +"\t"+  item.interfaceName;
 }


  println jsfIds;
%>