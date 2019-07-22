<%
  data.each{ line->
      if(line.size()<3){
          return
      }
      println  line.get(1) + ":"+ line.get(2);
  }
%>