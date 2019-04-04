<%

    def sum = new BigDecimal(0);
    java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    data.data.result.each {
        item ->
            def amount = item.amount
            println amount + "\t" + simpleDateFormat.format(new Date(item.deliverTime));
            sum = sum.add(new BigDecimal(amount+""))
    }

    println "total is:" + sum

%>