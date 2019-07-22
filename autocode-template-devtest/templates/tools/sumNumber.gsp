<%
  def sum = new BigDecimal(0);
  data.each{ it->
      if(StringUtils.isNotEmpty(it)){
          sum =sum.add(new BigDecimal(it));
      }
  }
    println sum;

%>